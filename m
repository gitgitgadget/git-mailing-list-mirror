Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04178145FE0
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589319; cv=none; b=CNy3IqRy+aIZ94c8K44r/2VIk8CaGK4Jal0wkUu8V1VD/vCu5kJ2U2P5ZMVYfmJ0dZ0IT2HlZY/hQDgIuHUGKubpll5vUA6y12LQrTgghKTnCshOi7kddc40R+m8PhsdjIwSRue3tZ9df3ivov1wNLERiZMf+X8jfprTihDR5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589319; c=relaxed/simple;
	bh=Dkov9tqunFyzIHmw3opRKh+HYUQE6XXIwdiGARIEKts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxvKGYEDGbvcl/px41K4hnwZcdezXJ84Dv5nJzgmhBhR5LigT7FP8tp8QtfA5g2mANbwFkvU2kuBsj4js8wi2WIZyL8TLD+7mrPF0bGSANeIVHYpNbcedBuWqvNDez0O25VLRuj0VkKdslB/ay6HWX0q6Al1ZHA4C6MZa+uMZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7DU/ZUq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7DU/ZUq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so35888205ad.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589317; x=1776194117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItNbxhtdlb6lgYd75bnaBA0PeUfzdvQPT0lILorGgvc=;
        b=m7DU/ZUqlm/JOYMGbWjzkFjXcO0U6QuT2Shtox3XiSAcjc3sD2Mtu4ik7JM9JhKMY6
         f3ZBWqWQ/gedum5+aqKHemeLfN3zx2rrIrmiOYKwsH9ceasUk+i+EugNbphyQpKno+PB
         QFwXsRIk8UTdwllCjXuI5oRtNHUVZ8xsSBMK/7iTror0nk5Esnqyp+DeEEjmVC/IRg7P
         3Gt0y03C2JB26bleFSSt/FQ6d0nqNPFjxfKZls6Fx/QgjH9wzvIV1EZ7yStqjNiccx8s
         wmrscVoHnaBJd3sNDaBrVHogxyV13C3m/STThfIOdPNyDf1mRv2JqdyC0pstvt5yvkOu
         GN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589317; x=1776194117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItNbxhtdlb6lgYd75bnaBA0PeUfzdvQPT0lILorGgvc=;
        b=IqH9rZbG3K1AWHCWIx0KkCBs5V95tdwzrB+aDMgSWeEOLTVapU7rGx/aIdICUjko4j
         WD87XK4dqB+HwZwxif8IoNM+DwGmR371SQDLxsqrA5svp55boPRXOeCgZjsAXxXBhGEK
         vtZXqpYbNFm9vmUUg1bSfhUUUzvHPx9Ka2rbyWJsBKxrtecCqdGr+r2RRAOaiVLdEw8O
         eaxwV3u0DT4VLlohKIS6LSsEiV/vOsYhVc0fCi79dw/TiiYYRqhR8ooAwJyLdIfygegh
         gc7dHWvLl0Ii1D/plZVob2S3op2rJXaZOUhSDTed9d10zZwidX60AdW/qTWfzWj6QA2x
         4zKA==
X-Gm-Message-State: AOJu0YyFzacA5wkKjjN+cSgfeLsR0EO5KQQq2HcjOJ72tg4yZNmkOIpf
	xhVb+RRbZ891CZpT4fnR+RykJMjF56HcoUZo3qDx7ewP0wGtE6MN66mQnORn9MJ5
X-Gm-Gg: AeBDieslgUrELWNVjZ9OX+ZvXzTPz8arqKplaTlSBxC9DQogOzuvKwTi9skWe67e7Bj
	OagxyGVrZCwjc0/cjETp1nmKiri1CMosWs/05ur9/RvY8PgAuy2bRZ9Xd2Llw0i83ESiOgG9KeZ
	UMBi82P8+1UXgAcH6Md6pWlOozdO+u8N8lfuUE+OQTWhBRP8piCbUwwtfWTz0x4dNWOq4GYmotL
	R6nvZJqfHyr5uQ71nkWxpn3UBLYKgPcsHuXoX5ZTc3PalCkCs1JMSpr3cPhLvVaj2C4OBJdRNQv
	fgqhljQyYzr1k1byTxZM75TJrY29NKtIxlKaa+/+5Fv1BM29TK71v4apGs5hSnWk1ke8vOMfgfz
	/tIjIkRByoN/BqFlGw/mu+u1emmzlfHcWfsXiuqk+4P6Ab0AEuiENC12wN1dSrsv5J46kEUV4SE
	Ixk8N8HAX28WrtobT1T8CmQtlFlyCaBaA=
