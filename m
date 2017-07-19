Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB0620288
	for <e@80x24.org>; Wed, 19 Jul 2017 23:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932326AbdGSX0o (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 19:26:44 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36496 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932320AbdGSX0n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 19:26:43 -0400
Received: by mail-pf0-f173.google.com with SMTP id o88so5346872pfk.3
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q51BKTiIRJElycO5xWWqCbbmgeKuTk4A4Ilcmdry3lY=;
        b=sJTrh9ktKIKPyFDC6DfPwXytMB4YbMbL1MzeZESVtbllbMeUBdav28fYJ1v86bOaTA
         5dIj9JHB5ewq/T2HHz1GkU0stUNlAxNdIZps4F2DM2knUUgsAm61QJns0Tmbmdjk2OWc
         Czf+lMZvSXzbDw6NpQqZOmps9E6pRAburGmHSk/fAbVnYaKzdscPV30/P+HlAL5uEWLN
         VTpcqDG9+O6FehB1gYlaXade7xK4mU2u7244EeozZp9n2wKN6ZSufqvkDJ+jRai4Dj9l
         4wrdfQv13vt0cSjjfFDYEmiAGegBCn4Hn0R6wQKdL2W6mq6+s5lqkSBe0PXj6af53pjY
         bM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q51BKTiIRJElycO5xWWqCbbmgeKuTk4A4Ilcmdry3lY=;
        b=ZQRSXqcbpShCrnJ33Mif64wOH1A2mQ7uCrtbTtSbTDkM3I7KYwV7LuMTcjq//PUyK5
         923EjmoWqfi5BM9i0Q2YP+r+yYwEDCPpmvqm2VYR4raOJXRxtXg00u7lsvgSUiw8BRVe
         odGQOyKzO79fSuEpcMzp2C2bcyXr5slqvEeO0Gjpphjoc3m5/IpJ44pSsf1uZeBLRB0e
         /BAs+ZhLBnk4Bgn16sntTvyx0VQhZ+g4t8NNNEEgAAZxLhHStzFwCbIRmP7/y0q7Lwan
         FGdCXHjtO+wvJWcjkAmH3D9n7lVj1e1DY2oPyxJ+IkbkmnRyhUu4O5s2GOwIjnTFjORk
         7Hgw==
X-Gm-Message-State: AIVw110Gi+RBA7ubEl6KkHQU7DBzlLaxxgaS/voubH971l1ooHZgxkJt
        DugG1bHyo+C4d7uFozQ=
X-Received: by 10.99.97.71 with SMTP id v68mr1678104pgb.339.1500506802910;
        Wed, 19 Jul 2017 16:26:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e98d:4a71:3ce1:a1f3])
        by smtp.gmail.com with ESMTPSA id o5sm1284948pfb.184.2017.07.19.16.26.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 16:26:41 -0700 (PDT)
Date:   Wed, 19 Jul 2017 16:25:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fsck: remove redundant parse_tree() invocation
Message-ID: <20170719232541.GA13924@aiede.mtv.corp.google.com>
References: <20170718222848.1453-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718222848.1453-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> If obj->type == OBJ_TREE, an invocation of fsck_walk() will invoke
> parse_tree() and return quickly if that returns nonzero, so it is of no
> use for traverse_one_object() to invoke parse_tree() in this situation
> before invoking fsck_walk(). Remove that code.

I like the diffstat.  I'm trying to figure out what the old code was
trying to do, since that will make it easier to understand this
change.

fsck_walk_tree calls parse_tree, so why did we need to parse it in
advance?  Was it just about handling the error differently when it
fails to parse?

It appears this code comes from
https://public-inbox.org/git/20080214090013.GK24004@spearce.org/:

 +	if (parse_tree(item) < 0)
 +		return; /* error already displayed */
 +
 +	init_tree_desc(&desc, item->buffer, item->size);

At that point the parse_tree call was not redundant.  Later it must
have been amended and cleaned up to use fsck_walk.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for cleaning up.
