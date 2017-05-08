Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE49D20188
	for <e@80x24.org>; Mon,  8 May 2017 04:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdEHEhM (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 00:37:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35217 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdEHEhL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 00:37:11 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so8857751pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 21:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qKCr6FZtQQ4tvFLd6QVX7WlMW8VVfFbuIn9IbpnM72I=;
        b=oCK7QFMsvn+k7RLvDAxsZzvk28qPpNx6Iwrf/uchVhv8xlH/i66xfMRqVPLaImbzJq
         Eb2w2Zo/yLCDVDhgjxym5K6jm5BqMlz35JKRNpwTwwVDT24q5durteiIzyDZcoo3UBDh
         pa8pzDT7RDfTXBN35syyEQQRQQsPgnK3xw+9NdzFMhYPEsPagsEN9l1A10/2+A8q9cUI
         PX+OzSbO+H7JrcjWCnyv1zjoVr81qdHpstDFtMxiNQ84Zeiq6huFfMCSJy1aaEPvTv2v
         tUG1ycvbs0irBI6H3ybPwhjRmhVzBsbBh1XAxoO6z0I0YtCRihQmqCjCGU9HNnMsrLxb
         VOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qKCr6FZtQQ4tvFLd6QVX7WlMW8VVfFbuIn9IbpnM72I=;
        b=nYfJJe+F98PngWnYtXEZr+qkg0Jdu9Cqs7MQpXIk+aDDzED4bVSzqPe8IZT/cQZalf
         oi1sE0SM+hosLiao0BERyzSq8o1kx8BSsG+aUbmwp/f0MQqrOyHKEqtXihFLs+R8AydZ
         NyUKHBmX7jsxqD3x3Tei/BgTPq4bdAq2nnaUxNK2lmlZ1X99NcN2kQxbPZgCFRx3vlo9
         Te8HKiAqyK5TDjD8X1mbMrEcWSMjdNcX8lDD6UN9BnaEtD596wWJ4iRnuP1Q8dXpNhkP
         OJKodSb11RO8HvKwv2WQo7UzAVgP7CNgWR4B+2TN2CDtOPiB2TOcXRDpN9GCQLEufgV8
         5tmQ==
X-Gm-Message-State: AN3rC/6YEmEQDDoCkD/9DS/T6iggVn5xSVDaWiLPFTRLev6dd0MhRvUV
        OeK7P7u655XGm/nDDsE=
X-Received: by 10.98.112.134 with SMTP id l128mr29164879pfc.161.1494218230449;
        Sun, 07 May 2017 21:37:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id d24sm22060602pfb.97.2017.05.07.21.37.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 21:37:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 6/9] dir: change linkage of cmp_name() and check_contains()
References: <20170505104611.17845-1-sxlijin@gmail.com>
        <20170503032932.16043-1-sxlijin@gmail.com>
        <20170505104611.17845-7-sxlijin@gmail.com>
Date:   Mon, 08 May 2017 13:37:09 +0900
In-Reply-To: <20170505104611.17845-7-sxlijin@gmail.com> (Samuel Lijin's
        message of "Fri, 5 May 2017 05:46:08 -0500")
Message-ID: <xmqq8tm89d6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> diff --git a/dir.h b/dir.h
> index bf23a470a..1ddd8b611 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -326,6 +326,9 @@ static inline int dir_path_match(const struct dir_entry *ent,
>  			      has_trailing_dir);
>  }
>  
> +int cmp_name(const void *p1, const void *p2);
> +int check_contains(const struct dir_entry *out, const struct dir_entry *in);
> +

Both of these would have been perfectly sensible names when they
were private to dir.c, but are way too generic to live in the global
namespace.  When a person who works on Git internal hears a name
"check_contains()", I am sure that the first guess of what the
function does is to see if a commit is a descendant of another
commit.

