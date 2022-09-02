Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D72C54EE9
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 09:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiIBJQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiIBJQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 05:16:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A09CC7FB8
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662110175;
        bh=T362Q0FfU6vGat6MiyHIi5ptQzsh+NCP1yFSP9ciK4o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MDJSmYvUy/HFXKFzF2wX2CTe5GRDcIrTAic/6PgaSAZbT1nDB7oaDx30bGWmRAa2j
         gre/M0v/9gdouw192fOTzq7J3ArJfYbEnYiOOLhmdEiRKDqz0KRtCD7uXIrMBcwd5f
         GIvI3mobyth4p7wnSZ2B3mkKLgbRQJX5DNjjiAB8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1olZdP1rtY-00HcOw; Fri, 02
 Sep 2022 11:16:15 +0200
Date:   Fri, 2 Sep 2022 11:16:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye <vdye@github.com>
cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH 6/8] t/perf: add Scalar performance tests
In-Reply-To: <86b7b9a3-8950-da9c-eae1-19ddb22456ec@github.com>
Message-ID: <p9221sp1-r3on-ro35-3535-q423r641opn9@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <42ab39f21212d3da1af3546d3425aa790637056f.1661961746.git.gitgitgadget@gmail.com> <59s7o8n8-5797-q2qo-4q0o-93qppnr92q52@tzk.qr> <586fc6ca-b699-14a9-c5a1-10323a1cde0c@github.com>
 <86b7b9a3-8950-da9c-eae1-19ddb22456ec@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5wh6y/DBvTlO/l0+5xCDohOrW7V5aota0WCcBRiJiBCBj1qG5yt
 0hu9W1TDmhmzALKnaNY7qB1aQlMIeVxtl6aakD0wLviKZk0yYPYbD+hSWgXN+9FerDfHygk
 XNOqZnVbDGSXyrLX9Dy2N3XR2VpDLTr1BDKjB45BhTUzym2S/1gnNftPOEWd/bfu2AXj/jw
 +RDc15RM0LXxCFXPPlAfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:olrJhY5sS+c=:SlhJ7BvXRG0b4FIGkGiJG3
 mD/T2sg0FWZ7dces4QF4AiKx1mny7aBzoAKatR3i1yH55Yiu/d9nAO33iygopNH7nRj5AUMa1
 myGS1tfC0ZuIsMJB3AA+fuvh1Vksrj/DfpbyN+Fih182cT/9RvzDUkw8QcdjdKqePN3tKz3fn
 R9do0EZ1OpONoSE6tFX1LmdZUwVdiEJ0U8vfL0NJKe8A6ek/02y99YqhYgOA/uz16wHwCkS2b
 0Uoo2C0vFyzEoTTyTBEZmWTDOahDO8EIZ8m3aHpGNwVVQY/lw5cwt0bfqtn9YXq702u3/7Fuc
 q25KSCUJ02qAYluH+hV6jdullIQZGOiS/AE/m2a/dawq8sVQCKqqqyOC2r6VMjci1leR+vAqY
 IEq80tVtKmywWfWKwRCF6HkU8CAPnvfeYcWiJYuO4I89Gc5tJqETlZyvwYQj9kvnRL9ipFpil
 pC20L2b0EKXFJR/Yuz0UwgOonL7ddFtg205CpaIVgaaIE26QozIByUVez8tzPdih1Pj2L4qwU
 tZb5fgcK5LLD0Kh8k9hF18HNUGpNIxsGqxl4FeJn3dIw88zjnHL9QpCdnwwqfwN5Aysh3Uo5C
 /1oKowX3B1B1cB4ZUAIqAHg8gtYL4eJoIV92uwt9juI6FYou15zDG3d4CCo8OgIIfUSLao2h4
 V3StJtwABJTBJI6MdZqrFncP3jBABs8OYWuUKRVgbq5p/K5Xtt76Ekgo9+36SpOV0k6ucc8Yf
 N/Weg0OX1Rdrfg+7uGPRAViC4pvpdyeVV0rboZcS2KTR4u54Eucc1no6d4yJnZ0Kk7vhITlrh
 PiXpeIig1PyZkNKD+BPtl6aKFD3tGfcPbZWObcZ11D5+Q+GA3COyEIgIJQI4BshRdywl+kkWQ
 b3NMoOMzif9tKZOIUODwrB+daSc2QNzNJJNh75FCW5gDtFpLBdOEvkPhnb12sYKhtMHnizeic
 CKC1FBLTWFj5QySRwc/6baktA9nX8aIu3V66X25Eo8QznH24uKXnuCe2Bz7Sfm89srpeQACGI
 92lMCFE+aug0cbb5UsDxlNSw24j+JwEKCz21uDNrHy7d9Iox6k7OywIYuce1a7q1PQC2x2SYh
 Vo+TSkwbBUgG8GYRyXYbLbuzP2SflPA86tqy/aKUmcuB51eSpHDY2rTx0bCL6/m2FI5V6F7UY
 snTscIiy/Rb//mLQUVzbOKTQwR
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Thu, 1 Sep 2022, Victoria Dye wrote:

> Victoria Dye wrote:
> > Johannes Schindelin wrote:
> >>
> >> On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
> >>
> >>> [...]
> >>> +
> >>> +test_compare_perf () {
> >>> +	command=3D"$@"
> >>> +	test_perf "$command (scalar)" "
> >>> +		(
> >>> +			cd scalar-clone/src &&
> >>> +			$command
> >>> +		)
> >>> +	"
> >>> +
> >>> +	test_perf "$command (non-scalar)" "
> >>> +		(
> >>> +			cd git-clone &&
> >>> +			$command
> >>> +		)
> >>> +	"
> >>> +}
> >>> +
> >>> +test_compare_perf git status
> >>> +test_compare_perf test_commit --append --no-tag A
> >>
> >> Given the small numbers presented in the commit message, I suspect th=
at
> >> even so much as running the command in a subshell might skew the timi=
ngs
> >> at least on Windows, where subshells are very, very expensive.
> >>
> >> Given that both `git` and `test_commit` understand the `-C <directory=
>`
> >> syntax, this variant would resolve my concern:
> >>
> >> 	test_compare_perf () {
> >> 	     command=3D$1
> >>              shift
> >> 	     args=3D"$*"
> >>
> >> 	     test_perf "$command (scalar)" "
> >> 	             $command -C scalar-clone/src $args
> >> 	     "
> >>
> >> 	     test_perf "$command (non-scalar)" "
> >> 	             $command -C git-clone $args
> >> 	     "
> >> 	}
> >>
> >> What do you think?
> >
> > Makes sense to me! Although, out of curiosity, is there a reason you p=
refer
> > "$1 -> shift -> $*" over '$1' and '$@'?
>
> Whoops, I completely misread your snippet; the 'shift' is necessary to
> separate the '$command' out so that we can inject '-C'.

Yes, and I also changed the "$@" (which would usually expand to a
parameter list, except when it is used inside a string, in which case it
behaves like $* for convenience) because the "$*" conveys more correctly
what we do here.

Whenever I read "$@" anywhere, my mind puts a mental check mark behind the
"is this code safe with regards to spaces in arguments?" question.

However, this function would mishandle arguments that contain spaces, and
reading "$*" makes me aware of that, so that I can avoid passing such
arguments.

So for me, using $* here is the right thing to do: It makes it less likely
that someone like me adds code in the future that assumes that even
arguments with spaces in them would be handled.

Thanks,
Dscho
