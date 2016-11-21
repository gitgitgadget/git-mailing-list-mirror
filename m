Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7954F1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754225AbcKUSOl (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 13:14:41 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35250 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbcKUSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 13:14:40 -0500
Received: by mail-pg0-f48.google.com with SMTP id p66so132759823pga.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q4FW2TaXkNWW+cz3L2ZhDI471xOphnoTz6x6Bwv2Ljw=;
        b=irC41G2cVR7O1oVWWGx5w/sCa9P84OL3ZE8N2jkgP7i+ZeF+uLqNZXErLbybmFjplE
         KXA2zfwsSsfXfPfLKEzWaFyitNgGfsOirBiB4L2rl1A1YhKtCbUqSabQ+MVdyZpvKW8I
         o6NR85bejZSyS4xCTYFCRMDEwj1mqytPKiIjO1Q80WlY8GtCuz2C3b1ZSbWM3XwtVjE6
         iD8JTmLzfSgeXvuAWl6/jOFIY378wNXxVfkWwQ6hf3TLqi5uclC4TXAb/MEiTScmwufE
         1/Jv1wGSnKFTNb4linB812tk44kZMSucoWrIaYTTpRHdTU/ZNWpWw6azbJZSBYf2P7iz
         md4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4FW2TaXkNWW+cz3L2ZhDI471xOphnoTz6x6Bwv2Ljw=;
        b=k6CM5fb5m1pYrTEnUf9QkruBIrPoUfZPpsICYS03v0i/On/uUZ2hA6lUD3JUOWjFcW
         zV9ppc57lqKD90OMtfA6uAcvUsrsLK3dEla+vmJHcRPNleJSfrDBtZCg8kkeEeYFGgyM
         q7usGaSukna8gdTqxdJtvnJJqqWmHe3i0kGT3shN0fDIUs9CD8uxO0b2uHkq+yg85OYd
         KwIv9sRfBFJo4zaXASr+go0e7skIf+KU2X7rHXV8iE8rHfyOwL+v49fGA5cXpxDv0pZq
         CLtGkIkSqMIYpdlwcb5iY41fIEm/eqYMMs1Vqjuio0d30vAPZU5hpFsi33kmiHuPnv8Q
         aCxA==
X-Gm-Message-State: AKaTC02pecB8EdNAT3Gj6Qksruj2F4dl+CgRhZf1rSYAw6J5L3ATdx1vF8N35B1xz1RBSvKG
X-Received: by 10.99.54.140 with SMTP id d134mr34601413pga.132.1479752079534;
        Mon, 21 Nov 2016 10:14:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:9837:5b20:fc2:14ed])
        by smtp.gmail.com with ESMTPSA id t184sm21113494pgt.36.2016.11.21.10.14.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 10:14:38 -0800 (PST)
Date:   Mon, 21 Nov 2016 10:14:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161121181437.GA149321@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479499135-64269-6-git-send-email-bmwill@google.com>
 <xmqqh974l9bz.fsf@gitster.mtv.corp.google.com>
 <20161118225220.GA76630@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161118225220.GA76630@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18, Brandon Williams wrote:

> Also, in order to use the tree_entry_interesting code it looks like I'll
> either have to pipe through a flag saying 'yes i want to match against
> submodules' like I did for the other pathspec codepath.  Either that or
> add functionality to perform wildmatching against partial matches (ie
> directories and submodules) since currently the tree_entry_interesting
> code path just punts and says 'well say it matches for now and check
> again later' whenever it runs into a directory (I can't really make it
> do that for submodules without a flag of somesort as tests could break).
> Or maybe both?

Looks like my initial assumption was incorrect, I just needed to be
smarter than punting when running into a submodule.  Should be able to
just ensure that the entry matches up to at least the first wildcard
character before punting and all should be good.

-- 
Brandon Williams
