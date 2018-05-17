Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158851F51C
	for <e@80x24.org>; Thu, 17 May 2018 21:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeEQVcN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 17:32:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53736 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQVcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 17:32:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id a67-v6so10786467wmf.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NDxMa6SBqQW9+kD6GshaWF3OnM70fluaf2rqFmwafPw=;
        b=k6stdlTfcvzfdvC0XLyOdncnB6D0DavNQyJwAOetZhRBzbuz2sGeOXpoQJxQ2ZLN+Q
         WJjaW0JaR72nOFYtNDwBTw1qMeXqvQLUtydTFZtcT3EPEOG6+UW9CF0HplbAqR9R+4az
         rpTzrdf0kNN3VqyImtAv59iDHuuhSAFuCGCF1kZRwMLloMe7NghWG1OfDroGypHZKpDE
         VgHt2W5ymOEHZrQMOvgLQnyjLpjJLZ7iTqXHoB1n05SPCT6OVu66rAF/+V9k3Nf7/0xO
         3Bx1kmZwcL89ZTZsAYnsVq73YxUwmA9nglkfq9C2/3u1veQoLlXLbVU7T8HOPAerEWGI
         z8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NDxMa6SBqQW9+kD6GshaWF3OnM70fluaf2rqFmwafPw=;
        b=PctBv/LHJkjiJovn6BNzTDfkW5CsBJgfyyyBRb09dA8Jt/66QmUB4nwEEcrEzE5l12
         ChhIrhV0X7ut1QlL9B29te5JK2d7fq1hWS1xcgPYN7v1W4akP5GT9f1Kc/77G5911Q50
         AeH0YyzqiYX/Z34Oasy+eX1VAmlsNOWPrVoBj9vBS0MFM7E50UFKgIH1nE05H0y0B0n5
         FDOtJmH4NFt9hWSp39+76EJBzLw0OBN+RvnXD9SaLr4Wf9d/gl+ZrJjat2PIbTJs/DBR
         FEC1/WPn/8vEDlNaqjDfRnxDTPPFSNyyHOXMPqr/4FBWVEEX+A4AdmbPc3jWm3KDEidu
         oErg==
X-Gm-Message-State: ALKqPwcu430BrjfgmVWkOqXPnzEDxh1NF4m/IksJ+NRUlVVmhXsqH/y5
        /d7WX1Qo7ZcRgjCzel2zgPI=
X-Google-Smtp-Source: AB8JxZoTTjHKJQDNMe1gsmY0+vLHDkOpxkE2tS6gZ0dI3EOBch0JEw3ceu9tx8bEoE9PDpDF+U8kIg==
X-Received: by 2002:a1c:512:: with SMTP id 18-v6mr2736865wmf.47.1526592731085;
        Thu, 17 May 2018 14:32:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l69-v6sm8350139wmb.6.2018.05.17.14.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 14:32:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] generating ref-prefixes for configured refspecs
References: <20180516225823.235426-1-bmwill@google.com>
        <20180516234822.182663-1-bmwill@google.com>
Date:   Fri, 18 May 2018 06:32:09 +0900
In-Reply-To: <20180516234822.182663-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 16 May 2018 16:48:20 -0700")
Message-ID: <xmqqr2ma55pi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Here's my short follow on series to the refspec refactoring.
>
> When v2 was introduced ref-prefixes were only generated for user
> provided refspecs (given via the command line).  This means that you can
> only benefit from server-side ref filtering if you explicitly provide a
> refspec, so this short series extends this to generate the ref-prefixes
> even for the refspecs which are configured in 'remote.<name>.fetch'.
>
> This series is based on the v2 of the refspec refactoring series.

Makes sense.

>
> Brandon Williams (2):
>   refspec: consolidate ref-prefix generation logic
>   fetch: generate ref-prefixes when using a configured refspec
>
>  builtin/fetch.c        | 19 ++++++++-----------
>  refspec.c              | 29 +++++++++++++++++++++++++++++
>  refspec.h              |  4 ++++
>  t/t5702-protocol-v2.sh | 14 ++++++++++++++
>  transport.c            | 21 +--------------------
>  5 files changed, 56 insertions(+), 31 deletions(-)
