Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0B351F597
	for <e@80x24.org>; Tue, 24 Jul 2018 19:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbeGXUqi (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:46:38 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34745 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbeGXUqi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:46:38 -0400
Received: by mail-pg1-f182.google.com with SMTP id y5-v6so3597295pgv.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iT6uE7Ws02CvDDerJbHlbPe/2PmHhk2j0FfdD7buEnE=;
        b=SCHlqmzr3MV8ll/OKaTcGK3OEIaQs9R6TVGuvS6LnnqMOwms1oUrPcsI9hwYBgVCjR
         MXW/oM+711Y8fk8HNJpohglgMctpk+GlblwCG39bRjnNJDGUiBsgSekMaBBD8ugkDJWJ
         o5BbexXLF2i8WKamx4fy5Lb7dgUM81kHlOQRHL6zxsSrrrlBCFLsYupJUMZSHEpPXaRS
         ptFK+hLM7mXBw1GlIE1HlfboFIDU/IFT6fSp08ixVJQqpo0lAY5yhum2rY0YCVJ5gT89
         lDovEVQdlIa+jMkA4yV4+Jlsuk+T9GKMh8R1OALH3CUq7v660nkWygZvaMwwhBrwMf9B
         LGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iT6uE7Ws02CvDDerJbHlbPe/2PmHhk2j0FfdD7buEnE=;
        b=jN94lIkeLKgqNaNAUWihfBHmiRaeLgizo7YoXcaRQpSKuMhgnLb1C78FegPvfy7Frd
         YaRkHqZYDpega0gvhuXFkSTbqrjJe+W6uA79FvN6ZqdapFsUew+oLzL1m81DjXcIAuB7
         BIFIIi43MSexcn1PzwAWPUdCcqgO0MdtX9QfN3iZ4rPcHrJD1KDcTZq6tuP5yqbLA61l
         CslhjF8ssTOEvZP0P2UXluRIVVt4kgCLezVYyvn7gCvhfJAusURkDiw2hIIuD653dPof
         1eS8zdPHbF2sywLYo7nd9F3WCtdZDWT0dVe6edVlNRNNWCw4FbuFSRxjchwGVyokCPKD
         tazw==
X-Gm-Message-State: AOUpUlEe7Qj6TlnMLqVN/Kbk/9x88udnYBXJEHaEoxLjF/BUf8H8ZqXr
        +Q6V7UfPzfTEreehg9U68+jvNg==
X-Google-Smtp-Source: AAOMgpdVxbls0w+I/N9Ntgij91eIcwM2Ox/1iU0GnI+vMHxOkjcvLVFnGRQwW7DvcC3NstCruqt3Wg==
X-Received: by 2002:a62:6003:: with SMTP id u3-v6mr19202450pfb.114.1532461119103;
        Tue, 24 Jul 2018 12:38:39 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q28-v6sm22934074pfg.144.2018.07.24.12.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:38:37 -0700 (PDT)
Date:   Tue, 24 Jul 2018 12:38:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
Message-ID: <20180724193836.GD225275@google.com>
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
 <20180723182149.202859-1-jonathantanmy@google.com>
 <xmqqd0vcxwfu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0vcxwfu.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/24, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> Here are the topics that have been cooking.  Commits prefixed with
> >> '-' are only in 'pu' (proposed updates) while commits prefixed with
> >> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> >> the integration branches, but I am still holding onto them.
> >
> > What do you think about my fixes to protocol v2 tag following [1]? There
> > was some discussion about correctness vs the drop in performance, but it
> > seems to me that there is some consensus that the drop in performance is
> > OK.
> >
> > [1] https://public-inbox.org/git/cover.1528234587.git.jonathantanmy@google.com/
> 
> Thanks for reminding.  I think I was waiting for Brandon or somebody
> else to say something after [2] as the final confirmation before
> queuing it, and then the thread was forgotten ;-)
> 
> Will pick it up; it seems to have some interaction with Brandon's
> 6d1700d5 ("fetch: refactor to make function args narrower",
> 2018-06-27), and I think the correct resolution is to move your
> removal of "&& !rs->nr" to do_fetch() function where that commit
> moved to.
> 
> Thanks.
> 
> [2] https://public-inbox.org/git/xmqqd0vwcfkr.fsf@gitster-ct.c.googlers.com/ 

Yeah I still don't like it from a performance perspective, but given
people rely on this functionality I've been convinced its necessary for
correctness until we make other changes.

-- 
Brandon Williams
