Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C762023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdCAVJM (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:09:12 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35403 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdCAVJK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:09:10 -0500
Received: by mail-yw0-f176.google.com with SMTP id d1so43011866ywd.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ViELpjSvZ6wX2jz9Pt5/5iRgH7XbfvWE1Lw1gy2uFs0=;
        b=j3rJHb9wyZgahRtBtCMTOOZEiTEFIHf0LdcqmB79ZiAm/Gz+9KTzFRKAsH+dfy78B6
         p17xKk86uYf0/XYHgnDPJ0K0sS19oH3Yfy1+T4qiCWL/Azd2QVknCZL1gI1NdGDmjasJ
         EEZT/wX7F8TT0l8WaYN1Bz7jAM4G2vuYYJMdgLVv+igcQGO2wl36+zUZzTh1SXkmjYMM
         E+Zdv5GBr6lmEcl3WNZaB+bDvPbSLfbN8QAo72oaEl1++W6bO8/4HSx7Tr31lmx69iEL
         VnhzBqAeYmMIusDLssnGbc9mXxwd4kS5UK0r7kaPFohzmBQF/n5NOolj1g7HTZT0o85L
         xoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ViELpjSvZ6wX2jz9Pt5/5iRgH7XbfvWE1Lw1gy2uFs0=;
        b=rJcSc29imITD+G6ZOJK4FIulK6cm/+rq6OE0OmSS+kJnEPBNPrw3QlOGnY154H1sEN
         gLMb0YcW/mcr636Db16M+LOmvb7N0G7XxDq6ZRH4r6hPWuvc63/fom130O80Ahm0OSfr
         zOEjMd3DtQ9+JEhoucYFB8TZ38qBDZkc0uSeeltht7Qwttz+RPcJxoGmcl2IEe/UtPsu
         VB82D3EbvwYS9y4drI2e7TF+t5a85MN1Qw9xVPb5yVz6jyDT3ea2r8cgnhKiN0bfWUHd
         DjC+IXGmtwD9jH1Hugu5NCCy7liDDgaYHINeUaw5owajNQPBfAUupeXHoiwkLvDCKA8K
         e+1w==
X-Gm-Message-State: AMke39mwdpZFZMkR8+9pT+nTdU0p7nwD2uXgaKpWYSlcLHotC3d/K4MYbKxty17f62xHKBh+84Cqm8JhOnZ/Vw==
X-Received: by 10.37.73.194 with SMTP id w185mr3828893yba.5.1488402504543;
 Wed, 01 Mar 2017 13:08:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.67.40 with HTTP; Wed, 1 Mar 2017 13:08:04 -0800 (PST)
In-Reply-To: <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
 <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com> <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 1 Mar 2017 16:08:04 -0500
Message-ID: <CACPiFCKG7K4jGLHRBA5VrdhLwjqj6KPWS2NYtHjmSdfcRhm+2A@mail.gmail.com>
Subject: Re: Delta compression not so effective
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marius Storm-Olsen <mstormo@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 1:30 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> For example, the sorting code thinks that objects with the same name
> across the history are good sources of deltas.

Marius has indicated he is working with jar files. IME jar and war
files, which are zipfiles containing Java bytecode, range from not
delta-ing in a useful fashion, to pretty good deltas.

Depending on the build process (hi Maven!) there can be enough
variance in the build metadata to throw all the compression machinery
off.

On a simple Maven-driven project I have at hand, two .war files
compiled from the same codebase compressed really well in git. I've
also seen projects where storage space is ~101% of the "uncompressed"
size.

my 2c,



m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
