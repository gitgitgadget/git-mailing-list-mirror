Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69254C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E25207E8
	for <git@archiver.kernel.org>; Tue, 19 May 2020 20:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="A42E/3O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgESUHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 16:07:30 -0400
Received: from mout.web.de ([212.227.17.11]:57727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgESUH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 16:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589918838;
        bh=xXMWoxA0eFWOZ7veI0TLCYuRRfN8cmBkSmDlhRxTm6s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A42E/3O1NNl1DeJldjH/9awkb/i944ELLcGukWM+JcImhJKtqz9WpSBecp6rhAMS2
         NIBm+viEj04WhxIJGBa4oEG4Wxtv7O9yHLMGRwci7VeDAcscB9emkIsgJYR7y2BXB0
         sYN0qKK4+kclwGIBraJHvr+RIDbwV7AxY8ZZkZws=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myezn-1iqI9r0aHl-00ytZH; Tue, 19
 May 2020 22:07:18 +0200
Subject: Re: Git Test Coverage Report (v2.27.0-rc0)
To:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <853759d3-97c3-241f-98e1-990883cd204e@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e0a0fc10-7141-f456-a6db-8d2b8c7dc6b9@web.de>
Date:   Tue, 19 May 2020 22:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <853759d3-97c3-241f-98e1-990883cd204e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zV7A3f0vA6HqJ54YuIMjFgehiheUbb6f7uF1H4b9AfQ90WJgr5C
 FQ9kfEKY2ncM+dEkufRNCOSCHLFr4kWw0uX8sjpUx/Q4DWR/X4/oyXzLljvilrSUhqXM8wQ
 STQe6s/+9v3iVgX/aozc+mlydNAD5NXlyanRNcEyCrAC1EUXyNmCSTq8P7k4fAaRp34C/Q+
 sBlDWM7M095U5xXIuL3Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AiEy6ppGPiw=:+qPw4kfj8uB8DPBXrjuIBE
 4D3fZ/KSam512Lci2Myx0mbkWXIlGde+FwrCho40TAp+hIRQ0ssAGIuwIJO7iabD6PiJZFoNZ
 oY8AHabHlrkx0XwHVwUX8MHhWQamOhOanmuM587s198njUzkR7bnEjMV9AQ/orOZyTPeBeXiV
 iD6HYYDAXHFmu2jg2X3oWk3YyPvmIVuLRgVba6kHVvLOuMmXx+LwO1kvU8YmsU/qq7fZeAtSe
 ZDT1AsHtG51l767kNjkqGrHUB9Hp0Elrn4IlSsDSflKBlmaq7k3ESGxxZAh7K9Dl3hHyR0SdI
 ZK5zK7ee+KlmKraHM89m8cOoYfoIdsyDECcbISzbF9MsfJRUX55D2FXZUiE7ny5Mhaoqd3RG0
 y+JjZabWKo8z6MelHGQN/4bDAvcV8InH7VdejCmZHkPbL3qREna3j4YygQ2KODO9eBUx6d5lb
 /7Vmrp2BNsHioMi5lEDZ3GSGnPGZ3vC8aF0jIWYJiBpXnivfUblvk+DKUudY7cFk2pbuMr9u6
 cidlMBiEqc2gX/a1B4UN8HF9cqIhizPmg1u76eGLrRvcd4khOOzRWNecK3lVaTNm0dKNq0DEa
 VnS5Aj4BlV6pqRu3ijNWiAsVCQmj+5HGB/6DY+zwQpVsfzoqANzjCp6pl0qHabVlEMsfcetlV
 iIGeq6jSa7Ab+G6ZOyQWOf0d7VrU4tkC+l5WgOCmkv2hvkuaAXaCDgU9Xdxw3SdptxzeDD4lh
 B/BfihwqYwLXeT6sqVmTOJFaNiMj7SSzYbLYer+Iak4bi+HA+9TuXBQG9gsN9TxhQUYakjq+O
 hafp9AAlduAz62KvEM7qYTcIPVca6BsyP9vudLIV+SKI0v/iQy/iJvGckERcV8R8DeuHzJT96
 TvHZtL6mTQ7ZtE9vn+ALGFq44zqw+FLxsHnPfQj4tiUzX7t5iJWfXt9EiUvcjW0itAbwzf2vq
 /Bt+JnAfxl87rIET3HupNEccLnqSPQVcckxYJFh9lpFafFhmV3KZ3pgwX+qWe47AwOEja6zGk
 nLQNxwPxBImSxz2rXjfiYQTjY7lU4oyrEpHCQBBbLQRjy6/ITUd1xaxtVCBklJvYmCEduM6Y7
 zvyuySYC/M5vQXTAzugfXs4jFFasUGSh8dUKyKUKKqAzqGxkz0WIaZnSXIdrtDuOE8v+N6PoC
 u9UueWpJoB/eVC7d3NIkIAjy2qpUh5LtQ0Eyi3ZvrCU30btZ5zYoJDlYoqwKLIbwvcJ/2kV87
 UqDdQXpPC69+MxewJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.05.20 um 14:11 schrieb Derrick Stolee:
> On 5/15/2020 1:22 PM, Derrick Stolee wrote:
>> Ren=C3=A9 Scharfe	9068cfb2 fsck: report non-consecutive duplicate names=
 in trees
>> fsck.c
>> 9068cfb2 623) break;
>> 9068cfb2 626) if (is_less_than_slash(*p)) {
>> 9068cfb2 627) name_stack_push(candidates, f_name);
>> 9068cfb2 628) break;
>> 9068cfb2 630) }
>
> These are different conditions in verify_ordered() to check the
> special case of blobs and trees having the "same" name (but
> sorted differently due to appending '/' to trees before sorting).
>
> There is another name_stack_push() that _is_ covered. I wonder
> what case would trigger this push?

