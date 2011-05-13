From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 20/48] i18n: git-submodule die + eval_gettext messages
Date: Fri, 13 May 2011 11:04:52 +0200
Message-ID: <BANLkTim0VZ6-xbgZC0K=HXfVMaWehJ0pBA@mail.gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
 <1304857280-14773-21-git-send-email-avarab@gmail.com> <4DCB9592.2090503@viscovery.net>
 <BANLkTik98wsBvoHNtausLBw0F1FqdDhAuQ@mail.gmail.com> <4DCBECB5.5050502@viscovery.net>
 <BANLkTikM-FaArEA8QTy_MB9cODzwV_ER_g@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 11:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKoJD-0001ms-Qw
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 11:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab1EMJFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 05:05:15 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:43711 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436Ab1EMJFM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2011 05:05:12 -0400
Received: by pxi16 with SMTP id 16so1560065pxi.4
        for <git@vger.kernel.org>; Fri, 13 May 2011 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UN/p4pNkaU8Xg2X8sNw+JkZYJgUGBVOImu+o/hYnKYQ=;
        b=qYP2JtlVg4dYHE3zPXrHqBHAUfB6qU681/LVzfbxtLKNUqrquh7PuH2zwzWUquYWkh
         OAyqrobZS47sEqNS5wCd22yrVyWE7DOOJT3ektSSHYVPci9ri8LT2ZhcDM6QEmuT9Ij8
         rQa3jeRAItulNVp1AEsY1L99QS1w3hXJ2J4Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Nipx/dXDowHgdvi2aAuomQLvgVJA5rX9heZY6+3pydzQ2vHR3bFQv9GQhZ+0HwTGpm
         E5hRRS6pClTawz1D4G/kn4zK/5puQn2rWdogeLJIT7NzXS4l74pKZ8giWuqyUmiNoeL5
         OyAvO1wt7W73/Gy/wo3DcLs1SaOcUwfikQbUU=
Received: by 10.68.56.33 with SMTP id x1mr1832731pbp.516.1305277512118; Fri,
 13 May 2011 02:05:12 -0700 (PDT)
Received: by 10.68.40.130 with HTTP; Fri, 13 May 2011 02:04:52 -0700 (PDT)
In-Reply-To: <BANLkTikM-FaArEA8QTy_MB9cODzwV_ER_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173511>

On Fri, May 13, 2011 at 10:21 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, May 12, 2011 at 16:20, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>> Am 5/12/2011 15:48, schrieb =C6var Arnfj=F6r=F0 Bjarmason:
>>> On Thu, May 12, 2011 at 10:08, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
>>>> Am 5/8/2011 14:20, schrieb =C6var Arnfj=F6r=F0 Bjarmason:
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 say "Submodule '$name' ($url) registere=
d for path '$path'"
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 say "$(eval_gettext "Submodule '\$name'=
 (\$url) registered for path '\$path'")"
>>>>
>>>> On Windows, we have a problem with messages like this (and many ot=
hers)
>>>> that reference $path. eval_gettext has to export 'path', but on Wi=
ndows
>>>> environment variables are case-insensitive. In the substitution, t=
his
>>>> happens to pick the value of 'PATH' rather than of 'path'... Can y=
ou do
>>>> something about this?
>>>>
>>>> Of course, the problem is not limited to 'path' at all, but it is =
a
>>>> prominent example discovered by the test suite.
>>>
>>> I didn't know Windows had that limitation. We can easily work aroun=
d
>>> it by just renaming $path to something else (e.g. $filepath).
>>>
>>> Since we do:
>>>
>>> =A0 =A0 export PATH $(git sh-i18n--envsubst --variables "$1");
>>>
>>> I assume this problem only occurs with variables that match
>>> /^path$/i. Or are there other problems on Windows?
>>
>> It is *not* limited to PATH. There can be other variables in the
>> environment that are the same name as some that are exported in this
>> statement. Here's a brief test:
>>
>> --- 8< ---
>> $ cat git-test
>> #!/bin/sh
>>
>> . git-sh-setup
>> . git-sh-i18n
>>
>> AppData=3Dmyappdata
>> username=3DmyUserName
>> proMPT=3Dmyprompt
>>
>> echo "$(eval_gettext "AppData: '\$AppData'
>> username: \$username
>> proMPT: \$proMPT
>> path: '\$path'")"
>>
>> $ git --exec-path=3D. test
>> AppData: 'C:\Dokumente und Einstellungen\jsixt\Anwendungsdaten'
>> username: jsixt
>> proMPT: $P$G
>> path:
>> 'd:/Src/mingw-git/.;d:\Src\mingw-git;d:\Src\mingw-git\;d:\Src\mingw-=
git;...snip...;.'
>> --- 8< ---
>
> That's interesting. I thought that the problem would only be with
> PATH, since we'd clobber the other environment variables when we do
> the export in git-sh-i18n.
>
> But evidently not, but I don't quite grok why.
>
> Anyway, this behavior seems un-POSIX compliant, and I'd been assuming
> that our shell scripts were POSIX shellscripts when I wrote this.

May I remind you of the first rule in Documentation/CodingGuidelines?

 - Most importantly, we never say "It's in POSIX; we'll happily
   ignore your needs should your system not conform to it."
   We live in the real world.
