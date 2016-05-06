From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Fri, 6 May 2016 10:13:32 -0700
Message-ID: <CAGZ79kaBh-SogYrMcVfgE1DS464oK2Z01ZqpBiM0eSHKMPU1Fw@mail.gmail.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BbWyw37sQkAq-B_De87N3XzZA9A1fm1A8A7MzfPBtdrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 19:13:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayjK0-00055j-RL
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 19:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495AbcEFRNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 13:13:36 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38734 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758223AbcEFRNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 13:13:34 -0400
Received: by mail-ig0-f178.google.com with SMTP id m9so45980065ige.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1K0y9Bi9SFNKn4ap808sD14HBTYynvbC0NbNwB32EAQ=;
        b=QFQZm6GBQnVu/7KWyI+K4J7EXnx3pTlIyLWxmtCN5PWW5alUf/2OqfiJPKIITTlnBw
         G2K/8O9bxmjuXixXSu4q1dG59FxK0ayW2RtsNdGuMu0E2KvTnmYeRbdkDHMBOzJrWyZn
         CFZO4Y1K4M+vZ28IIGG9ZybkD2AkRl86PPS1JWwmiWuZFMadqdklgh/avc317VLJZTbl
         9fvBREz/eJRBiZ6OdiZ39zGjR330auvWYDHKbim1UE4YDRTFr4g/iQunlbZIjwZV1JhX
         V/PXqWsmbfDibYSnGfuwaguH1x1S/pXUoW4JDJe3HiC+KWi6q+/zznDme+m0iFh6axpt
         MKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1K0y9Bi9SFNKn4ap808sD14HBTYynvbC0NbNwB32EAQ=;
        b=lERdkneuXx889MBNPfnAAMjB5Looxc97f4TKpiZw882DZmwKZVxWbknUTh7SWAbCVZ
         Hs4ej13tyIhNV8sWvcfrTLHFD+elKDAZCEgan4fAjw+kN5RBAkyZG53oROKW3erJD0uI
         oVv4r6ZkiX3kSWbZqI8TiBVdZSrIzh7QVT8Z66QNDuQBLXq4y6eULkjNmY0CUY/13ElL
         HZB5FJ4p8yjAcYFGQrOfVOT0NaoH6WAivjPIgng+neX4SzTkN1UGjAqEwKetfdlK/IyV
         zv27EviOlNTKKzwGDOPsTOChsmR1zdqgroC8kG/T2KVWbq8YOzg+CBUwxstTvvclJOuZ
         LCkw==
X-Gm-Message-State: AOPr4FV1Ie6+OrMq+uOYf5TLJuvLMeeI4/NNop+GKGJ+A+RpivEWKC2hhlKm7EXa8mvyzvpB/s9hFgIKatn/eBM/
X-Received: by 10.50.170.68 with SMTP id ak4mr11827373igc.93.1462554813100;
 Fri, 06 May 2016 10:13:33 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 6 May 2016 10:13:32 -0700 (PDT)
In-Reply-To: <CACsJy8BbWyw37sQkAq-B_De87N3XzZA9A1fm1A8A7MzfPBtdrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293835>

On Fri, May 6, 2016 at 3:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, May 6, 2016 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> I wonder if the patches mentioned have something to do with the "git
>>>> add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
>>>> repository in some way?
>
> The same functionality is added in 8745024 (parse_pathspec: support
> stripping/checking submodule paths - 2013-07-14) so if it didn't fail
> to notice that before 5a76aff1a6 and did after, it's a bug.

The bug seems to have existed before. However in the bug we are talking
about the nested repo is not a submodule yet.

>
>>>
>>> Which is considered a feature now. Maybe we should add tests for that?
>>>
>>> http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb
>>
>> That is a bug, plain and simple.  Duy any ideas where we went wrong?
>
> I vaguely recall this symptom. It has something to do with the index,
> the check we do requires a gitlink in the index, I think. So if the
> gitlink entry is not in the index, our protection line fails. I think
> doing all this at pathspec level is wrong. We should wait at least
> after read_directory() is done, by then we have a lot more info to
> decide.
>
>> I think we already have code to avoid adding beyond symlinks.
>> "git add deep/in/the/tree" should refuse if deep/in is a symbolic
>> link (and happens to point at a directory that has the/tree in it).
>> We used not to catch that long time ago, but I think we fixed it.
>>
>> The logic and the places to do the checks for "no, that thing may be
>> a directory but is an unrelated repository" should be the same.
> --
> Duy

Here are some tests to have a clear picture of what is happening:
(diff against origin/master)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index f99f674..c9dfa11 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -37,6 +37,22 @@ test_expect_success 'setup - repository in init
subdirectory' '
                git add a &&
                git commit -m "submodule commit 1" &&
                git tag -a -m "rev-1" rev-1
+       ) &&
+       mkdir init_slash1 &&
+       (
+               cd init_slash1 &&
+               git init &&
+               echo a >a &&
+               git add a &&
+               git commit -m "first commit"
+       ) &&
+       mkdir init_slash2 &&
+       (
+               cd init_slash2 &&
+               git init &&
+               echo a >a &&
+               git add a &&
+               git commit -m "first commit"
        )
 '

@@ -44,7 +60,30 @@ test_expect_success 'setup - commit with gitlink' '
        echo a >a &&
        echo z >z &&
        git add a init z &&
-       git commit -m "super commit 1"
+       git commit -m "super commit 1" &&
+       git ls-tree HEAD |grep init >actual &&
+       grep "160000 commit" actual
+'
+
+test_expect_success 'setup - commit with gitlink/ in between' '
+       echo a >a &&
+       echo z >z &&
+       git add a init_slash1/ z &&
+       git commit -m "super commit 1" &&
+       git ls-tree HEAD |grep init_slash1 >actual &&
+       grep "160000 commit" actual
+'
+
+test_expect_failure 'setup - commit with gitlink/ only' '
+       git add init_slash2/ &&
+       git commit -m "super commit 1" &&
+       git ls-tree HEAD |grep init_slash2 >actual &&
+       grep "160000 commit" actual
+'
+
+test_expect_success 'tear down slash tests' '
+       rm -rf init_slash* &&
+       git commit -a -m "removing init_slash*"
 '

 test_expect_success 'setup - hide init subdirectory' '