Our test has one entry between the conflicting two:

	x
	x.1
	x/

The branch is necessary if the check of a candidate tree consumes
a candidate file from the stack that we need to check against later
candidate trees, e.g.:

	x
	x.1.2
	x.1/
	x/

Let's check each in sequence:

  1. "x" is a candidate file because the next entry starts with "x" +
     less-than-slash, so "x/" can still follow.  We push it onto the
     stack.
  2. "x.1.2" is not a candidate.  A hypothetical "x.1.2/" would come
     before "x.1/", so we can be sure we don't have it.
  3. "x.1/" is a candidate tree because it follows an entry that starts
     with "x.1" + less-than-slash, so we could have seen a file named
     "x.1"  earlier.  We pop "x" from the stack and see that it doesn't
     match, but is a prefix.  "x.1/" is "x" + less-than-slash, so "x/"
     can still follow.  We push it back onto the stack.  And that's
     the branch in question.
  4. "x/" is a candidate tree because it follows an entry that starts
     with "x" + less-than-slash, so we could have seen a file named "x"
     earlier.  We pop "x" from the stack, and have a match.

But here's one that slips by fsck and the test coverage check:

	x
	x.1
	x.1.2
	x/

This duplicate is not caught by the current code.  Both "x" and "x.1"
are candidate files.  "x.1.2" is not a candidate.  "x/" is checked
against "x.1" from the top of the stack, found not to be a prefix and
the search ends at that point, unsuccessfully.  I think we need this to
fix it:

diff --git a/fsck.c b/fsck.c
index 8bb3ecf282..594e800015 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -620,7 +620,7 @@ static int verify_ordered(unsigned mode1, const char *=
name1,
 			if (!f_name)
 				break;
 			if (!skip_prefix(name2, f_name, &p))
-				break;
+				continue;
 			if (!*p)
 				return TREE_HAS_DUPS;
 			if (is_less_than_slash(*p)) {

