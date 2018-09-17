Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52D51F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIRAdH (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:33:07 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53924 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeIRAdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:33:06 -0400
Received: by mail-wm1-f47.google.com with SMTP id b19-v6so10862822wme.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=daIS+x1gyN+54z1vVnMQq/iQA6H4gbHsQDcKkoJR4t8=;
        b=jH/IFhsChDgx0OQCa5Ua9v/L99m5uGvQ8TWTcYmoOi4YBHOXiEglXz5vN16i6rUuCW
         e8xlr6z3SV1VwX+EbovMNLwnuACvcf8clMR2JVcXi9c+y0f0pFfvBmmsU98/ffGEmdVX
         oqRZnyIRpKvppJLCnUv0HehX5GNBYkjwwkk9JRO4eN6QODAiacRr3AcaETmqFef2SNVA
         zDTDd8VFM9SCwQs35q0Tcwlf0VVSVcI3rxpK9mWF2ikSs14an9fhVufyL0Nmo4NrjZUR
         ePy2JpDjyoBbxnx1IS/CtfY39UVs0JeOmehu++QzQ4ainSLyzEE0Sof7kcFyYInUvRCa
         vmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=daIS+x1gyN+54z1vVnMQq/iQA6H4gbHsQDcKkoJR4t8=;
        b=q6kMpojA6wF0Fsj5vMcWPQOVjZBGn/4ySBujm/3n53/OKzQzRro2go2ZAQNy0om6rK
         WUTwpSsIamYEHLrST8ITZDGq7ShfJksHQAp8BZRMh05+Zs8UM+lcjbzhHF5UGOvmhENx
         b68icX0cmv63BC8SjE5ASnVZNBPs1+O8WLTdWEZJ8lPodvYu1lCxaiL1lMcLZ8GJ2r6v
         dQDCeSxCBvkOaWlNMCMksSvhCoctmRJxw5+shtLtFxMAO3+AE/zxoTAsH22738HNuav/
         1Zmlrcy0ezbsIh7/Q8LttiP+D77pnSJPd9CluDXv9tEuauFpoOgy3Dq+oEs3pVRuyFcH
         Dahw==
X-Gm-Message-State: APzg51AajTCZBmHqtg0cfnIvBPfX2mETcbcDfzwJNzDFHV92gcdMTN/Y
        6PgMsvnLPeyY9lly5wBkwDg=
X-Google-Smtp-Source: ANB0VdZS7GGCQJr1UP1XaSQgmWNhu16yCetrbE1Ub3FagxeIG+qZVTm1s2kg7UPKhmPWKRR17kIEsg==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr12703699wmd.76.1537211065975;
        Mon, 17 Sep 2018 12:04:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z184-v6sm34346wmz.0.2018.09.17.12.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:04:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
        <43e8d5aa-5418-2e2d-2097-9e21e7a74825@gmail.com>
Date:   Mon, 17 Sep 2018 12:04:24 -0700
In-Reply-To: <43e8d5aa-5418-2e2d-2097-9e21e7a74825@gmail.com> (Derrick
        Stolee's message of "Mon, 17 Sep 2018 14:35:49 -0400")
Message-ID: <xmqqk1nk6j47.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>   Replaced with a newer version.
>
> I think this has been the same note for a few weeks now. What does it
> mean? Did I send a new version out that you haven't picked up?

It just means that I didn't bother to look at the current status
message for the topic that had no activity X-<.

> Also, my "git log --topo-order" series was never picked up, but I see
> it has conflicts with 'next' now, so I'll rebase to resolve conflicts
> and send a v2.

Good idea, as I do not recall anything about that series.
