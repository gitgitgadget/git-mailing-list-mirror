Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518A71F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 01:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJLIwo (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 04:52:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52094 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeJLIwo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 04:52:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so10662290wmf.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 18:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wN1Dt5K70XhgZaWLbo3RRSLnX/aqcQqNcff5vacQWo8=;
        b=disQ+bZ3MNnKzAfT/cQC4tG0DEmnAeaB30cB/9LPEKBLFXMohmojYhKytq/W+YS6v9
         0hHOUQ1q1U63nMJxwbbdAJraU0VKosTtMVoP/cIeO5ROoP0ZDYRPf4tjQuFjmA5s6T4o
         CbcLZyy6RVseAQly+EmuARY5cKrJc8LemZPw3668FpEERgjwCZHayJ9w4pKKngK6iXZ2
         AzCQEtIqQiJR6fD6r9JtxR/4a4ssT0qrXdWaz0yGJJJMBtEE3tQnAOk/YxdKa0jCYDKQ
         A1bbjglymuyiNMf6F2Igp0OPv6UBoUfBhYYoLgg7P3/sk5IAcG3FNPYAjLa0LQz7qRmB
         OTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wN1Dt5K70XhgZaWLbo3RRSLnX/aqcQqNcff5vacQWo8=;
        b=fzKeaxd/lM6j0Fj3xHtJYPq2hDGCTVxi2LAmXoPNPG22+eABLlvoSgByNAJNqiIE42
         LVpyI7imSFd90ur4ElXXzSD6VFiyT/ZG62zc5q5Fw12jPupyeNp2CvTZG3ykTo0pH7o/
         UOXUA4m+6r+2gDtQIIQrNoPeBdFllwPra/TFvZ3cKVMMgW07GLJhEVu2p1kIqoWonPnJ
         c9ZOk1cVoB6hrOZIq3oKhJ5fXp6WPm18D7xJlNwSF/G0xBLZAWGspcAOjkHrCADhxKK8
         c326jnQ9XELDD+omEIKpOP6p8ghaj5AxCtNoXrGqv4Qe8TAEzUaC/L8+SQNIH2X+TARo
         cfcQ==
X-Gm-Message-State: ABuFfohETWChEhVxwumGmAp1WmDrZLIVtGJT/TS7fN3XoMH1A2sgGoJr
        vGAA1lCEMThe748nVFxSudQ=
X-Google-Smtp-Source: ACcGV630RuNwAs4zsvsJ/chvpT6z4RAGtE4RcckktZfcAEmMxPdy/KTQF7YFpk4/7u3maKuRTdudRA==
X-Received: by 2002:a1c:3ec3:: with SMTP id l186-v6mr3348946wma.84.1539307368999;
        Thu, 11 Oct 2018 18:22:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e142-v6sm57537887wmf.20.2018.10.11.18.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 18:22:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, phillip.wood@talktalk.net
Subject: Re: [PATCH] diff.c: die on unknown color-moved ws mode
References: <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
        <20181011225928.76051-1-sbeller@google.com>
Date:   Fri, 12 Oct 2018 10:22:46 +0900
In-Reply-To: <20181011225928.76051-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 11 Oct 2018 15:59:28 -0700")
Message-ID: <xmqqin28dkm1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Noticed-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> --- 
>
>
>    There is no "ignore-any" supported by the feature---I think that
>    the parser for the option should have noticed and barfed, but it
>    did not.  It merely emitted a message to the standard output and
>    let it scroll away with the huge diff before the reader noticed
>    it.
>    
> Addressed in this patch.
>
>    Am I missing something [...] ?
>
> Note that this parsing is used for both the parsing from command line
> as well as options, i.e.

Hmph, is it our convention for a value that is not yet known to the
current version of Git found in a configuration file to cause it to
die?  I somehow thought that command line options are checked more
strictly and configuration variables are parsed more leniently.

If that is the case, the place that dies need to be raised in the
callchain; iow, instead of dying inside the parser, it is necessary
to let it only detect a problem and allow the caller to decide what
to do with the problem, I would think.

>   git config diff.colorMovedWS asdf
>   git format-patch HEAD^
> fatal: ignoring unknown color-moved-ws mode 'asdf'
>   git config --unset diff.colorMovedWS



>
> (format-patch parses these color specific things, but doesn't apply it)
>    
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 145cfbae59..bdf4535d69 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -313,7 +313,7 @@ static int parse_color_moved_ws(const char *arg)
>  		else if (!strcmp(sb.buf, "allow-indentation-change"))
>  			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
>  		else
> -			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
> +			die(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
>  
>  		strbuf_release(&sb);
>  	}
