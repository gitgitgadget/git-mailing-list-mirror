Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E46E1F45F
	for <e@80x24.org>; Thu,  9 May 2019 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEIR64 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 13:58:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41184 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEIR64 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 13:58:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so1496503pls.8
        for <git@vger.kernel.org>; Thu, 09 May 2019 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Hm/1+Bx7TOethQ/nczcQvAAFU92bz1vGR6T8RLOLYM=;
        b=hydcpLgPJ4/a1b9c7yp3keVYqvf7YwVhWcL5ETCHtRBmg1Yz3Gv3orCJULX0mQPwTt
         vuDjQiGZmwfVfBEEp10k+fb6avis6YTETkq2GPGNRDgCLklsuPHKj84MhqhEFrLQg7ka
         4FLzHZkb+iVHJbcdN0L/P3psfRW6cUD9k3CqWslR60F5ZSVwd4vh9TC37eL1lduueQsX
         QJI6iRuYPKu25CXwJhiqaSQRlMezodj7AwYogZKfWoMhJ/sVQ4A4lx1GWjWobYoAFV6X
         7qnhdiH5nqI30OFS7W+Jzrkxstm9xmLJJBY9NGl56gw6E8WnWj4UGA8xzpZw92XPAUiD
         ZfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2Hm/1+Bx7TOethQ/nczcQvAAFU92bz1vGR6T8RLOLYM=;
        b=hFcCJ/aqE1vFAUleqTuarvPab/Ir8TF1AVcNtGLKrvWRQ5jPvlId0ilShHx5A+dlJq
         aFlJtva0L119SiLolu9iZKzOGqiVe1+TKrYKKbno8e2Q4U5dBuG3Jw1GWpYyntPs3u44
         8fK5lMPP/0wi4yN85B6wOracoffkbi9kD4zRAfustvDav3iPx6XYFsQ6w/esX9SbvXIT
         EtvuiNEJpqHAn5cZyPk0CRifU+P2YpV46SkRuSK7eUHD9amJ+Eewro21NtLbgWu0kwd+
         8iYUIa7vKvXGdOHpQ1wGmtkU0dR3Ovud72bWWYkICHHUz/4WD0GX/WHMslDKbe1yXpJQ
         2XMQ==
X-Gm-Message-State: APjAAAU1CrNfL9SaGFAAoqSjWDXEBM6xqlyGG2a4SyONpdaT/uXYqrnF
        YvUMpRGdWqS92ogtBrvDCvLpMQ==
X-Google-Smtp-Source: APXvYqwamanHReel618At+4Qt7UEeCbUBZBKzdXCiZydwCoW4XYtUUlRtazb1bPz0HW/MdMyepWh7w==
X-Received: by 2002:a17:902:22:: with SMTP id 31mr7068543pla.15.1557424734961;
        Thu, 09 May 2019 10:58:54 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id e8sm4722888pfc.47.2019.05.09.10.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 10:58:53 -0700 (PDT)
Date:   Thu, 9 May 2019 10:58:48 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/11] Commit-graph write refactor (was: Create
 commit-graph file format v2)
Message-ID: <20190509175848.GE26779@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net, avarab@gmail.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
 <pull.112.v4.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.05.09 07:22, Derrick Stolee via GitGitGadget wrote:
> This series replaces ds/commit-graph-file-v2, and I'm using the same
> gitgitgadget PR to continue the version numbers and hopefully make that
> clear. This is a slight modification on patches 1-11 from the incremental
> file format RFC [0].
> 
> The commit-graph feature is growing, thanks to all of the contributions by
> several community members. This also means that the write_commit_graph()
> method is a bit unwieldy now. This series refactors that method to use a
> write_commit_graph_context struct that is passed between several smaller
> methods. The final result should be a write_commit_graph() method that has a
> clear set of steps. Future changes should then be easier to understand.

This series looks good to me.
