From: Maximilian Held <maximilian.held83@gmail.com>
Subject: Re: git --recurse-submodule does not recurse to sub-submodules (etc.)
Date: Fri, 23 Jan 2015 23:02:34 +0100
Message-ID: <CACgLhq_V-uj1pNjKyEA8RaOtxjfNca+R0LRPp-6KgDw6NCCGpg@mail.gmail.com>
References: <CACgLhq_kMv2cj4RHr8Yx5tnYup5enCJVMrZf9Yt9Y5-bkfozLg@mail.gmail.com>
 <54BEC6C7.8070103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Voigt, Heiko" <Heiko.Voigt@mahr.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:03:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEmK2-0007Em-3g
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 23:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbbAWWDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2015 17:03:18 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:50933 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbbAWWDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2015 17:03:16 -0500
Received: by mail-lb0-f176.google.com with SMTP id z12so9325939lbi.7
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 14:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XNqMV3NDPZOa6RjZi6MAF9p2b4T9DEmhyoKWMsSfTDI=;
        b=f2o/h7iqZ8GgLcmUJ41kvjNbixyJgmCqvq2r6AS+6QIfHvefq6qDPP/Qy8UfvZgVji
         LKwBLkQDPsG74V4TDHChUIvX/ZAJ8YGl8qfzBaqQmnvrQpSU5RdUQZxDngUpf6YzEL4N
         ZNQq/jJaWstFfWvEWnhwInP3EpCgcniTF09eFa4hmrsd689wb1TSU1nUBYRozi/E/lNB
         YotoZWkNMIRRd1jCBqFdk129VGRnqw0T+d9FgUgGrz4+utT81ShVilIYpXKS5TJRKhSW
         rwBaKCYXyIqq7QMfTfNY+aPfw8pZdeW/wU27yrVI3cZ5k/BBC4Z6O8kekWblXcJq2ZBk
         Zo4A==
X-Received: by 10.152.5.101 with SMTP id r5mr9639270lar.33.1422050595147; Fri,
 23 Jan 2015 14:03:15 -0800 (PST)
Received: by 10.25.159.73 with HTTP; Fri, 23 Jan 2015 14:02:34 -0800 (PST)
In-Reply-To: <54BEC6C7.8070103@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262966>

Thanks, Jens.

Incidentally,

git submodule update --init --recursive

Does exactly what expected =E2=80=93 it updates sub/sub/submodules, so =
there
is certainly some inconsistency in how the --recursive flag is handled
here.
info@maxheld.de | http://www.maxheld.de | http://www.civicon.de |
Mobil: +49 151 22958775 | Skype: maximilian.held
Bremen International Graduate School of Social Sciences | Wiener
Stra=C3=9Fe / Celsiusstra=C3=9Fe | 28359 Bremen | Germany


On Tue, Jan 20, 2015 at 10:21 PM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
> Am 19.01.2015 um 21:19 schrieb Maximilian Held:
>
>> I have a directory with nested submodules, such as:
>>
>> supermodule/submodule/sub-submodule/sub-sub-submodule
>>
>> When I cd to supermodule and do:
>>
>> "git push --recurse-submodule=3Dcheck" (or on-demand),
>>
>> git only pushes the submodule, but not the sub-submodule etc.
>>
>> Maybe this is expected behavior and not a bug, but I thought it was
>> pretty unintuitive. I expected that git would push, well, recursivel=
y.
>
>
> I agree this is unexpected and should be fixed. I suspect the fix
> would be to teach the push_submodule() function to use the same
> flags that were used for the push in the superproject.
