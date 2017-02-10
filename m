Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECD21FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932235AbdBJTrX (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:47:23 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36654 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbdBJTrV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:47:21 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so3071426pfo.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rmfX0/wIYgJiPb+LB6YECdbMdFD36GBJpPCN2WEOTNw=;
        b=FPmBCo97tcEnaw5+Hg+KO21RDwk3jVF7l57K8rvBO/TG2vidYVeF0z5cE3uogun0KG
         xyA2euOKOKx/KobFPjPHsDBBz7xSDxX/qgUgvJIJrsOAFMW5Ro172PvdzzS/o+K7r7cx
         pRWA3m5z/CgW3O0heA7r4ZUU+8COx2y0rTaKtZ6rQRyWxX0Q3cOwTWWqICk5HCCRFmYR
         HaUgMfJcye7gAuF0U7MTw67lrM5s+ll3LNfnU8n0MBkAOsRgbldu1NCgZc2jiDBvmVTH
         anM7mX/2O6FwVkrDCpId77Zsai2e37h/m7buFep+zujB22AR+jF9zEkj9ltFJi16vHHr
         e15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rmfX0/wIYgJiPb+LB6YECdbMdFD36GBJpPCN2WEOTNw=;
        b=MdSvxeycYaOZZUYygo/awKll4taHrJu9/Nfrwg0mdYDCyE232Qrzs8j1l2cwPn/ZSf
         DhV/+LSl4dXlm/6ac15TRH0Ce51WyVuW1KVn8hXSyku/lR/FNNlnQdGC+DSN/ohj3vJv
         N9UEECokNq7gWUWUy7UJ95SjNBRv07x6sLNvloOZgWecnPI1JFHDQ3k62DhtI9+VnQ/7
         FgV2I7eLXO+8gIV0glpxVrHBAMBnXl6w/NWg5KVWXF+s751aJCKX507gDAhpVG9pJpT5
         TwJbZT9mSigvNujCIDg+d4JcEZELYYGSlEvUwAd7gvoVmxu3VuyOTxl9P2OHAZwESKRM
         0maw==
X-Gm-Message-State: AMke39l8k9z6Fiz4axughIAm7I1cG952CKiY77YJz0Mcwn6fSjEaOf01OAHQpeufFM9ycA==
X-Received: by 10.98.215.27 with SMTP id b27mr12121806pfh.70.1486756040939;
        Fri, 10 Feb 2017 11:47:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id l12sm7197850pfj.37.2017.02.10.11.47.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 11:47:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH v3] gc: ignore old gc.log files
References: <20170210192019.13927-1-dturner@twosigma.com>
Date:   Fri, 10 Feb 2017 11:47:19 -0800
In-Reply-To: <20170210192019.13927-1-dturner@twosigma.com> (David Turner's
        message of "Fri, 10 Feb 2017 14:20:19 -0500")
Message-ID: <xmqqy3xdkeuw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> It would be good if automatic gc were useful to server operators.
> A server can end up in a state whre there are
> lots of unreferenced loose objects (say, because many users are doing
> a bunch of rebasing and pushing their rebased branches). Before this
> patch, this state would cause a gc.log file to be created, preventing
> future auto gcs.  Then pack files could pile up.  Since many git
> operations are O(n) in the number of pack files, this would lead to
> poor performance.  Now, the pack files will get cleaned up, if
> necessary, at least once per day.  And operators who find a need for
> more-frequent gcs can adjust gc.logExpiry to meet their needs.
>
> Git should never get itself into a state where it refuses to do any
> maintenance, just because at some point some piece of the maintenance
> didn't make progress.
>
> In this commit, git learns to ignore gc.log files which are older than
> (by default) one day old.  It also learns about a config, gc.logExpiry
> to manage this.  There is also some cleanup: a successful manual gc,
> or a warning-free auto gc with an old log file, will remove any old
> gc.log files.
>
> It might still happen that manual intervention is required
> (e.g. because the repo is corrupt), but at the very least it won't be
> because Git is too dumb to try again.

Thanks, nicely explained.

> +	if (fstat(get_lock_file_fd(&log_lock), &st)) {
> +		if (errno == ENOENT) {
> +			/*
> +			 * The user has probably intentionally deleted
> +			 * gc.log.lock (perhaps because they're blowing
> +			 * away the whole repo), so thre's no need to
> +			 * report anything here.  But we also won't
> +			 * delete gc.log, because we don't know what
> +			 * the user's intentions are.
> +			 */

OK.

> +		} else {
> +			FILE *fp;
> +			int fd;
> +			int saved_errno = errno;
> +			/*
> +			 * Perhaps there was an i/o error or another
> +			 * unlikely situation.  Try to make a note of
> +			 * this in gc.log.  If this fails again,
> +			 * give up and leave gc.log as it was.
> +			 */
> +			rollback_lock_file(&log_lock);
> +			fd = hold_lock_file_for_update(&log_lock,
> +						       git_path("gc.log"),
> +						       LOCK_DIE_ON_ERROR);
> +
> +			fp = fdopen(fd, "w");
> +			fprintf(fp, _("Failed to fstat %s: %s"),
> +				get_tempfile_path(&log_lock.tempfile),
> +				strerror(errno));

I think you meant to use saved_errno in this message and then

> +			fclose(fp);
> +			commit_lock_file(&log_lock);

possibly assign it back to errno around here?

> +		}
> +
> +	} else if (st.st_size) {
> +		/* There was some error recorded in the lock file */
>  		commit_lock_file(&log_lock);
> -	else
> +	} else {
> +		/* No error, clean up any old gc.log */
> +		unlink(git_path("gc.log"));
>  		rollback_lock_file(&log_lock);
> +	}
>  }

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 1762dfa6a..84ad07eb2 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -67,5 +67,18 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
>  	test_line_count = 2 new # There is one new pack and its .idx
>  '
>  
> +test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
> +	keep=$(ls .git/objects/pack/*.pack|head -1|sed -e "s/pack$/keep/") &&

You could save one process with:

    ls .git/objects/pack/*.pack | sed -e "s/pack$/keep/" -e q

but do you even need $keep?  I do not see it used below.

> +	test_commit foo &&
> +	test_commit bar &&
> +	git repack &&
> +	test_config gc.autopacklimit 1 &&
> +	test_config gc.autodetach true &&
> +	echo fleem >.git/gc.log &&
> +	test_must_fail git gc --auto 2>err &&
> +	test_i18ngrep "^error:" err &&
> +	test-chmtime =-86401 .git/gc.log &&
> +	git gc --auto
> +'
>  
>  test_done

Other than that I didn't spot anything suspicious.  I'll wait to see
what others may want to add.

Thanks.
