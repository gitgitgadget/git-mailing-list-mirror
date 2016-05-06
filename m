From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] t3513: do not compress backup tar file
Date: Fri, 6 May 2016 16:00:35 -0700
Message-ID: <CAGZ79kbTWsvJy8MA9igpNDsAZhwOzpQBF-rp=vhGYm5hpNz-iQ@mail.gmail.com>
References: <20160506183705.8214-1-sbeller@google.com>
	<xmqqinyq24cj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 01:00:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayojh-0006QJ-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 01:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758889AbcEFXAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 19:00:37 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34588 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758874AbcEFXAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 19:00:37 -0400
Received: by mail-io0-f182.google.com with SMTP id 190so128072985iow.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=31+wuYrmef9RSBgRaQzD45pZDHj0JxEFsWJQiIus6Rc=;
        b=KveZeFdW+aTjMXw/t/thN1A37zCfRvRabKXwgYUim1xBdGGN/mSI4HBFji0FKmQK8p
         0pynlVN3t2QErqDok5U4l/ZSv0tUrpiCTzV2/5o90YJbQcB+vAetR69m/6W7SSa1jhhl
         jqeAO+ldlnpTezVHyOWqe/YGr63dyktZNnY8jWEdjyVBwmej7OuwlOlasxZa88/t9boS
         v6/bb7y8+dA5yujCIhA2qD/ViCLHIB1GoKhHrT9K585AV7o0IfeHoGUnIs2T98FprPsf
         fmkkoXpJvEX7X6iwVGEh6Url3B7Hort97/I5DRZpiuO1ugDbEMBuC611KIiMQM/oeJXu
         eKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=31+wuYrmef9RSBgRaQzD45pZDHj0JxEFsWJQiIus6Rc=;
        b=htf/pBRO95g/bR90IkieAxWLQ9FpHLNDrCS3O4MayrfvWoPocPoVJBJojueBWxq7ND
         EEF+TajUaSmpcGaG68FCK1wTrwGgS6aey+VYDEXX0BoQREE6kQNgRDE/eWbvqwIG5tUz
         bgrUg45VTcqHz3s72biH/XonBWwLkue4JzZnN8gwLEnRQtGAb9OwHQTVPaABpzqpfDGa
         1pGYI6Zy1F5iOF76E5aab2a3VyyjeuX/AkZ0eX08T+s4N75ed2S2kjymkK6UqlYjqA20
         k2eO4k+Ai59DHBBmNWDS1lcm0qtAXCT+6T3TKEW5mSXtGEjDL1cXSC2s6hQo+8SyPWBk
         lkIw==
X-Gm-Message-State: AOPr4FVYES3D9dWcH3CIZXucYbFQ8xLGtPi6C+jHEWD5rhS7MO6MdLc933FNSGC7d9+oOW5ykfkDsq6HOBvN+Yvf
X-Received: by 10.107.161.68 with SMTP id k65mr29595241ioe.110.1462575636061;
 Fri, 06 May 2016 16:00:36 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 6 May 2016 16:00:35 -0700 (PDT)
In-Reply-To: <xmqqinyq24cj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293868>

On Fri, May 6, 2016 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Armin Kunaschik <megabreit@googlemail.com> wrote:
>>> I'm trying to compile/test/use git 2.8.2 on AIX 6.1 with
>>> no bash available.
>> ...
>>> make test does not make it through t3513-revert-submodule.sh anymore.
>>> The test is not portable since it uses the z-flags of GNU-tar. When -z
>>> is removed, (and extension is changed back to tar) everything runs and
>>> tests smoothly.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Thanks for a quick fix.  Even though "no bash" and "AIX 6.1" are
> interesting details that are part of a good bug report, these are
> irrelevant noise for a commit that fixes a bug that is unrelated to
> them, so let's rephrase the message and queue it, like this:
>
>     t3513: do not compress backup tar file
>
>     The test uses the 'z' option, i.e. "compress the output while at
>     it", which is GNUism and not portable.
>
>     Reported-by: Armin Kunaschik <megabreit@googlemail.com>
>     Signed-off-by: Stefan Beller <sbeller@google.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for rewriting the message. :)

>
>>  t/t3513-revert-submodule.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
>> index a1c4e02..db93781 100755
>> --- a/t/t3513-revert-submodule.sh
>> +++ b/t/t3513-revert-submodule.sh
>> @@ -14,11 +14,11 @@ test_description='revert can handle submodules'
>>  git_revert () {
>>       git status -su >expect &&
>>       ls -1pR * >>expect &&
>> -     tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
>> +     tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
>>       git checkout "$1" &&
>>       git revert HEAD &&
>>       rm -rf * &&
>> -     tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
>> +     tar xf "$TRASH_DIRECTORY/tmp.tar" &&
>>       git status -su >actual &&
>>       ls -1pR * >>actual &&
>>       test_cmp expect actual &&
>
> This is not a new problem, but these "ls -1pR" and "rm -rf *" makes
> me wonder if it is the best way to test what is being tested.
>
> The title says "revert can handle submodules", but when it sees that
> revert finishes successfully, it discards the resulting working tree
> state with "rm -rf *" (Yuck) and repopulates with the state before
> the 'checkout && revert' sequence, so the 'status' and 'ls' are not
> testing what 'revert' did at all.
>
> Shouldn't it be testing HEAD^{tree} before "checkout && revert" and
> after and make sure they match, and checking the working state left
> by 'revert' without clobbering it with tarball extract?
>

Reading the comment above that function indicates that the middle revert
is not the interesting revert. The later revert is the actually tested revert.
