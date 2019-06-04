Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C941F462
	for <e@80x24.org>; Tue,  4 Jun 2019 02:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFDCaq (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 22:30:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54575 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFDCap (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 22:30:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so9954697wme.4
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vLQrmn/BUIPd9SkA8mOMgNcc5N5TRXJwmdkcZODFpPc=;
        b=o21W0gL2YGU6cGQXFWFIHhKGwHADL7HsCYODo/Z5zJ86QSBBVV37AbvJ3J/YpDSCB/
         fJtSzc5z5FON9JUH1uMojSs4DNCxoohMwSiC/MdLr9uQqsA3Kl0THwlXiZ0S5jkSareK
         N6kdePFgYqeyrDiXbXZ96Hl2L2RhOnUlFFirPfPdnChPS2u3y49iASyzsHE4F4poraYV
         JzSy15tV1XAKj5EkFuU4qoWu86HsPT7K5E6Sdd52X82Z9w+v53OITGT32fyyV8iyY43d
         gAURvel2gv0yy1Cvm2V1R5JSuyKJoSe9BNBSWOXQBvj7idgFujy/yjhZW6ZfosuCFYf7
         M+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vLQrmn/BUIPd9SkA8mOMgNcc5N5TRXJwmdkcZODFpPc=;
        b=brQ5qau8nosFa1fSDPZARb5h8zsb4Au0nCyUNglQZrWg2UvDyTUZ+oM0buBsvUHbru
         5K+sxHkNuZfVqAQwYxxVl04jD/lPDtYH2kd0IhiHdCOddiTdX3nAPSwnwsrer9CPjmAm
         Oz6MRXp3I4JqCBOvL3brAuqjNaqPL5EJNBalMxuq/NsqTHkCKlFwSODIpsM6bA1+z5KG
         UZyDUO7uihwMdt6yKIKryTcdOymDChEvzK/5iTf/arCczWf7okvVRHwFWNuAe49mP5uA
         OmL2kGf1J95O8oPa99jUM2UAEvh5EnjI594z4XSzDT7KFZiARIM0GP/0oyGShhfrOlAC
         7Tiw==
X-Gm-Message-State: APjAAAXwr/bVshKl4/+e2Pw+gCcDoHaAyyFvl2p130Abk4Bo1ToOJnf+
        cYXghsHH+3qs3YO9s3c4rkc=
X-Google-Smtp-Source: APXvYqxce+YdWa3HtSWgLSNAJYDuyWDQkIt+v4Sz8quJ7y11V/7bSd0tz1Npy3o3xzl+r3uyfDlDJQ==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr133043wmb.107.1559615443219;
        Mon, 03 Jun 2019 19:30:43 -0700 (PDT)
Received: from szeder.dev (x4dbd37ab.dyn.telefonica.de. [77.189.55.171])
        by smtp.gmail.com with ESMTPSA id s10sm11235264wrt.66.2019.06.03.19.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 19:30:42 -0700 (PDT)
Date:   Tue, 4 Jun 2019 04:30:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     ben.humphreys@atlassian.com, Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.22.0-rc3
Message-ID: <20190604023039.GR951@szeder.dev>
References: <xmqqlfyito3a.fsf@gitster-ct.c.googlers.com>
 <CAFkS+y+dS51+nHTDy+A0HrXZpfsEE1UYPN-Xk0257o36ScUOHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkS+y+dS51+nHTDy+A0HrXZpfsEE1UYPN-Xk0257o36ScUOHg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 11:32:24AM +1000, Ben Humphreys wrote:
> Hi folks,
> 
> I’m one of the Bitbucket Server developers and I just wanted to let
> you know of one of our test cases that is now failing on the 2.22.0
> release candidates (tested rc2 and rc3). I’m still looking into it,
> but figure the release is probably imminent so worth reporting sooner
> than later.
> 
> The problem seems to be related to some recent changes in
> merge-recursive.c. I’ve made available our test dataset and the
> following steps will reproduce the problem:
> 
> $ git --version
> git version 2.22.0.rc3
> 
> $ git clone https://bitbucket.org/ben_humphreys/merge-dataset.git
> $ cd merge-dataset
> $ git checkout branch_that_has_rename_add_triggering_content_conflict_trgt
> $ git merge origin/branch_that_has_rename_add_triggering_content_conflict_src
> Assertion failed: (a->path && b->path), function merge_3way, file
> merge-recursive.c, line 1044.
> Abort trap: 6
> 
> The assertion is failing because b->path is null:
> 
> (lldb) print a->path
> (char *const) $2 = 0x00007f8e177025f8 "count.txt"
> (lldb) print b->path
> (char *const) $3 = 0x0000000000000000 <no value available>

merge_3way() is called from merge_mode_and_contents(), which in turn
is called from handle_rename_add(), which was modified in 8daec1df03
(merge-recursive: switch from (oid,mode) pairs to a diff_filespec,
2019-04-05) like this:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index ada1c19ed2..1d2c9e1772 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> 
> @@ -1654,7 +1625,6 @@ static int handle_rename_add(struct merge_options *opt,
>  	/* a was renamed to c, and a separate c was added. */
>  	struct diff_filespec *a = ci->ren1->pair->one;
>  	struct diff_filespec *c = ci->ren1->pair->two;
> -	struct diff_filespec tmp;
>  	char *path = c->path;
>  	char *prev_path_desc;
>  	struct merge_file_info mfi;
> @@ -1669,23 +1639,21 @@ static int handle_rename_add(struct merge_options *opt,
>  	       a->path, c->path, rename_branch,
>  	       c->path, add_branch);
>  
> -	filespec_from_entry(&tmp, ci->ren1->src_entry, other_stage);
> -	tmp.path = a->path;

Note that 'tmp.path' used to be set ...

> -
>  	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
> -	if (merge_mode_and_contents(opt, a, c, &tmp,

... and that this 'tmp' used to become 'b' in
merge_mode_and_contents() and then in merge_3way().

> +	if (merge_mode_and_contents(opt, a, c,
> +				    &ci->ren1->src_entry->stages[other_stage],
>  				    prev_path_desc,
>  				    opt->branch1, opt->branch2,
>  				    1 + opt->call_depth * 2, &mfi))
>  		return -1;
>  	free(prev_path_desc);


This one-liner patch below the issue, the merge fails with conflicts
as expected, but, honestly, I have no idea what I am doing :)  At
least the test suite still passes, but that might not mean all that
much since it missed this issue in the first place...

diff --git a/merge-recursive.c b/merge-recursive.c
index a7bcfcbeb4..d2e380b7ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1660,6 +1660,7 @@ static int handle_rename_add(struct merge_options *opt,
 	       c->path, add_branch);
 
 	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
+	ci->ren1->src_entry->stages[other_stage].path = a->path;
 	if (merge_mode_and_contents(opt, a, c,
 				    &ci->ren1->src_entry->stages[other_stage],
 				    prev_path_desc,


> On Git 2.21.0 the merge succeeds (with conflicts as expected):
> 
> $ git merge origin/branch_that_has_rename_add_triggering_content_conflict_src
> CONFLICT (rename/add): Rename numbers.txt->count.txt in
> origin/branch_that_has_rename_add_triggering_content_conflict_src.
> Added count.txt in HEAD
> Auto-merging version of count.txt from numbers.txt
> Auto-merging count.txt
> Automatic merge failed; fix conflicts and then commit the result.
> 
> I’ll let you know if I get any further investigating this.
