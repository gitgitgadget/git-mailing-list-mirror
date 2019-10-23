Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD64D1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 16:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407180AbfJWQUx (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 12:20:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34880 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407057AbfJWQUx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 12:20:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id v6so3265702wmj.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uR5dWTsh6JLEeuJUvNX3VsKN+7xtLJWZvvfGTdQHFwg=;
        b=s3SzkQfsND4JEG8xui7Z5mbGP8AIjUD1rTJl5rjfVmtpOYM+Nm+B3pDg7LqH86zaMK
         lOOpRdk94I6wzo6lbKTfti/gofF5LrDz3dRxmHduibzPG/PNbvS17eBjquh8TaHtmvkN
         GcclS1J5oorqxgKBqmvvHuNaiREH8Oxxy/ugv0tOm4H2QdsixOOjCe+4RuqBGGuamjrn
         Z0hYsOhyPSarSwgYmF4p3o92PGzQ4OyV2+lNMMnvCo053qFN1sDYUSNbON2a6zOJs1o9
         CTnRseumPAVCsoM4wwmwcC+NbVHqeX7wzEMn+4tj/2asGS1Mm/9Ox0DU9HyQYNgB31oY
         tBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uR5dWTsh6JLEeuJUvNX3VsKN+7xtLJWZvvfGTdQHFwg=;
        b=E8kSU8sqklKvEhzWJYlQb5PJE24nizGxmey2yAj9ciKjNDIcJBjjj6lJfpVU6U8MKi
         riuH0HpL8cGhST10CYFLprnMDPc9G9cMMpw4q0FdWL5QgAuZ0H1QwVE9tFXEF7gZGje6
         /ZMEGkyTUDssYSWS1OAJZxVGJJFKavxgq/15m1qNLbLwTGy2Mchn4qcsZuiwu2OEapHm
         8xNKGAUgUWfrn+MT19ZRLFm02+dCJ+Qh126W3HfGVTgyGLqLou7ACz1aRZXU+VF3uSiF
         UY7LEGdB7HRryiB1EFBRjreJhg0Uo9JLcz4dGRMvBVIxHvsG5vuS4Eji4Cv39/aE9PDU
         Uzxg==
X-Gm-Message-State: APjAAAW8pkQ7YEPlJx1MyypdrQlmp9dr0uKQAkO1ubQ73SnpWqMXM3n9
        I1JWGe7dG7lDiBFzKcxWy9iCDHRi
X-Google-Smtp-Source: APXvYqzbaaBve6gWAX0LNqadM2ZrjOGbMaqHeTU5oJgRV76nNvYWdHA+YZ1uRN/KtcrK3uthzP2DmQ==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr700098wmh.7.1571847651334;
        Wed, 23 Oct 2019 09:20:51 -0700 (PDT)
Received: from szeder.dev (x4db97b71.dyn.telefonica.de. [77.185.123.113])
        by smtp.gmail.com with ESMTPSA id d11sm25193251wrf.80.2019.10.23.09.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 09:20:50 -0700 (PDT)
Date:   Wed, 23 Oct 2019 18:20:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] path.c: don't call the match function without value
 in trie_find()
Message-ID: <20191023162048.GI4348@szeder.dev>
References: <20191021160043.701-1-szeder.dev@gmail.com>
 <20191021160043.701-6-szeder.dev@gmail.com>
 <20191021205703.GB4348@szeder.dev>
 <xmqqa79si003.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa79si003.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 01:01:00PM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >>   - b9317d55a3 added two new keys to the trie: 'logs/refs/rewritten'
> >>     and 'logs/refs/worktree', next to the already existing
> >>     'logs/refs/bisect'.  This resulted in a trie node with the path
> >>     'logs/refs', which didn't exist before, and which doesn't have a
> >
> > Oops, I missed the trailing slash, that must be 'logs/refs/'!
> >
> >>     value attached.  A query for 'logs/refs/' finds this node and then
> >>     hits that one callsite of the match function which doesn't check
> >>     for the value's existence, and thus invokes the match function
> >>     with NULL as value.
> 
> Given that the trie is maintained by hand in common_list[], I wonder
> if we can mechanically catch errors like the one b9317d55a3 added,
> by perhaps having a self-test function that a t/helper/ program
> calls to perform consistency check after the "git" gets built.

I'm not sure what you mean by "consistency check".  The resulting trie
looked as expected both before and after b9317d55a3, i.e. each trie
node had the right contents, value, and children, as far as I could
tell.  The issue was in the lookup function.

