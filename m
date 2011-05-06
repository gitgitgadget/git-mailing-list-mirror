From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sat, 7 May 2011 00:07:14 +1000
Message-ID: <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
References: <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
	<4DB9329E.7000703@op5.se>
	<88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
	<7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 16:07:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QILgh-000321-TV
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 16:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab1EFOHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 10:07:16 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34859 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab1EFOHP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 10:07:15 -0400
Received: by gxk21 with SMTP id 21so1191165gxk.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gChGw1ZefDsdm1iDvLBjCe1Wg8SotP15tOGquMQujcM=;
        b=dwXL/aFytVrxn/sjnViMaKqa5Zcq4IlD9pS87Gz/IsOLCvtOsh11FYs9wKfrS3ZEPV
         ngVEm2M2fZJxf3Kwnx/7+isy411amFM2pxzP6b3trpzTk/UnjAS/PnXMy3hRTi1YkhDs
         T11XUTyutFaxqhe9QQUwUMRbsNXeYoUpN4cP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CW6NrNIW9x3AuS/ZyvMYrzOPYlbnq5RHZh8eFiAJykf7cAudOabd29TcYLGU45QOci
         IxNkG1OG+IMB0xEIqmppecNE99GFcLfJR9bfNg48BVFq7fI8ABE/pIjGXHzODOCeO8vK
         8s1fEmGAK3S1tTtW/f0U6jJxIVHP8/gFUUU3U=
Received: by 10.52.177.196 with SMTP id cs4mr1003944vdc.279.1304690834144;
 Fri, 06 May 2011 07:07:14 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Fri, 6 May 2011 07:07:14 -0700 (PDT)
In-Reply-To: <20110506065601.GB13351@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172974>

On Fri, May 6, 2011 at 4:56 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Jon Seymour wrote:
>
>> I would appreciate any feedback you (or others) have about:
>>
>> =C2=A0 =C2=A0 http://permalink.gmane.org/gmane.comp.version-control.=
git/172419
>>
>> In particular, I would be interested in feedback about how to best s=
upport:
>>
>> - multiple extensions - do we want support installing extensions in
>> their own directories, per Pau's suggestion or simply allow them to
>> write to a common directory?
>> - multiple extension directories - how to support Jonathan's
>> requirement to allow user specific extension directories?
>
> Well, let's step back for a moment. =C2=A0What problem are we solving=
?
> I still don't even know the answer to that!
>

Jonathan,

Thanks for your detailed reply.

I think the problem we are trying to solve is this: how to make it as
easy as possible to install, and get operational, an extension to git.

If git supported the concept of a standard place to put extensions,
then it could be as simple as:

    unzip -d $(git --plugins-dir) plugin.zip

with no need to configure or choose a prefix and no need to edit the
an .profile or .bashrc to permanently add a directory to the PATH.

If there is no post-installation configuration step, then it becomes
much easier to write an adhoc script that produces a working
environment that has the extension already operational.

The idea is that the person or distribution who(/which) installed git
onto the system has already made decisions about where artifacts
should go. Neither the user nor the extension author should have to
second guess or reverse engineer these decisions. Given that git has
been installed in X, then let's use convention to say that extensions
can install in X/lib/git-plugins/ (say) and then have git able to use
those extensions immediately with no additional configuration step
because this directory is already (effectively) in the PATH.

To the extent that a configuration step is necessary, post install, it
would be good if the configuration was limited to facilities that are
available in every git installation (e.g. git config --global).

jon.
