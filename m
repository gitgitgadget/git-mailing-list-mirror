From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [http] Git error messages reveal password encoded in the URL
Date: Tue, 20 Jul 2010 02:41:45 +0200
Message-ID: <201007200241.46972.jnareb@gmail.com>
References: <4C4484A4.5010009@gmail.com> <AANLkTilby7GWOuObh6W4z_caUG83O5A5Wh4Wb-JJnSdJ@mail.gmail.com> <4C44DEF7.4000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	git-dev <git@vger.kernel.org>
To: Ketan Padegaonkar <ketanpadegaonkar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 02:41:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob0uB-0005Y0-PI
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 02:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967226Ab0GTAlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 20:41:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38236 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458Ab0GTAlt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 20:41:49 -0400
Received: by bwz1 with SMTP id 1so2579826bwz.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 17:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6cgkJH9dPz0XbOOOvzPAqcmauqyjIt+vrJhQRtQLXqQ=;
        b=xB5s4pjFWr9FIikT1SMtkl2Xjy5De6UsfnwugqzmVdHxN0UlM6l4LfHcq0TSiqO04R
         BR7pkIGRQNKvK213UJ+n7kfBDNENJBaVf+82CDaZZbOAh1PUEQw2oHb9oF6b93fw0oPr
         HF4uyGbxdA8JrODz7etkg4dxjm7vSqDI/6+SI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QmxIQFQxHJdCVSlUiXxt9N150KntE3mGZYSoGC6MOm1jeKb0kcQudzKFPto6QgaUuG
         y+OQaXyzteiGqC28M7iygCPBnkLCzTpb2ESgsfwIFFYr8VSrNY+bfLE1lABMCToSjaGc
         53gCvXUmOJYKxhZ2H4XcevJlFyCTqDV13ZF00=
Received: by 10.204.177.202 with SMTP id bj10mr4553698bkb.198.1279586507252;
        Mon, 19 Jul 2010 17:41:47 -0700 (PDT)
Received: from [192.168.1.13] (abwh94.neoplus.adsl.tpnet.pl [83.8.231.94])
        by mx.google.com with ESMTPS id x19sm27513717bkv.9.2010.07.19.17.41.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 17:41:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C44DEF7.4000903@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151294>

Dnia wtorek 20. lipca 2010 01:25, Ketan Padegaonkar napisa=C5=82:
> On 7/19/10 2:16 PM, Jacob Helwig wrote:
>> On Mon, Jul 19, 2010 at 14:10, Jakub Narebski<jnareb@gmail.com>  wro=
te:
>>> Dnia poniedzia=C5=82ek 19. lipca 2010 23:05, Jacob Helwig napisa=C5=
=82:
>>>> On Mon, Jul 19, 2010 at 14:02, Jakub Narebski<jnareb@gmail.com>  w=
rote:
>>>>> Ketan Padegaonkar<ketanpadegaonkar@gmail.com>  writes:
>>>>>
>>>>>> We use http to serve our git repos, in order for git to not ask =
me a
>>>>>> username/password everytime,
>=20
> Apologies. I used the wrong punctuation. It should read as:
>=20
> We use https+basic auth to serve up git repos. Unfortunately SSH is n=
ot=20
> an option for various reasons.

Is it because of firewall, or it is the issue with issuing shell=20
accounts?  If the latter, you can use tools such as gitosis or gitolite
which need only one single shell account, and control access via public
key infrastructure.

>=20
> In order for git to not ask me the username/password, I 'encoded' the=
=20
> username/password into the url.

Can't you use ~/.netrc file[1] instead?  As far as I see this would not
show password info on error.  Not that the current situation should
not be fixed, but it might be worthwhile workaround for a time.

The ~/.netrc file would look like this for your example:

  machine host
  login user
  password pass

You should of course `chmod 600 ~/.netrc`

[1] This is unfortunately underdocumented: only this documentation
Documentation/howto/setup-git-server-over-http.txt mentions ~/.netrc
file.  I think that handling the $HOME/.netrc is done by the curl=20
library that git uses, see libcurl-tutorial(3) manpage.

> I'm using git v1.7.1.1 on MacOSX Leopard. I can see the same behavior=
 on=20
> master (rev 24e7a5).

--=20
Jakub Narebski
Poland
