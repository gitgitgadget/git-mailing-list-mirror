From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 21:20:23 +1000
Message-ID: <BANLkTi=TEXffPsH3A1tdzFYTszE_Z4U1fw@mail.gmail.com>
References: <7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
	<4DB9329E.7000703@op5.se>
	<BANLkTikKp9-uFGLavBT0UA5+maV5xiEJZA@mail.gmail.com>
	<20110428111154.GA1433@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>, david@lang.hm,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 13:20:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFPGo-0000SF-Ok
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 13:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829Ab1D1LU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 07:20:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46728 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab1D1LUZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 07:20:25 -0400
Received: by eyx24 with SMTP id 24so789438eyx.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TeAHAXxGqWp/WYMamoEawN7IbPz3DlmnY51ZKw72ARU=;
        b=MWb3jlfTstxzAlIFnYYOTyD8Re62vudL4IbErGoqWcJ1vPAqbBCYBezvHBFMFKlSxh
         WnYEQnCHjEC3ok23UAcC64SwuAvCdhNSU2rw9K81PyDN+IVQM11GQedlw8DrUKrGWmL8
         BL3uksLVb/qjd4Hc1gzfSrxD7A5Bia92eg5jU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KMWQwOFGBcm4NlrzOazTfHFWqkkirHH9I9+9TlxiUlEZ1aGD//wqlUzBHZI1dHhlQ9
         6Xz6sSLCE/+lUZi/OL8wpAX1WDlvSltCfBTaX14RJ2BvKzafl/gyBfGK63hnUxxl7iuK
         ywGOX9QoDhUqCEk2Bf26PfqCmopdEET6ETFew=
Received: by 10.14.52.65 with SMTP id d41mr1621012eec.85.1303989624083; Thu,
 28 Apr 2011 04:20:24 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Thu, 28 Apr 2011 04:20:23 -0700 (PDT)
In-Reply-To: <20110428111154.GA1433@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172352>

On Thu, Apr 28, 2011 at 9:11 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Jon Seymour wrote:
>
>> What is so =C2=A0hard about:
>>
>> =C2=A0 app install plugin.
>>
>> Forget git. Forget git work.
>>
>> What is so hard about the concept of
> [...]
>
> Is it so important that the people on this list agree with you
> right away that your proposal is a great idea?
>
> You asked for comments, so people are giving them. =C2=A0But typicall=
y,
> the procedure might be something like:
>
> 1. person describes a problem they are solving, and perhaps a
> =C2=A0 proposed solution
>
> 2. people on the mailing list try to help out in figuring out the
> =C2=A0 parameters of the problem, giving relevant background about th=
e
> =C2=A0 tools available, and describing experiences they have had in t=
he
> =C2=A0 past that might help in solving it.
>
> 3. person reports on how it panned out. =C2=A0If this involved changi=
ng
> =C2=A0 git or is nicely documented, we might get a patch out of it. =C2=
=A0If
> =C2=A0 so:
>
> 4. people on the mailing list review the patch, considering how
> =C2=A0 useful it might be for their own nefarious ends, potential
> =C2=A0 downsides, and how maintainable it is.
>
> 5. at some point, some patches appear that seem to be a good idea,
> =C2=A0 and Junio applies them.
>
> And so forth. =C2=A0Notice how at no step everyone needs to agree.
>
> Earlier in this thread you mentioned that git needs some basic
> facilities to make a prototype of a command installer possible.
> But git already has those facilities. =C2=A0Even if the installed com=
mands
> should not be on the path, all you need to get a "git install"
> available on early adopters' machines is to put an executable at
> /usr/bin/git-install or ~/bin/git-install.
>
> So you can show people what they have missing, and once they can't
> live without it, maybe they'll clamor for its inclusion in git.git
> proper and distro packages. =C2=A0If that is your goal, getting somet=
hing
> working and helping interested people to try it out (and adding it
> to https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
> when ready) comes first.
>
> Sorry to spend so long on abstractions. =C2=A0Still, hope that helps.
>
> Regards,
> Jonathan
>

Agreed. I'll get coding. Thanks for the advice.

jon.
