Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D41C4167B
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380075AbiDDVVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380712AbiDDVKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 17:10:31 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EFBDF0
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1649106507;
        bh=56DMC8rKXBmyIEFuGQPqdMf0GNuRDZhD+WH3yBbpU6U=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UZVc3d4ckpOdEAfjset22zgqRoYaBe87XlpRbv0YiGtCtZ4V6ojdwA/XOyIb4sgpx
         iFX3rC9xAl3N9N4XQf53TsaW1rxYH2JdJRP9m+udstPTCNhj7L3hPDNnl9Kgfi3cQx
         qs5WGCtjS31yzzMsLSi4KCRFtMwgt25+3eTxvSz8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBS71-1niNQi1sxL-00Cp8e; Mon, 04
 Apr 2022 23:08:27 +0200
Message-ID: <c35bd0aa-2e46-e710-2b39-89f18bad0097@web.de>
Date:   Mon, 4 Apr 2022 23:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: Git has two ways to count modified lines
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Laurent Lyaudet <laurent.lyaudet@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Eckhard_S=2e_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Elijah Newren <newren@gmail.com>
References: <CAB1LBmvX4kv3yqSZ+X4Ozkb9esUem3U1JY48kWVi_Eef78Sk=Q@mail.gmail.com>
 <CAB1LBms3F1EGswxF9mO=JrmWmj4XFncv4ZrkAy-dvOHdVrkwLQ@mail.gmail.com>
 <d650bb90-df94-eeab-0684-ee447e080ad6@web.de> <xmqqh779u72a.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh779u72a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sUoPGqnpffHmIsQrhM7dHOlOPLlRtCb2f4DGIVslSMiYl+0ljpi
 y5zI15uJ/y7QS6kvXB4f0RmwZYkSOnKS1z5YAqw+EcVSseX6rOy6zuVowPy1+zNC5tdkLiI
 WeCh/++mG2qtz6vsnb+TEjaZcZQGHNAC5Ka2+YDQEdZ//QJ49DmDlfkmBTIAjW0ze3CWaNc
 A8qcb/ykUSfH3CRTn/iOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Df10FH8TPyc=:Vvp1X5geXWxJTGFfw+fzaJ
 tuFaQXrzRnXHymNj6bnId6UA0stshY8SZLtiMRpSj8+w36z2vDOZnik4WPJIInIh8smwiBvS2
 7n7QaFETZ/iM7N5AAgcNtY6HmAE4qAFmiy/c9b3pot5xBapBJ9NgP+pwJndVzmTpC3szyNBKj
 o2MZ090JcGLLWqP7H1E5WjO5FHzdGp/Xz9DK1LOIFMLVGdyYuHugZcKX1O+rZ0aJTLvGvFA3E
 4Bh+VmUjXT3nPrg7cPx+Q6zPbUPaScMpZWx5Ba/b1t3cULngYfvs+U2M54yIuxj32DIOlTpVs
 D9k3MHbkVifH5AIfrmtzrHA58vzswpTkXzc2UPbSdDhpN2rQsmz2nH1D29KYsYuNALcYoGt4W
 gyIGhen2IyF6ySRP/VQqskM46zcoM/7y21jl0GO65rnAzua3ABTIxtdNztwEgUPwiMUJSiOSS
 To7EmxRHBYYhy7FzYJ+jIAixv1hA42eaZJfNDpQVtkYnHkz2D+kFSAWpEQYARHA55aykZE/dH
 tOLemr94lafHN6vlldGyO3dDUCtWR98LWUKBDOBNDfU6me29yKxVG3tO+JVoxbO8HNvkXFSKU
 oMRMMVnpGmCdnFetynSuov+9UYj2QL5oumPK3tpVJgdduvencG50JOCylDhdoTzAf1IlWI0H1
 8UUalaoRWGz7egvZuRfu/iQ3pF5cO24l3pXztn+JZ9ckESLjHj+gAS1BXaM5R4L8dNzzMktSd
 wpNXO40X/RHm9MMQPUVIt/CYPBKQvVFY0OlsN1KiqZusslHgj6lL5qJ4GaTBseXWEbbDG+qcw
 pCkiSczvJOJ9/zb35A0hyplctUiPzrfc82dszJryuYLlgkbR52xit1kY79VRC0bV3AZgJBnZk
 QXKBpp4+sKkgm2PZHkOOm618ggUAf+UvzZDrIFgSDtBwm2URzinXC4R/omTN54xV1zec7eFWt
 4gvtYUDCjPSv/O0t4bLVcqqFpulrBYIUP3xeAYlKLQTONzw+nZFHnEJ3x1uHNCbNfXKE/aZAz
 mZQvApRlzh7h0JIIUfSzT+yauh1pO4RrzPNCcOKPdwHo4bEnN3aHNDvcZXYoJkXijw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.04.22 um 00:37 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Git stores the file contents before and after your change.  It doesn't
