Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC4B1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeKTGvW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:51:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35740 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbeKTGvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:51:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id v1-v6so7978744plo.2
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 12:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2YJM+U8d/i//jbamKGnpro8LloNQlcbVHDWdw6V2qJ8=;
        b=NSIlXbU3Bf5ntKEDA9JnREKCsfoptdT4vTlwuCKEruVx8LDJ3VVu6pwdj9T/FpDrm/
         +2/cX/zsFoKp3lZjNuwCAwk2eYU/HaI93prRb1ctpNBUwUnk+oVrtGj46GCQRE0AhVLL
         iBB3hDAnIarDcFnCVawShYgwcZjf5VOh537ukyTWTb+06Dre7Tp2tBvvel7j3EEozdie
         mFKuaxPciMgALyOd38YfJ09rbFX5AUU7/O3hiY6UTu6UVhGvkSVzXeCqjirzB1bU0zJy
         49AKHK3g7sLFdXeW3HI+YjSAkAR4xwWaWApMw+M7LXOxBnPhIKkPIsRnqxBiCYMM/Bzz
         LNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2YJM+U8d/i//jbamKGnpro8LloNQlcbVHDWdw6V2qJ8=;
        b=RWSNoVP9rMMA456iDFVahzyB+OxmnuKhPkWH95HhIxScjPR7beG5pwUZ+w97I1l8Un
         PS8eyDkZEDAZN4wqqPFNlHSMOFLe3rEVQN0Sj5e4rRXqmfbf7OpMBKrEpy4+i6yv4Bjj
         JZNtWkzm262m13QjPE9mWUFC2pRrWbEZzUiqsPahKrXKVCriGYBNrYAOEbQz1c9ClNVF
         JNepVo3F8o6BgkYb00SduDd1IUrNItmHtlSMcq8+wKTKXXlYUG3DE3WOxugKxo72n9Ki
         n0yW7ChNHvWo52VENKrFMtku71B2PWT1VT3tXdPDwBdF9ZJOqSOYE55E32n9We7Z9WsV
         MKkQ==
X-Gm-Message-State: AGRZ1gL4TnDRl8GXPwjcKtLNfVKKx5px2U6NlbSxMRFrVDOWB5y0G+Je
        RSdZJXeZhxEf5oTeBBx7dCY=
X-Google-Smtp-Source: AJdET5dc45H+BE/g2tT4Tzll5wQdbJ9Rkf69rKSQMf5/6A6Vv3jtadGJekVHDelqbaeB0SxEyxy+Sw==
X-Received: by 2002:a17:902:9045:: with SMTP id w5mr19493334plz.32.1542659164072;
        Mon, 19 Nov 2018 12:26:04 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id c4sm1776802pfm.151.2018.11.19.12.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 12:26:03 -0800 (PST)
Date:   Mon, 19 Nov 2018 12:26:01 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
Message-ID: <20181119202601.GA229542@google.com>
References: <20181115005546.212538-1-sxenos@google.com>
 <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
 <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com>
 <xmqqftvxertd.fsf@gitster-ct.c.googlers.com>
 <CAPL8ZisfhNqN3gh0E_=mwXuBPGRZ9fKgyQ=HWNFx_9m2job-=g@mail.gmail.com>
 <xmqqwop9d7oq.fsf@gitster-ct.c.googlers.com>
 <CAPL8ZisOH7vAPGSCv-RGZdYf56AjgvxXU6CQ9U7rir76u2ga0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL8ZisOH7vAPGSCv-RGZdYf56AjgvxXU6CQ9U7rir76u2ga0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Xenos wrote:

> Lets explore the "when" question. I think there's a compelling reason
> to add them as soon as possible - namely, gerrit. If and when we come
> to some sort of agreement on this proposal, gerrit could start adding
> tooling to understand change graphs as an alternative to change-id
> footers. That work could proceed in parallel with the work in git-core
> once we know what the data structures look like, but it can't start
> until the data structures are sufficient to address all the use cases
> that were previously covered by change-id. At the moment, meta-commits
> without origin parents would not cover all of gerrit's use-cases so
> this would block adoption in gerrit.

By this, are you referring to the "Cherry-picks" list in the Gerrit
web UI?

Thanks,
Jonathan
