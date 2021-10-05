Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C19C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3EF610A5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhJEToU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 15:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhJEToU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 15:44:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B22C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 12:42:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p13so1141080edw.0
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pe7Lgzzf2NA/w023YkAdRTUQbIF/OJcD1ZF5qMrTmNc=;
        b=A0YvDlyTmakQcxQ4R85IXfPn96RwvLRRR15NDUEukBJ9ud4Lt3kXQOEj4IVbGAYf3s
         KJ2z4f0hugmZWzLTAJrq4Lxs/WrrajH9CreJUxi6tB+19LL+LQ0y7JLA9QYEcklqyp13
         HIDrIzJ1onIoQLVWeC5glIY8k45ucMi+hfMdF8jY6IGughpBpUro+h0LTGc7jPqrLV0j
         +e84aKUZjwZjqGEilRuoUmubvEnRNaBF+giBS8zCPKIT+lvfg4AUlcD8Zp+NYnmcf2u5
         cYBeBnQrtyyxzmJay3L7v1jqbHaOrApCpsdPX4x/4wnk2ayhyaicwNcepyENqaifC2K2
         DWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pe7Lgzzf2NA/w023YkAdRTUQbIF/OJcD1ZF5qMrTmNc=;
        b=K2vF6Sy2l/3LyNRkpBrfTeQGrbfJZWcFCH+iYiWcMDLXJBinLbJs2yMT5XjLxwvIo7
         opXgCJMMbFqHwZ7xj/ORj2exATT6AhrlDokeFmSI+CUNaQAa+bYijTi42lqQ1BcGO47F
         YEP5UhP0sdWy3J/BsWu/zfjCR1tqRwURA4krPz8cccDgPkTAVzF8f2LQYZ9elvJFJIQV
         lmfaqSab4JF9cSDQgNxtWlJX+isPASdNHtrgj3h2KeBAJg5/s+/8gS62GLmM2e/vDJtK
         dUoV011Y1WIkQYFLhU77FYycSlYJY+8aUj+eSOjAb9+SWJcpRNtxY6KObpba5LQvjlGb
         8qPA==
X-Gm-Message-State: AOAM531rC8LD/JSNHaSswtC0L/D2IS3Bu3QerzNoK4ayWp3ejuObsNm9
        KNDNeM+/qTlWYuTf6XGAuPHeKExZLiI=
X-Google-Smtp-Source: ABdhPJwithAaVhOOo1LZNb3s4Z5oulch3+sooQ/UVbN7H1tpVwg2KH1k0j3sgGmWb6hTTisJxni1CA==
X-Received: by 2002:a17:906:1848:: with SMTP id w8mr27168868eje.485.1633462947600;
        Tue, 05 Oct 2021 12:42:27 -0700 (PDT)
Received: from gmail.com (91.141.47.58.wireless.dyn.drei.com. [91.141.47.58])
        by smtp.gmail.com with ESMTPSA id kx17sm7941049ejc.51.2021.10.05.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:42:26 -0700 (PDT)
Date:   Tue, 5 Oct 2021 21:42:24 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     newren@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Documentation/git-status: mention how to detect
 copies
Message-ID: <20211005194224.qcblxih5rlehzo4d@gmail.com>
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
 <20211004190050.921109-1-aclopte@gmail.com>
 <20211004190050.921109-4-aclopte@gmail.com>
 <31f46980-7e40-46c0-87b7-f5ea7034af2b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31f46980-7e40-46c0-87b7-f5ea7034af2b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 04:48:00PM +0700, Bagas Sanjaya wrote:
> On 05/10/21 02.00, Johannes Altmanninger wrote:
> > -* 'C' = copied
> > +* 'C' = copied (if config option status.renames is set to "copies")
> 
> The config name and value can be formatted to monospace ("`status.renames`"
> and "`copies`" respectively).

I wasn't sure whether to add backticks to status.renames because we are
already inconsistent in this file (search for "config option").
Anyway I agree that backticks look better here (makes it bold in the man page).

Maybe we should automate this? We can write a test that makes sure that we
always use backticks around config keys, at least for new changes.

---

I didn't add backticks to "copies" to be consistent with this part before the context

	Ignore changes to submodules when looking for changes. <when> can be
	either "none", "untracked", "dirty" or "all", which is the default.