>> store any diff, but calculates them as needed, e.g. for the commit
>> confirmation message, or when you run git diff.  So in that sense there
>> is no "the diff".  The difference between two stored states can be
>> represented in many ways.
>
> That's the crucial point to answer this question.  Even without
> break/rewrite transformation, depending on the choice of the diff
> algorithm, the same change may be shown as different patch (with
> different line count, obviously).
>
>> But I have a question to the list as well: Why is break_opt (the
>> diff_options member for --break-rewrites) enabled for git commit by
>> default?
>
> If it is, that is a bug, I would say.  Don't we initialize the
> member to "-1" at around diff.c:4580 though?

Yes, but it's set to 0 in print_commit_summary() at sequencer.c:1330.
That line was introduced by 3eb2a15eb3 (builtin-commit: make summary
output consistent with status, 2007-12-16).

=2D-- >8 ----
Subject: [PATCH] commit, sequencer: turn off break_opt for commit summary

dc6b1d92ca (wt-status: use settings from git_diff_ui_config, 2018-05-04)
disabled diffopt.break_opt for diffstats shown by git status and in
commit templates.  For git status there isn't even a way to enable it.
Make the commit summary (shown after the commit) consistent by disabling
it there as well.

Reported-by: Laurent Lyaudet <laurent.lyaudet@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 sequencer.c               |  1 -
 t/t7524-commit-summary.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100755 t/t7524-commit-summary.sh

diff --git a/sequencer.c b/sequencer.c
index a1bb39383d..85a17d45bd 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -1327,7 +1327,6 @@ void print_commit_summary(struct repository *r,
 	get_commit_format(format.buf, &rev);
 	rev.always_show_header =3D 0;
 	rev.diffopt.detect_rename =3D DIFF_DETECT_RENAME;
-	rev.diffopt.break_opt =3D 0;
 	diff_setup_done(&rev.diffopt);

 	refs =3D get_main_ref_store(the_repository);
diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
new file mode 100755
index 0000000000..47b2f1dc22
=2D-- /dev/null
+++ b/t/t7524-commit-summary.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D'git commit summary'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_seq 101 200 >file &&
+	git add file &&
+	git commit -m initial &&
+	git tag initial
+'
+
+test_expect_success 'commit summary ignores rewrites' '
+	git reset --hard initial &&
+	test_seq 200 300 >file &&
+
+	git diff --stat >diffstat &&
+	git diff --stat --break-rewrites >diffstatrewrite &&
+
+	# make sure this scenario is a detectable rewrite
+	! test_cmp_bin diffstat diffstatrewrite &&
+
+	git add file &&
+	git commit -m second >actual &&
+
+	grep "1 file" <actual >actual.total &&
+	grep "1 file" <diffstat >diffstat.total &&
+	test_cmp diffstat.total actual.total
+'
+
+test_done
=2D-
2.35.1

