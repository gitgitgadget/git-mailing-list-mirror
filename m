From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: Accept-language test fails on Mac OS
Date: Sun, 7 Dec 2014 04:44:00 +0900
Message-ID: <CAFT+Tg_4EJ15CmujDtcubfw+0rr2J=pbjccqSSs9tmj-rz6+eQ@mail.gmail.com>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>
	<xmqqppbxogli.fsf@gitster.dls.corp.google.com>
	<CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>
	<5482D180.9010002@web.de>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 20:44:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxLGw-0007H0-Pl
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 20:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbaLFToD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 14:44:03 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:49006 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbaLFToB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 14:44:01 -0500
Received: by mail-qg0-f53.google.com with SMTP id q108so1947219qgd.40
        for <git@vger.kernel.org>; Sat, 06 Dec 2014 11:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=otBOu6Qui+fdvr/BG/prrH8kSRaCoV6yptFHaJMnjOg=;
        b=lW692PUSSvskhjf8dwngmeYaOxUZNXS+5rXpAvBqIBhzPCB0OoPoV2YPbL4z5b5fBO
         8HGS9TgdRIrfDsuOXQds2aNCIrk46CqMLLW8YiqulwEUb2XTLZog27UP/SJh1HrvropP
         Y9FH2e7/gxduPgxpzzsmQ+ni3jOnBTJjsvCoVVYUfW267CQrrZkCkcNtI5rj8AETgUfa
         R1j4AxoJNFCm7aQaq3NUblfDA9nx6WbRIJkV2I70vRt3MjogM+81hfEdcbZHxn6Rzqc5
         fobpyBARzYZIR+uJEpf9IUogwtmeLZ9iadC8P812cbCL8Fb5Ymgi/UFjDL7T1xyYe4kp
         gstA==
X-Received: by 10.224.51.11 with SMTP id b11mr35137560qag.43.1417895040819;
 Sat, 06 Dec 2014 11:44:00 -0800 (PST)
Received: by 10.140.86.163 with HTTP; Sat, 6 Dec 2014 11:44:00 -0800 (PST)
In-Reply-To: <5482D180.9010002@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260962>

Could you tell me your locale information from executing 'locale'
command and the verbose message you can get by accessing any git
repository via HTTP protocol? (e.g. GIT_CURL_VERBOSE=3D1 git clone
http://github.com/foo/bar )

I think the failures are related with your locale information.

On Sat, Dec 6, 2014 at 6:50 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2014-12-06 00.01, Michael Blume wrote:
>> On Fri, Dec 5, 2014 at 2:51 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Michael Blume <blume.mike@gmail.com> writes:
>>>
>>>> Test #25 'git client sends Accept-Language based on LANGUAGE, LC_A=
LL,
>>>> LC_MESSAGES and LANG' in t5550 fails consistently on my mac, and h=
as
>>>> since the test was introduced. Test 26 and 27 ('git client sends
>>>> Accept-Language with many preferred languages' and 'git client doe=
s
>>>> not send Accept-Language') seem fine.
>>>>
>>>> I'm building git with NO_GETTEXT=3D1, which may be an issue? But i=
n that
>>>> case the test should probably be gated on gettext?
>>>
>>> I recall queuing a SQUASH??? on top of the posted patch; does these
>>> tests pass with it reverted?
>>
>> The test fails both on pu and on 7567fad which is prior to the
>> SQUASH??? commit, so the squash does not seem to change anything.
> pu@c83418638e0c326f:
> t5550 fails here under Debian Linux,
> I haven't digged further
>
> not ok 25 - git client sends Accept-Language based on LANGUAGE, LC_AL=
L, LC_MESSAGES and LANG
> #
> #               check_language "ko-KR, *;q=3D0.1" ko_KR.UTF-8 de_DE.U=
TF-8 ja_JP.UTF-8 en_US.UTF-8 &&
> #               check_language "de-DE, *;q=3D0.1" ""          de_DE.U=
TF-8 ja_JP.UTF-8 en_US.UTF-8 &&
> #               check_language "ja-JP, *;q=3D0.1" ""          ""     =
     ja_JP.UTF-8 en_US.UTF-8 &&
> #               check_language "en-US, *;q=3D0.1" ""          ""     =
     ""          en_US.UTF-8
> #
>
