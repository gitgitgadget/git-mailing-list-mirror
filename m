Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4241FAA8
	for <e@80x24.org>; Mon, 15 May 2017 09:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760363AbdEOJYP (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 05:24:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35432 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760355AbdEOJYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 05:24:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so15115544pfd.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qU781aMSmO30v2hKdP80VY6J6Q89/8GKNc3w2lTELY0=;
        b=eVaS/TiWjBXQ4/gCNTu2rZtyKitDtznenTsELyys8p0nEOli9dsQPhqWIV6WmbHPSo
         38sgIS2NUdP6tli4N6nL2zsG8fQj4ag4gzUySL4+4PU128qHQcojBv1bdI2YUehu5hNU
         G2e0LzATaEu0k+4eTVjNCFC4UKaXy5/n97GwFfNyEc6vBvrUewQerRq9l9FVXUkNSejZ
         nAzSaK7Ypa3aDRNfZQejIeNsmjnEEtL7Xy3/xJxRVPN9qzibpRk5F8N1eT0qDB8992oO
         O6aIAdQ/SyglhyykKj5FMgnnOpPwqd48sJPMmnrfXCaeJ3BH9WSvohWKzqZsptyi0qBz
         DihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qU781aMSmO30v2hKdP80VY6J6Q89/8GKNc3w2lTELY0=;
        b=VVOedB0RVlXWht5Fd+zw4iroXjYuATn0v64onQ3MBOLNYyAVB4AzIuw8CC9l0Z/mAu
         RuRZPca7nQRH8ctON/OmcZtcdNd31dcGuf9BGVLatoqsYsiri0pHFovAknrYUBn0BFKV
         sWJQDv+JHS6BPWfB/G4ISi1ENAMbKVwPjwl4BfmtkFpkJLZ04TVDz0Tv/yDyKNChayOL
         R0ONbttXgL625qCRtYQMtlyZDI+SxiOshF5kj4/lJ3se+d4aCB12g9SQ5cm02l2h6Jre
         b5smsUalbUwXXWDZkbLu4RnDpzZwmnmQfUkWP0C9c+AAFjly15Qqrsiqr4UP/6frg+70
         ZI8A==
X-Gm-Message-State: AODbwcAM2rALPdVSvSjiokPswMFMtS6gmW6/9QQorVqHlrjszUn0d9ZU
        JUfvuodO74qg7iHF+Us=
X-Received: by 10.98.158.136 with SMTP id f8mr5151939pfk.90.1494840253673;
        Mon, 15 May 2017 02:24:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id p89sm656874pfk.67.2017.05.15.02.24.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 02:24:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH v2 00/22] Add blame to libgit
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170514031513.9042-1-whydoubt@gmail.com>
Date:   Mon, 15 May 2017 18:24:12 +0900
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com> (Jeff Smith's message
        of "Sat, 13 May 2017 22:14:51 -0500")
Message-ID: <xmqq7f1iv5fn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Rather than duplicate large portions of builtin/blame.c in cgit, it
> would be better to shift its core functionality into libgit.a.  The
> functionality left in builtin/blame.c mostly relates to terminal
> presentation.

As I said in my review of 04/22, it is a bit hard/tedious to sift
the changes to refactoring that actually changes code and pure
renaming and movement of lines across files with the current
sequence of the series, so it is very possible that I may have
missed something, but from a cursory read through the series, from
the comparison between master and the result of applying all
patches, and inspection of the resulting builtin/blame.c file, I
think what this series does is very sensible in general.  blame.h
does not seem to expose anything that is not needed, which is a good
sign.

