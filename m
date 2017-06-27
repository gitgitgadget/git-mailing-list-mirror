Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0F020401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbdF0RDx (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:03:53 -0400
Received: from mout.web.de ([212.227.15.3]:56331 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752103AbdF0RDv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:03:51 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ6KJ-1dLEwI3ZuF-005Jj5; Tue, 27
 Jun 2017 19:03:41 +0200
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
To:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <20170225101307.24067-2-vegard.nossum@oracle.com>
 <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
 <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
 <f191e3a8-a55b-7030-ebbb-3f46c74fdc94@web.de>
 <xmqq1sujnu1g.fsf@gitster.mtv.corp.google.com>
 <05fe5800-ebc0-76d7-579d-77f64a851fc1@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5128cdf1-39fc-59ca-5640-801777bac2fa@web.de>
Date:   Tue, 27 Jun 2017 19:03:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <05fe5800-ebc0-76d7-579d-77f64a851fc1@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YE6ApoliQsZc2XJ1Ys6aYh81mSAJAd3FBvsiCgeLenX8SsGCq/P
 TutL4lkV9FkCOY+zzt0szT6abCl1vKWvIt1v/9cBCgEVT18EYxjZ0jKksTqj1ukd/A9mVfl
 XOEIT5dZeXq13O5QHNMXaVOOijr53pKMMABEtJZkKN3Mph07v1MAFdy4dZGenIrK7SSLiWU
 h/Pxi88nHBFx08kfsNnvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZSW4ZFv6UfY=:4ZFTEGPldxwM8QKK8SwhuM
 QPuQluMF2+ojsD6kOuNBeBgt1uT8bpzUqCkr/PGO3fIQrDdAKmgknFww/CKnttxB0lwqf/dqd
 1QrsaqyujqVsqhP3alLQuyzCG6zTsRqEQTecAxqoFA5R9DfH3peegbnDb1xJUMCnRR3FTIys8
 dppVrw+C82HtXQnk87XebykRPpyzPBnHDllHt6D6FHoui5I5Siqc56FufwFXWfKJRoQi8cLSV
 k5NkyLrYNgMypYPaF+NRhyQhXi42UHQu2QN/pen2gEDDVxyMBeYfKSuxCz54VyTg3n06CEIZN
 2h6GvxcgREoV+845XZl20LIuynSu+E0u9Rd5IW/LLD2dWjWKmtGT8YC8mvt1674oVejZDVttj
 TMtyjHD8ZZHN3ADev2DTWRVuuNiflBLY/YShfdDRa5TH8o3gIS/PSA//qn6zcP7oLDMEU8mJt
 ni4Jv/dkIh51oFeDAo/BmSKk0EnRR3tAkDit5wTPtY01egPiMkD/qZOIQJoGb1DT4T2GmbsfU
 tB2scnlFYwk6odL9F98hqFatSEYdDILN8pjWhReLtAJGTOwxqUY9ugWa3kxsANZg7y3wEt2/N
 DBhfU/+ONZpbAdIz6LcCLY3bmIlxaGmk7dn/WzmMeMHQX5D+/obtoa2u8EumxJ4BHiUU0o7YG
 33V5oFiXVneeOeAFGmCjRjQBBS8CPX6+oc/OeyV3J9qvIeh+qjzk0UUNJrzFwY8hjwti2Qg42
 7ihzL7wrrAZtbTdubYn0MkiUcPVJUNqBj+6rdHpDzTbf+kojWdtB0SQyOdO1bKmX5egOI7vUV
 ZYLWcOd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.02.2017 um 11:50 schrieb René Scharfe:
> Am 27.02.2017 um 23:33 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> Am 27.02.2017 um 21:04 schrieb Junio C Hamano:
>>>> René Scharfe <l.s.r@web.de> writes:
>>>>
>>>>>> diff --git a/apply.c b/apply.c
>>>>>> index cbf7cc7f2..9219d2737 100644
>>>>>> --- a/apply.c
>>>>>> +++ b/apply.c
>>>>>> @@ -3652,7 +3652,6 @@ static int check_preimage(struct apply_state *state,
>>>>>>   	if (!old_name)
>>>>>>   		return 0;
>>>>>>
>>>>>> -	assert(patch->is_new <= 0);
>>>>>
>>>>> 5c47f4c6 (builtin-apply: accept patch to an empty file) added that
>>>>> line. Its intent was to handle diffs that contain an old name even for
>>>>> a file that's created.  Citing from its commit message: "When we
>>>>> cannot be sure by parsing the patch that it is not a creation patch,
>>>>> we shouldn't complain when if there is no such a file."  Why not stop
>>>>> complaining also in case we happen to know for sure that it's a
>>>>> creation patch? I.e., why not replace the assert() with:
>>>>>
>>>>> 	if (patch->is_new == 1)
>>>>> 		goto is_new;
>>>>>
>>>>>>   	previous = previous_patch(state, patch, &status);
>>>>
>>>> When the caller does know is_new is true, old_name must be made/left
>>>> NULL.  That is the invariant this assert is checking to catch an
>>>> error in the calling code.
>>>
>>> There are some places in apply.c that set ->is_new to 1, but none of
>>> them set ->old_name to NULL at the same time.
>>
>> I thought all of these are flipping ->is_new that used to be -1
>> (unknown) to (now we know it is new), and sets only new_name without
>> doing anything to old_name, because they know originally both names
>> are set to NULL.
>>
>>> Having to keep these two members in sync sounds iffy anyway.  Perhaps
>>> accessors can help, e.g. a setter which frees old_name when is_new is
>>> set to 1, or a getter which returns NULL for old_name if is_new is 1.
>>
>> Definitely, the setter would make it harder to make the mistake.
> 
> When I added setters, apply started to passed NULL to unlink(2) and
> rmdir(2) in some of the new tests, which still failed.
> 
> That's because three of the diffs trigger both gitdiff_delete(), which
> sets is_delete and old_name, and gitdiff_newfile(), which sets is_new
> and new_name.  Create and delete equals move, right?  Or should we
> error out at this point already?
> 
> The last new diff adds a new file that is copied.  Sounds impossible.
> How about something like this, which forbids combinations that make no
> sense.  Hope it's not too strict; at least all tests succeed.
> 
> ---
>   apply.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 61 insertions(+), 18 deletions(-)

Thought a bit more about it, and as a result here's a simpler approach:

-- >8 --
Subject: [PATCH] apply: check git diffs for mutually exclusive header lines

A file can either be added, removed, copied, or renamed, but no two of
these actions can be done by the same patch.  Some of these combinations
provoke error messages due to missing file names, and some are only
caught by an assertion.  Check git patches already as they are parsed
and report conflicting lines on sight.

Found by Vegard Nossum using AFL.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c                | 14 ++++++++++++++
 apply.h                |  1 +
 t/t4136-apply-check.sh | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/apply.c b/apply.c
index 8cd6435c74..8a5e44c474 100644
--- a/apply.c
+++ b/apply.c
@@ -1312,6 +1312,18 @@ static char *git_header_name(struct apply_state *state,
 	}
 }
 
+static int check_header_line(struct apply_state *state, struct patch *patch)
+{
+	int extensions = (patch->is_delete == 1) + (patch->is_new == 1) +
+			 (patch->is_rename == 1) + (patch->is_copy == 1);
+	if (extensions > 1)
+		return error(_("inconsistent header lines %d and %d"),
+			     state->extension_linenr, state->linenr);
+	if (extensions && !state->extension_linenr)
+		state->extension_linenr = state->linenr;
+	return 0;
+}
+
 /* Verify that we recognize the lines following a git header */
 static int parse_git_header(struct apply_state *state,
 			    const char *line,
@@ -1378,6 +1390,8 @@ static int parse_git_header(struct apply_state *state,
 			res = p->fn(state, line + oplen, patch);
 			if (res < 0)
 				return -1;
+			if (check_header_line(state, patch))
+				return -1;
 			if (res > 0)
 				return offset;
 			break;
diff --git a/apply.h b/apply.h
index b3d6783d55..b52078b486 100644
--- a/apply.h
+++ b/apply.h
@@ -79,6 +79,7 @@ struct apply_state {
 
 	/* Various "current state" */
 	int linenr; /* current line number */
+	int extension_linenr; /* first line specifying delete/new/rename/copy */
 	struct string_list symlink_changes; /* we have to track symlinks */
 
 	/*
diff --git a/t/t4136-apply-check.sh b/t/t4136-apply-check.sh
index 4b0a374b63..6d92872318 100755
--- a/t/t4136-apply-check.sh
+++ b/t/t4136-apply-check.sh
@@ -29,4 +29,22 @@ test_expect_success 'apply exits non-zero with no-op patch' '
 	test_must_fail git apply --check input
 '
 
+test_expect_success 'invalid combination: create and copy' '
+	test_must_fail git apply --check - <<-\EOF
+	diff --git a/1 b/2
+	new file mode 100644
+	copy from 1
+	copy to 2
+	EOF
+'
+
+test_expect_success 'invalid combination: create and rename' '
+	test_must_fail git apply --check - <<-\EOF
+	diff --git a/1 b/2
+	new file mode 100644
+	rename from 1
+	rename to 2
+	EOF
+'
+
 test_done
-- 
2.13.2
