Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE912027C
	for <e@80x24.org>; Fri,  2 Jun 2017 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbdFBScm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 14:32:42 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36311 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdFBScl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 14:32:41 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so54840898pfg.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hkDB8hyVGL5ACxgx9/qgqe4U+lGNmDzBe5nhdaR5uA8=;
        b=eepybDfVjUWiwe7qkmHA812sbRViB/CSqf9YJan4ULmLQPx1unbbjXB/thkORerlpq
         56aFQTs0y/++XyOdVKm5Q6U4ijijQLvHW5w1m7icwEIr754JrtaIUWSB6gAKJo4OVbDg
         V2RBTO2uriX7xDKa6UDunzuKAHKabRy0L/MsfmvKb0BuB/zqHtyZ7Fe0Tu7vBfzpwAPF
         ejEYKdve/Oq9jNe+yfUptfvD+f5A1NfwoBUc2x36JL4mRyDSXAoilwx8c8cEMycLtZbB
         CVAav9+586+oU5YInV6dFPvXQvetLHhrXyg8b31ijOPavFPk6cD++P2eM04q1NSw53i0
         Wvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkDB8hyVGL5ACxgx9/qgqe4U+lGNmDzBe5nhdaR5uA8=;
        b=hjj3Hl+FIp9+rw0vj2RTqk68TgHLsnMp0FQiqHur2V0AoOzG20YEoXPOkUYfguIfvk
         a3JyhL/7bSo5qe2YjRIdTkawH28eDG740ukNWMHwGt0Y3btnHUJktNrTCBnUFb1lBxM2
         bc7OG3JRwsQawcoV4fpEYvGrJap3Q5AIKa5Zuep2jksM4fBB9kH14lmwNfDBjjzW0uYJ
         kpLSuyJi0CQKqLYaFI+ObCZwXtHV2iIo1TQ6yErU6Xer7BiM1SKnWFgrPHQCvvRGmn5b
         +3P20q/HcYnxNjNwX8pjw5jksfHGQMmEDWTCBq640kKJZuqaNzO0RKgqy7vC5daU4LxM
         6zXQ==
X-Gm-Message-State: AODbwcCT77Eck/5ZSX5N6GIu7t/kJk3lZsLeaa1hN7iBXX71g9IMLu4z
        z3w1ooXzWnFrrFw3
X-Received: by 10.84.148.134 with SMTP id k6mr1256006pla.55.1496428360389;
        Fri, 02 Jun 2017 11:32:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:89d2:8d21:abcd:1e61])
        by smtp.gmail.com with ESMTPSA id n87sm40351989pfi.124.2017.06.02.11.32.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 11:32:39 -0700 (PDT)
Date:   Fri, 2 Jun 2017 11:32:38 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 22/33] notes-merge: convert notes_merge* to struct
 object_id
Message-ID: <20170602183238.GB57260@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-23-bmwill@google.com>
 <20170530185653.cfy4cbq3pmxfq5x6@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530185653.cfy4cbq3pmxfq5x6@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/31, brian m. carlson wrote:
> On Tue, May 30, 2017 at 10:30:58AM -0700, Brandon Williams wrote:
> > @@ -596,47 +596,47 @@ int notes_merge(struct notes_merge_options *o,
> >  	/* Find merge bases */
> >  	bases = get_merge_bases(local, remote);
> >  	if (!bases) {
> > -		base_sha1 = null_sha1;
> > -		base_tree_sha1 = EMPTY_TREE_SHA1_BIN;
> > +		base_oid = &null_oid;
> > +		base_tree_oid = &empty_tree_oid;
> >  		if (o->verbosity >= 4)
> >  			printf("No merge base found; doing history-less merge\n");
> >  	} else if (!bases->next) {
> > -		base_sha1 = bases->item->object.oid.hash;
> > -		base_tree_sha1 = bases->item->tree->object.oid.hash;
> > +		base_oid = &bases->item->object.oid;
> > +		base_tree_oid = &bases->item->tree->object.oid;
> >  		if (o->verbosity >= 4)
> >  			printf("One merge base found (%.7s)\n",
> > -				sha1_to_hex(base_sha1));
> > +			       oid_to_hex(base_oid));
> 
> I noticed you fixed up the indentation.  Thanks.
> 
> > diff --git a/notes-merge.h b/notes-merge.h
> > index 0d890563b..eaa8e3b86 100644
> > --- a/notes-merge.h
> > +++ b/notes-merge.h
> > @@ -33,15 +33,15 @@ void init_notes_merge_options(struct notes_merge_options *o);
> >   *
> >   * 1. The merge trivially results in an existing commit (e.g. fast-forward or
> >   *    already-up-to-date). 'local_tree' is untouched, the SHA1 of the result
> > - *    is written into 'result_sha1' and 0 is returned.
> > + *    is written into 'result_oid' and 0 is returned.
> >   * 2. The merge successfully completes, producing a merge commit. local_tree
> >   *    contains the updated notes tree, the SHA1 of the resulting commit is
> > - *    written into 'result_sha1', and 1 is returned.
> > + *    written into 'result_oid', and 1 is returned.
> >   * 3. The merge results in conflicts. This is similar to #2 in that the
> >   *    partial merge result (i.e. merge result minus the unmerged entries)
> >   *    are stored in 'local_tree', and the SHA1 or the resulting commit
> >   *    (to be amended when the conflicts have been resolved) is written into
> > - *    'result_sha1'. The unmerged entries are written into the
> > + *    'result_oid'. The unmerged entries are written into the
> >   *    .git/NOTES_MERGE_WORKTREE directory with conflict markers.
> >   *    -1 is returned.
> >   *
> 
> Did you want to change the comment to say "object ID" or "OID" instead
> of "SHA1" like you did in an earlier patch?

Yep I can do that here and in the comment below this one.

> -- 
> brian m. carlson / brian with sandals: Houston, Texas, US
> https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204



-- 
Brandon Williams