X-Received: by 2002:a17:903:3904:b0:2b0:c0a8:5000 with SMTP id d9443c01a7336-2b2816ae915mr207551805ad.14.1775589316983;
        Tue, 07 Apr 2026 12:15:16 -0700 (PDT)
Received: from localhost ([42.118.191.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747af6e7sm183875165ad.37.2026.04.07.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:15:16 -0700 (PDT)
Date: Wed, 8 Apr 2026 02:15:12 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] backfill: add --[no-]progress option
Message-ID: <j7abmtc6jlgciddkceduueglt2w2nfw76bbplisq63p7jio2xc@yht6tzxgetuk>
References: <20260329152443.525493-1-vikingtc4@gmail.com>
 <8db10441-2fce-43ad-bcdc-331d26ec38ed@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8db10441-2fce-43ad-bcdc-331d26ec38ed@gmail.com>

On Mon, Apr 06, 2026 at 09:16:30AM -0400, Derrick Stolee wrote:
> On 3/29/2026 11:24 AM, Trieu Huynh wrote:
> > 'git backfill' is silent when downloading missing objects, giving
> > no feedback during potentially long-running operations on large
> > repositories. By contrast, 'git fetch', 'git gc', and
> > 'git index-pack' all support --[no-]progress.
> 
> I wouldn't use the word "silent" because the output is actually
> quite verbose by default. Each batch has progress output with the
> remote. For example, this is the output I get when running 'git
> backfill' on a blobless partial clone of the Git repo:
> 
Make sense to me, will reword it to be more precise in v2.
> $ git backfill
> remote: Enumerating objects: 50083, done.
> remote: Counting objects: 100% (865/865), done.
> remote: Compressing objects: 100% (177/177), done.
> remote: Total 50083 (delta 760), reused 688 (delta 688), pack-reused 49218 (from 1)
> Receiving objects: 100% (50083/50083), 37.13 MiB | 27.75 MiB/s, done.
> Resolving deltas: 100% (47710/47710), done.
> remote: Enumerating objects: 50393, done.
> remote: Counting objects: 100% (1559/1559), done.
> remote: Compressing objects: 100% (366/366), done.
> remote: Total 50393 (delta 1366), reused 1193 (delta 1193), pack-reused 48834 (from 2)
> Receiving objects: 100% (50393/50393), 44.56 MiB | 31.56 MiB/s, done.
> Resolving deltas: 100% (47261/47261), done.
> remote: Enumerating objects: 50000, done.
> remote: Counting objects: 100% (2313/2313), done.
> remote: Compressing objects: 100% (592/592), done.
> remote: Total 50000 (delta 1982), reused 1721 (delta 1721), pack-reused 47687 (from 2)
> Receiving objects: 100% (50000/50000), 90.49 MiB | 17.85 MiB/s, done.
> Resolving deltas: 100% (45321/45321), done.
> remote: Enumerating objects: 2155, done.
> remote: Counting objects: 100% (27/27), done.
> remote: Compressing objects: 100% (26/26), done.
> remote: Total 2155 (delta 6), reused 1 (delta 1), pack-reused 2128 (from 1)
> Receiving objects: 100% (2155/2155), 891.74 KiB | 3.75 MiB/s, done.
> Resolving deltas: 100% (1717/1717), done.
> 
> With your patch, I think there would be some extra progress
> indicators between these batched fetch requests.
> 
> Before moving forward with review of this patch, I think that
> it would be valuable to demonstrate the full output with and
> without your change.
> 
Agree, will include a side-by-side comparison in the v2.
> In addition, I think there would be value in a progress indicator
> _instead_ of these verbose outputs from the remote. That would
> require a change to how we initialize the fetches in a quiet mode.
> 
> (I also understand that this output would probably not be the same
> if we have a filesystem protocol for fetching from a local repo,
> like we frequently do in the test suite.)
> 
Agreed, initialize the fetch in quiet mode and replacing it with a
single consolidated indicator would be a nicer UX. I'll look into
how git-fetch sets up quiet mode and try to wire that through
download_batch() in v2.
> >  static void backfill_context_clear(struct backfill_context *ctx)
> > @@ -54,6 +57,7 @@ static void download_batch(struct backfill_context *ctx)
> >  	 * avoid possible duplicate downloads of the same objects.
> >  	 */
> >  	odb_reprepare(ctx->repo->objects);
> > +	display_progress(ctx->progress, ++ctx->batches_requested);
> 
> This looks correct. My preference is to not use prefix operators
> like this on struct members (it reads like you are incrementing
> 'ctx' and not 'batches_requested', even though it is correct).
> 
> However, I'm not sure that we want the progress to indicate the
> number of _batches_ but instead should be the number of _objects_.
>   
> >  static int fill_missing_blobs(const char *path UNUSED,
> > @@ -120,12 +124,15 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
> >  		.current_batch = OID_ARRAY_INIT,
> >  		.min_batch_size = 50000,
> >  		.sparse = 0,
> > +		.show_progress = -1,
> >  	};
> >  	struct option options[] = {
> >  		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
> >  			     N_("Minimum number of objects to request at a time")),
> >  		OPT_BOOL(0, "sparse", &ctx.sparse,
> >  			 N_("Restrict the missing objects to the current sparse-checkout")),
> > +		OPT_BOOL(0, "progress", &ctx.show_progress,
> > +			 N_("show progress while downloading missing objects")),
> >  		OPT_END(),
> >  	};
> 
> I hope that this does not cause any issues with the recent changes
> to include the rev-list options in git-backfill. Worth checking.
> 
Thanks for point, worth checking if any conflicts.
> > +test_expect_success 'backfill --progress shows progress' '
> > +	git clone --no-checkout --filter=blob:none \
> > +		--single-branch --branch=main \
> > +		"file://$(pwd)/srv.bare" clone-progress &&
> > +	git -C clone-progress backfill --progress 2>err &&
> > +	test_grep "Downloading batches" err
> > +'
> > +
> > +test_expect_success 'backfill --no-progress is silent' '
> > +	git clone --no-checkout --filter=blob:none \
> > +		--single-branch --branch=main \
> > +		"file://$(pwd)/srv.bare" clone-no-progress &&
> > +	git -C clone-no-progress backfill --no-progress 2>err &&
> > +	test_grep ! "Downloading batches" err
> > +'
> > +
> > +test_expect_success 'backfill no flag on non-TTY is silent' '
> > +	git clone --no-checkout --filter=blob:none \
> > +		--single-branch --branch=main \
> > +		"file://$(pwd)/srv.bare" clone-notty &&
> > +	git -C clone-notty backfill 2>err &&
> > +	test_grep ! "Downloading batches" err
> > +'
> 
> What you are missing here is that the progress isn't silent when
> a TTY is present. There are several tests in the test suite that
> use the TTY prerequisite for this kind of behavior, such as this
> one from t9211-scalar-clone.sh:
> 
> test_expect_success TTY 'progress with tty' '
> 	enlistment=progress1 &&
> 
> 	test_config -C to-clone uploadpack.allowfilter true &&
> 	test_config -C to-clone uploadpack.allowanysha1inwant true &&
> 
> 	test_terminal env GIT_PROGRESS_DELAY=0 \
> 		scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
> 	grep "Enumerating objects" stderr >actual &&
> 	test_line_count = 2 actual &&
> 	cleanup_clone $enlistment
> '
> 
Agree, will add such that test as per above reference.
> Thanks,
> -Stolee
> 
BRs,
Trieu Huynh
