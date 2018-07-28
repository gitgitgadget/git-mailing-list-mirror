Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7CB1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 05:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeG1GgP (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 02:36:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46437 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeG1GgP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 02:36:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id l16-v6so4846300lfc.13
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mjXt5LwqRhmuxDFQWRFjSz4ayrptq0OUo/iF3LQss40=;
        b=H99mDwK06AFR5nBvKBzZoUH1kwc/o8dWulYh2+qus8j89GUU+nVVPnEcxBB4YYT3mK
         kcYNiGGXemitSE2V6aqD3VDMkovf4apgqQM82550gxG5h5XCjy4yaiCr9hpcrsFB/iZm
         Oo8TAwnzF5xxFrAowJtB66pTBgKkFmSjBjDYhf//UcY7nOI5OV6WVoarny75NmUe2eiN
         YudCtkPJu11s/meJPnfZ3I+JNCsEmPIlk25XosBQYHl9/PLARAK9rZVcbxZco2tsWYBC
         //6f9ipi2OftzbcIx1y3O9FQg3oSKIW4wiF51zRqBX7U/Fk1DXD8BPxijxbhTgSS3f3A
         gjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjXt5LwqRhmuxDFQWRFjSz4ayrptq0OUo/iF3LQss40=;
        b=pZDnwbooCNeW7M60DTM/PYt2yy+oE+wfOk8FBb4OOvaEeYb4oFHWVW50gzshyAgFkw
         HWS8HRLksuNdrf8nb8vr+R5iFDA4+hf+q2OfxYlQVlO2M2eTmd7QEQ3ONk8egC19Kvhl
         6aQ3Ss1ZbYhA1JOiS0idiFHX5RgAl+KnHv9wZjWTegBN2XA6+glAYQDIMzu7+XEY0F1e
         j1NcbBxhXBh2lGE2Mou7P7WhA/mO4MTyKC25BJpXSlEf1M5YeFjfhbNst5gdnXnPcPk/
         VhaW932GKM+ltZkf7M0xYmiQHklwUfQszeZOoEg4Rt2AoLnbOIAzP27aUEVKXla8bdCr
         EJiw==
X-Gm-Message-State: AOUpUlHGADYqHJainRNVI00a66B2hiWfTHgAS53srisxgUqhBfE5dsc1
        5n2yR6jKlCeAohNjpd69l8g=
X-Google-Smtp-Source: AAOMgpcQVTOHTKmiPb7Lsjv94mviqyImUsUaWFOfUYPHCkj3jWlTNcLvC8E0JAW4lQObvPEqA+9LPQ==
X-Received: by 2002:a19:eac1:: with SMTP id y62-v6mr5803202lfi.138.1532754668395;
        Fri, 27 Jul 2018 22:11:08 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l90-v6sm784482lfk.38.2018.07.27.22.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 22:11:07 -0700 (PDT)
Date:   Sat, 28 Jul 2018 07:11:05 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clone and case sensitivity
Message-ID: <20180728051105.GA32243@duynguyen.home>
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net>
 <20180728043559.GA29185@duynguyen.home>
 <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
 <20180728044857.GA10444@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180728044857.GA10444@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 12:48:57AM -0400, Jeff King wrote:
> On Sat, Jul 28, 2018 at 06:45:43AM +0200, Duy Nguyen wrote:
> 
> > > I agree throwing a real exception would be bad. But how about detecting
> > > the problem and trying our best to keep the repo in somewhat usable
> > > state like this?
> > >
> > > This patch uses sparse checkout to hide all those paths that we fail
> > > to checkout, so you can still have a clean worktree to do things, as
> > > long as you don't touch those paths.
> > 
> > Side note. There may still be problems with this patch. Let's use
> > vim-colorschemes.git as an example, which has darkBlue.vim and
> > darkblue.vim.
> > 
> > Say we have checked out darkBlue.vim and hidden darkblue.vim. When you
> > update darkBlue.vim on worktree and then update the index, are we sure
> > we will update darkBlue.vim entry and not (hidden) darkblue.vim? I am
> > not sure. I don't think our lookup function is prepared to deal with
> > this. Maybe it's best to hide both of them.
> 
> It might be enough to just issue a warning and give an advise() hint
> that tells the user what's going on. Then they can decide what to do
> (hide both paths, or just work in the index, or move to a different fs,
> or complain to upstream).

Yeah that may be the best option. Something like this perhaps? Not
sure how much detail the advice should be here.

-- 8< --
diff --git a/builtin/clone.c b/builtin/clone.c
index 1d939af9d8..b47ad5877b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -711,6 +711,30 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	}
 }
 
+static int has_duplicate_icase_entries(struct index_state *istate)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int i;
+	int found = 0;
+
+	for (i = 0; i < istate->cache_nr; i++)
+		string_list_append(&list, istate->cache[i]->name);
+
+	list.cmp = strcasecmp;
+	string_list_sort(&list);
+
+	for (i = 1; i < list.nr; i++) {
+		if (strcasecmp(list.items[i-1].string,
+			       list.items[i].string))
+			continue;
+		found = 1;
+		break;
+	}
+	string_list_clear(&list, 0);
+
+	return found;
+}
+
 static int checkout(int submodule_progress)
 {
 	struct object_id oid;
@@ -761,6 +785,11 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
+	if (ignore_case && has_duplicate_icase_entries(&the_index))
+		warning(_("This repository has paths that only differ in case\n"
+			  "and you have a case-insenitive filesystem which will\n"
+			  "cause problems."));
+
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   oid_to_hex(&oid), "1", NULL);
 
-- 8< --
