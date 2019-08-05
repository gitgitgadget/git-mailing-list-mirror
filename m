Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55CE1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfHER5L (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 13:57:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36806 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHER5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 13:57:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so85367454wrs.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PnAVlUdN2HrA2O4oxm3y5VJuRn2RaE8vfsQj0RYwdkU=;
        b=nPbeVhGUZMRUufzZEvv8xJQCPs6JArq9LoOo/9uhKU/AwqkGOQuD8v5cmVnLxL8hmH
         NxW+cHTQ+Na08qTveJbF5TKRofI+utPU2yAnR9NJOVnlKXsIQsQvYtDL9umZA0d3wq2Z
         ezxtPGZf7agvC0aiLXYFex5T0IbZXrgG6ciJjFBWYFOW+kbn4QmaBFatdgIJ9B7NiJ8K
         JFXYaYnSW33yVK1+5bTFLJErK0tI9gl63oFMglyvEbxH1K/XddJ2j7eAMC9FNwl9emuK
         cDLTlbSsJXtHB1laxSSYNc0QKR74GzvC8bobZkHnMDVzTrMjeJGx9AykXasRGOWST7iv
         TRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PnAVlUdN2HrA2O4oxm3y5VJuRn2RaE8vfsQj0RYwdkU=;
        b=GIakXCV0xi+fjShozPBVuN03vw/foXJsGn9D6BjyGgEPhIQyvRf5CDHWYmqOyGMTXj
         /0HmLOeueMaGMJMEhJ6/5sr3S/I+v8ywPbLwUJFmWqWr5+FowWXoXtM9WZVVmUtBdBAq
         MOqPNODZevf/WlFK5g0md23GE1fOJVOwHXC4RtXed8eVEwPGHiwrpCxuedWysTxSmhAK
         F9v77CTAlhr1pXedBeQHT5oPrjCE61wq7apj5JyJN2UiFP8WayoeIKsjz7G9UV5h/kwu
         OY9cyQjcprMEnma98cPo9Up3vhqBpz6OVR0Wa8RBSRdPNvcBqvcfeK179luVurwlZleF
         ZyBg==
X-Gm-Message-State: APjAAAXsGhfyB5o56HjdbpffZ++h/uIyqDMBYwnolm4PBKWZmpxcGLa4
        rxCNTLDbbZnhWWNopGmy6ita1Dzk
X-Google-Smtp-Source: APXvYqzy2339FfIdWvw6wBOL0oBrsIBwwMti7++CoNdtYa5TbiGqBfp6UitFTD1wcfwR/UIlxKlf8Q==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr15903716wrj.272.1565027827844;
        Mon, 05 Aug 2019 10:57:07 -0700 (PDT)
Received: from szeder.dev (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id v23sm75896718wmj.32.2019.08.05.10.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:57:06 -0700 (PDT)
Date:   Mon, 5 Aug 2019 19:57:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20190805175704.GC20404@szeder.dev>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <ecdd6c01-5ee2-6869-4eb3-1eb45f4c335c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecdd6c01-5ee2-6869-4eb3-1eb45f4c335c@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 05, 2019 at 09:57:19AM -0400, Derrick Stolee wrote:
> On 8/5/2019 4:02 AM, SZEDER Gábor wrote:
> > While 'git commit-graph write --stdin-commits' expects commit object
> > ids as input, it accepts and silently skips over any invalid commit
> > object ids, and still exits with success:
> > 
> >   # nonsense
> >   $ echo not-a-commit-oid | git commit-graph write --stdin-commits
> >   $ echo $?
> >   0
> >   # sometimes I forgot that refs are not good...
> >   $ echo HEAD | git commit-graph write --stdin-commits
> >   $ echo $?
> >   0
> >   # valid tree OID, but not a commit OID
> >   $ git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
> >   $ echo $?
> >   0
> >   $ ls -l .git/objects/info/commit-graph
> >   ls: cannot access '.git/objects/info/commit-graph': No such file or directory
> > 
> > Check that all input records are indeed valid commit object ids and
> > return with error otherwise, the same way '--stdin-packs' handles
> > invalid input; see e103f7276f (commit-graph: return with errors during
> > write, 2019-06-12).
> 
> Consistency is good. We should definitely make these modes match.

I was also wondering whether it would be worth accepting refs as well,
either as DWIMery or only when a '--revs' option is given (similar to
'git pack-objects --revs').  Dunno, I'm a bit hesitant about always
accepting refs as a DWIMery, this is plumbing after all.  And I don't
really care whether I correct my bogus command by replacing 'echo'
with 'git rev-parse' or by adding a '--revs' argument; the important
thing is that the command should tell me that I gave it junk.  And
that would be a new feature, while this patch is a bugfix IMO.

> > Note that it should only return with error when encountering an
> > invalid commit object id coming from standard input.  However,
> > '--reachable' uses the same code path to process object ids pointed to
> > by all refs, and that includes tag object ids as well, which should
> > still be skipped over.  Therefore add a new flag to 'enum
> > commit_graph_write_flags' and a corresponding field to 'struct
> > write_commit_graph_context', so we can differentiate between those two
> > cases.
> 
> Thank you for the care here.

Well, to be honest, I wasn't careful... :)  but running the test suite
with GIT_TEST_COMMIT_GRAPH=1 resulted in about a dozen failed test
scripts that traced back to this.

