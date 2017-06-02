Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B300C2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 19:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFBTY6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:24:58 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34641 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFBTY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:24:57 -0400
Received: by mail-pf0-f173.google.com with SMTP id 9so55750005pfj.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PSitAuNXxzdTD+YegBGQ7RtL0fhLXmPCQvITjq/cmrU=;
        b=gailHRPXWiGOhoeR7YGCrNLV+4XOJTpaG5aJIcQyS8sg5x7PH6JxY2JYRehrEaukj0
         5q0c1+KBDilgwNjnGWhwrBpUOBg2JobquMxhz/RAETLf3AwQzrAnUtqtz5UMQu1w7BFt
         cJqtyDUAv9n2MFU2q3u17SMbde6M8/jTokwNI/vEZUT6LHoyTCffHd92m3ee6+Z3G3Us
         HWtC6Yd2kGoIFiB32pSEQY7JUPD/EbX0Tajdp3piTeyX18kDr60DdWFkyuHRgWPhMiLk
         Pfrvkmdf0bjYeMilYUoVFJ8Rs8dBu+/Y37RsdgiJ7lLl4IIIGqc5UBsK1aKRINlqNbiy
         dpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PSitAuNXxzdTD+YegBGQ7RtL0fhLXmPCQvITjq/cmrU=;
        b=igYtAHvzWhBcYVirypjrGrcjRlsF8hnkpddxWRVj37JeMy0kiBNMgzjx4SkX3FtExk
         ka4ZrUTnCSi1FgZwsn26A1UiR2P9i5eqV2VtSjXCBBBT5Uc9M5T7LvpUj6mFN8twVXyV
         1S6fRX4t7wghz+g4Np1vgaBKUakH25E9kGqreXSRFNhA/jjuTtNOzSKo5+1Oc+qBhiaR
         mo4AyvhpMurTvJHvdXmfqveY8izZCB5QLiGv8VgUbdJBVO/h1NP6nRv39euYHQNJPLuh
         IGHrP1RP+Qp5UA+/Ys6O4x0rCdbRJIFMq3XblLOvR62gI9qVNNHYno8axk3t8j7gkxkj
         7ssw==
X-Gm-Message-State: AODbwcBv+/mYZza+U/F+MFaJmHdRzICluusBczLGszp0dScBKg/tr/y+
        RWIl6XZXyMyrVeynZJ+OWg==
X-Received: by 10.84.238.194 with SMTP id l2mr1374357pln.247.1496431496770;
        Fri, 02 Jun 2017 12:24:56 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:89d2:8d21:abcd:1e61])
        by smtp.gmail.com with ESMTPSA id p4sm47560104pfj.104.2017.06.02.12.24.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 12:24:55 -0700 (PDT)
Date:   Fri, 2 Jun 2017 12:24:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 00/33] object id conversion (grep and diff)
Message-ID: <20170602192454.GD57260@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
 <20170531220640.kd73vbyx6fr4ht7h@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531220640.kd73vbyx6fr4ht7h@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/31, brian m. carlson wrote:
> On Tue, May 30, 2017 at 10:30:36AM -0700, Brandon Williams wrote:
> > A month or so ago I thought I would lend a hand to Brian and do a round of
> > conversions from sha1 -> struct object_id.  Now that Brian's latest series has
> > hit master I can finally send these patches out.
> > 
> > The first couple patches are from Brian which convert some of the notes logic
> > to using 'struct object_id'.  The remaining patches are to convert the grep and
> > diff machinery to using 'struct object_id'.
> > 
> > Brandon Williams (26):
> >   grep: convert to struct object_id
> >   diff: convert get_stat_data to struct object_id
> >   diff: convert diff_index_show_file to struct object_id
> >   diff: convert diff_addremove to struct object_id
> >   diff: convert run_diff_files to struct object_id
> >   diff: convert diff_change to struct object_id
> >   diff: convert fill_filespec to struct object_id
> >   diff: convert reuse_worktree_file to struct object_id
> >   diff: finish conversion for prepare_temp_file to struct object_id
> >   patch-ids: convert to struct object_id
> >   diff: convert diff_flush_patch_id to struct object_id
> >   combine-diff: convert diff_tree_combined to struct object_id
> >   combine-diff: convert find_paths_* to struct object_id
> >   tree-diff: convert diff_root_tree_sha1 to struct object_id
> >   notes-merge: convert notes_merge* to struct object_id
> >   notes-merge: convert merge_from_diffs to struct object_id
> >   notes-merge: convert find_notes_merge_pair_ps to struct object_id
> >   notes-merge: convert verify_notes_filepair to struct object_id
> >   notes-merge: convert write_note_to_worktree to struct object_id
> >   diff-tree: convert diff_tree_sha1 to struct object_id
> 
> I've wanted to convert this function for some time.  I'm glad you got
> around to it.

Of course, glad to help!  After working on this stuff I realized how serial this sort
of conversion can be since its easy to have a function span many many
parts of the code base.

> 
> Other than the issue I pointed out, the fact that I'm obviously not
> qualified to review my own patches, and the issue that Stefan pointed
> out with GIT_MAX_HEXSZ, this looks good to me.
> -- 
> brian m. carlson / brian with sandals: Houston, Texas, US
> https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204



-- 
Brandon Williams
