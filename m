Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E916A1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 17:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbcKNRny (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 12:43:54 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34206 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbcKNRnx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 12:43:53 -0500
Received: by mail-pg0-f45.google.com with SMTP id x23so53576447pgx.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PLwGQ/MxBb40J/psV6rylg77fkigX9JYHkYg44bIfk=;
        b=BjH9R3/cA6zLobh/rs+53W0eVMGeSzfBMKSZD9lHhSZw3J2ePdpr3A2/k7l1YjBZlZ
         P2TGHRirt4y1PDD4mSJKu9H+XQR1gIV8xNjkzFT49h7+sLlIhNTQvvqWvvCo/conYvbQ
         PMxOfgQL4fXofKP8LGfb1J4bnLwVIW+FAvRAoK6fyfrS41oOj8Pp/yipiGnfg7mbvgEF
         dGUTu7CpEQXOWvDrNpH/9g/6WkB8WrrILJbgKkDi0WksJ6edHLuZQ12G3pdP6DgYzIYU
         fQbHr65CRqEw6bAHB/aklrOQmU+QYcHm9sLTka+5/GUBfIbCW0+JCuucqvIwOy59Wkx1
         G1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PLwGQ/MxBb40J/psV6rylg77fkigX9JYHkYg44bIfk=;
        b=UYflt1yYhp7YFeUE9AJQRbd3EXXFWTt0hFKowF9iN70eScIQRYrbelLzzjfbVYex8N
         iukMXmQQfWPkHtdZ5v067t5hjwGMICxRClMeNr1MNi0NcmNEnXdqPouIesIpeDHj9Q1K
         hIgGFmZIg6jqobn2+bpbZnf+qBgH9RaI/Wbrgc167RmlErPucDGL6ctIBq7BR+0et8ut
         GJJsl6kckqcPN/odjnGC/QJRg+9x4pCTOs2sHNvUFGNMm3WUp39Eb7VcS8xzhJp79LE/
         m+4gXW92hdPcpPMi2OKRXpYPOPdh9eiKAnHKN0vYQ9j4qT+8LP8fSOzWuu1E290+k/jJ
         yHTw==
X-Gm-Message-State: ABUngvcOtNu3r4uw5xzNQPR5K+WfFdWoQD8e5b71wdVK9vIw4DvEOUWCU17rZ/vxBfHQ86Mm
X-Received: by 10.99.238.17 with SMTP id e17mr30504072pgi.154.1479145432953;
        Mon, 14 Nov 2016 09:43:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5dfb:30a4:a03d:dd8c])
        by smtp.gmail.com with ESMTPSA id p25sm36731473pfk.20.2016.11.14.09.43.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 09:43:52 -0800 (PST)
Date:   Mon, 14 Nov 2016 09:43:50 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] grep: search history of moved submodules
Message-ID: <20161114174350.GA181044@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1478908273-190166-7-git-send-email-bmwill@google.com>
 <CAGZ79kbf2i5s8Y84i2Wehbffsw1dUDUY6LYPEMME3vC6zo8-aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbf2i5s8Y84i2Wehbffsw1dUDUY6LYPEMME3vC6zo8-aw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11, Stefan Beller wrote:
> On Fri, Nov 11, 2016 at 3:51 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > +
> > +       rm -rf parent sub
> 
> This line sounds like a perfect candidate for "test_when_finished"
> at the beginning of the test

K will do.

-- 
Brandon Williams
