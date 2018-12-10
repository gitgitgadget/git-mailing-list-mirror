Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E9E20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeLJSxa (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:53:30 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41003 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJSxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:53:30 -0500
Received: by mail-pf1-f173.google.com with SMTP id b7so5823702pfi.8
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=36ZCLpuofRUFVHfS0pKHyIeCvDjSMratUuKqOUXTzN8=;
        b=Ut8COWIyVAPIfAW/6MyY4W6VPNmZv1cxi6OyTZ8vp7ujQEMBk8TPo4ZcR9sJL8aUtS
         fUmssQfGhbDbDtAf0SZiJoz9YvtydUV+AJcIYO9ZMLEJQ8JMhbs+M5rzHA441r0bZOcP
         cr3AANX05oMeIMfwAupO6YP5m/V0XoPZ2HD5voNTKvpS2vPwfXCBuWiNho4X4nPOGfxf
         YbvqXCcDCBCBNupOBjfDlGjnQKl7FSqVxd2w6Onm91RwwDw/KwpJWzHKensoegEHJht0
         2cc8ItGpxH7+O1L6kkFjthIKnDQey2XlgYtNiE09wn8qrzxDT9S0RuwHosBz8wSr9Vl6
         j+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=36ZCLpuofRUFVHfS0pKHyIeCvDjSMratUuKqOUXTzN8=;
        b=Yw91gGaaeSRD3S+ZKy6rHD/pQX7QqEfR6SSldXDnqS3MrxWzvCqTq2w41w49JmL3pY
         cWwCmtvquIr9ASl4fREZIH6nGi1Xi7JGpkdW7TbCSv2RlxmzJJ9SglJkdcGn1SkpbVH0
         sRxvM7EJUZ1gcWj67mcsqrFF7Qq6+ttcXzEbYjQ2NOgMLcJWfXmY7578+nxRmEHOEDAY
         uLVFGwbezIwE8/dmWaOvX5IZwQGqQKTH+3jAnIU/dwIbriBfVbEH+bGytfwJHjWCZVNo
         Rctlf/0Q2YfwyvPCT05PQZzmBZj3FpOMYLEJfWUMbIVkeeyPk9dG+7grSZf8JMErDWnW
         tomA==
X-Gm-Message-State: AA+aEWZQVvinD7skO33c50yqheHzGU/eDKuoEB3KUPz4tUDddTvZINhd
        TRLfkOOE32wv27IZbZfIWPJ6/w==
X-Google-Smtp-Source: AFSGD/VHYk3SuNTY7GdHquAeBqqvVguksmNoTYU1GWXckUQKxfiQCpUzOtqEzopVwtc/Pz5O0lnnLw==
X-Received: by 2002:a63:4d0e:: with SMTP id a14mr11888140pgb.408.1544468008250;
        Mon, 10 Dec 2018 10:53:28 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id f67sm23756058pff.29.2018.12.10.10.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 10:53:27 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:53:21 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
Message-ID: <20181210185321.GB37614@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.12.09 17:42, Junio C Hamano wrote:
> * js/protocol-advertise-multi (2018-11-17) 1 commit
>  - protocol: advertise multiple supported versions
> 
>  The transport layer has been updated so that the protocol version
>  used can be negotiated between the parties, by the initiator
>  listing the protocol versions it is willing to talk, and the other
>  side choosing from one of them.
> 
>  How's the doneness of this one?

I'm not sure if you're asking me specifically or the list in general,
but I haven't heard any complaints about this, and there are no
outstanding requests on the review thread.


> * js/smart-http-detect-remote-error (2018-11-17) 3 commits
>   (merged to 'next' on 2018-11-18 at 5c6edfcb85)
>  + remote-curl: die on server-side errors
>  + remote-curl: tighten "version 2" check for smart-http
>  + remote-curl: refactor smart-http discovery
> 
>  Some errors from the other side coming over smart HTTP transport
>  were not noticed, which has been corrected.
> 
>  Will cook in 'next'.

Masaya had a series that addresses this as well:
https://public-inbox.org/git/20181127045301.103807-1-masayasuzuki@google.com/

To combine these, we'd want to drop the diff to remote-curl.c in the
final patch of this series.
