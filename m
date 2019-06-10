Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776821F462
	for <e@80x24.org>; Mon, 10 Jun 2019 05:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfFJF7a (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 01:59:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39167 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbfFJF7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 01:59:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so3192890plm.6
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 22:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+8GwkwVTKaPypx5Bf2sxYsdxeowTyhy6RN+ASNueA8=;
        b=jokm4/SXcE06fUG0HzxZlhlktbNvGCsGUIBeHNOXSQcVuJI+UTgI+7pJMVM5XqCYTw
         YY52TK0zf+ePrOPknQl0TMbZwLLXzZuIng6W60eiSvyXboQR/BDOSchFORvr5ApE6u+s
         +SUr7xOgnaDy7MAaGWPxm1xe9nQiNlFRv0bKr0qd+fpNZHnfTGHRaxjQ8Eu3O6BSru/o
         Kf2EiThOAb6TC2gJxz7Fs4fTzgqfe2KPdak3FF6hPwVoDbIkGqREVwfypBerkFkMBAb+
         BQk1XirO1MxddGSNDPAO7LrFxuncQahPu9Jk0eJSeB3gIw2mwHM3UKz4t7NQzhllKS92
         A+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+8GwkwVTKaPypx5Bf2sxYsdxeowTyhy6RN+ASNueA8=;
        b=XFqdmhfzdXw5F6VTTFsoY9ROYh0e+nLd/NFS0yS6lAYZRoTfKx9w/CmOp7hGKgQ1lW
         d/TpU/vd/BB2vr1DXOi2oaOlMHZCXQ8ZVLothoQmZdKjio1zxa7WQJeN6A/QFcbxX4jw
         F0TJzdwE4DlurY8gEuMcZqOMlrxI8ESbhbh/jt1L6Gm1Ce3nWQ+BGsQ0/mJRLy8PgPvD
         5cE2g424IljhDpktKCwSbBOdAIoALEXKn9zwbbjEP/NU9hNqOzC9o0HGwq23N9cYZWoy
         adq0n8OzjGALIj00g1c5PL+d1ukbD9S8kkfEPCA80J+cwf0OcTbgNN3uDzrE9VxEi2uf
         tDpQ==
X-Gm-Message-State: APjAAAXU92PpqdefbRcmdXFAKNepavcyiQXfu+P4pLD3YfTk2LqlbARP
        HiKGHCwDxcuzjWwRrVrIcUI=
X-Google-Smtp-Source: APXvYqwoTG/wqu+/6ScU6nCWvCA95A4XRQ9kHmevZAU5QK/VNFlWNiNa6l8qBCXYiftnzVUgwSBS/A==
X-Received: by 2002:a17:902:7087:: with SMTP id z7mr4611548plk.184.1560146369349;
        Sun, 09 Jun 2019 22:59:29 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3108:4602:68f6:50e8:cfb8:76b6])
        by smtp.gmail.com with ESMTPSA id x125sm12906979pfd.2.2019.06.09.22.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 22:59:28 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 2/3] cherry-pick/revert: add --skip option
Date:   Mon, 10 Jun 2019 11:27:19 +0530
Message-Id: <20190610055719.19572-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <0659a53e-0712-eb50-f15f-1c6a56fd3213@gmail.com>
References: <0659a53e-0712-eb50-f15f-1c6a56fd3213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Phillip

On Sun, 9 Jun 2019 19:01:35 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Rohit
> 
> --skip is definitely a useful addition to cherry-pick/revert
> 
> On 08/06/2019 20:19, Rohit Ashiwal wrote:
> >
> > [...]
> > @@ -2784,6 +2784,29 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
> >  	return -1;
> >  }
> >  
> > +int sequencer_skip(struct repository *r, struct replay_opts *opts)
> > +{
> > +	switch (opts->action) {
> > +	case REPLAY_REVERT:
> > +		if (!file_exists(git_path_revert_head(r)))
> > +			return error(_("no revert in progress"));
> 
> This error message is slightly misleading. If the user has already
> committed a conflict resolution then REVERT_HEAD/CHERRY_PICK_HEAD will
> not exist but it is possible that a cherry-pick/revert is in progress if
> the user was picking a sequence of commits. It would be nice to give a
> different error message or maybe just a warning in that case.
> sequencer_get_last_command() should help with that.

Yes, .git/{REVERT|CHERRY_PICK}_HEAD will not exist in this case, but
in case of cherry-picking/reverting:

1. multiple commits:
    sequencer dir will exist which will throw out the error listed
    under `create_seq_dir`
2. single commit:
    Then ACTION is already over and there is nothing to do and the
    error is correct.

> > +		break;
> > +	case REPLAY_PICK:
> > +		if (!file_exists(git_path_cherry_pick_head(r)))
> > +			return error(_("no cherry-pick in progress"));
> > +		break;
> > +	default:
> > +		BUG("the control must not reach here.");
> > +	}
> > +
> > +	if (rollback_single_pick(r))
> > +		return error(_("failed to skip the commit"));
> 
> If rollback_single_pick() sees that HEAD is the null oid then it gives
> the error "cannot abort from a branch yet to be born". We're not
> aborting and if we're picking a sequence of commits the skip ought
> succeed, but it won't at the moment. If we're picking a single commit
> then the skip should probably fail like abort but with an appropriate
> message. Admittedly that's all a bit of a corner case.

Yes, you are right here. We could actually modify the advice there
to be more like _("cannot perform the specified action, the branch
is yet to be born") and I think it should suffice this. What do you
think?

> > [...]
> > +test_expect_success 'skip a commit and check if rest of sequence is correct' '
> > +	pristine_detach initial &&
> > +	echo e >expect &&
> > +	cat >expect.log <<-EOF &&
> > +	OBJID
> > +	:100644 100644 OBJID OBJID M	foo
> > +	OBJID
> > +	:100644 100644 OBJID OBJID M	foo
> > +	OBJID
> > +	:100644 100644 OBJID OBJID M	unrelated
> > +	OBJID
> > +	:000000 100644 OBJID OBJID A	foo
> > +	:000000 100644 OBJID OBJID A	unrelated
> > +	EOF
> > +	test_must_fail git cherry-pick base..yetanotherpick &&
> > +	test_must_fail git cherry-pick --skip &&
> 
> It would be good to check that the cherry-pick has progressed since
> --skip and didn't just fail without trying to pick another commit.

The overall test tests that only, if cherry-pick --skip "failed" then
we won't get 'e' inside of `foo` and `test_cmp expect foo` will also
fail and if it skipped wrongly then expect.log will not match the
actual.log and `test_cmp` will fail. Am I missing something here?
Please tell if so.
 
> Best Wishes
> 
> Phillip

Thanks
Rohit

