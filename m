Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE296211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 20:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfANUHh (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 15:07:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40632 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANUHf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 15:07:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so337807wrt.7
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=yp/h7gDgzcCiVi7skgtuMQXF5BevLeHb9dRVyxziGnI=;
        b=H4y1P93zR3LFq/qXys89cUEojO44aM3JKbMT/h2eFJed+FAKwtTJi+5xFggesjHDVN
         J7HxLBtVFvLuCU9Mn/6z9u+0Q4fP7LNAQg7fYCGMl7yLppAi1Hc+Js/MwNXy1Fba/2Rx
         Q7Gqw4u2vhB+4kF4k8Fl/q0S+2V4444bTqeN6hVSPJAOSOwJ9tb7m8164v3KSDH51YB6
         mWl9Wfddjey27J4F5tVtm+Eg49Y1jWUcGJ5AOYj/oyYkO94DJNl01BNBqWgPUgKxdwoU
         4pmnj4Ex6C9eEbbMuHwVv0AQKGuZsfVuaJblP5zRVqXnk7xpZ9fgUNbxTQKUH/lc+h72
         hgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=yp/h7gDgzcCiVi7skgtuMQXF5BevLeHb9dRVyxziGnI=;
        b=TK4lDor+pyG8ni6pf8dsWQ+oc320bAjudT+LxZWyzLhmG8RT2EjcFoJFRaXGPPW8aK
         609n+NbZJEpdnZR+LLkZ/gtZbIBdbyfWQ44DNjNnKWTl5NajOta5ZXGNLKPik/G5hdL4
         LT9KF69B7JlMorzxlhwb3ccBdjjl4GLlLv8PX7/BasXLbrgxIbZnCf369J5u8Ra9+/Gb
         7tU2/9t/uRlFE0ybGDGB6Tg0gpJUUOahRScteAcHO3/j5jM6W5sps/fzEqB4wDhOYiMd
         Kwbo96DYKDGYKIQxG5me5uPjDPRo5/DS6ak+tAkDO0spqs2F73QTBFEXxi30YDt2las8
         xBTA==
X-Gm-Message-State: AJcUukeX6uCvHB5/4LFdJmZ5GmcmOc+Q22kuhnElgjMOlsNwhLUNM/QQ
        Lw7Qibvlk/eo+lYX/0vT9OHmxOcn
X-Google-Smtp-Source: ALg8bN4gEkngs9vqfD1qGI/LUGntceHOr66wuPRP7uQl+HfK24rjIFcpuJKD7EA260yblhTHahvGfQ==
X-Received: by 2002:adf:8342:: with SMTP id 60mr137236wrd.212.1547496452728;
        Mon, 14 Jan 2019 12:07:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z7sm68880566wrw.22.2019.01.14.12.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:07:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] pkt-line: introduce struct packet_writer
References: <cover.1547244620.git.jonathantanmy@google.com>
        <9b37e68e2f0d83ea133f6662efb780466c518170.1547244620.git.jonathantanmy@google.com>
Date:   Mon, 14 Jan 2019 12:07:31 -0800
Message-ID: <xmqqbm4juhoc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

The patch itself look quite noisy, but in esssense, at the lowest
level we used to have a single format_packet() that was used to
write out normal payload and an error message prefixed with "ERR ";
now the users of the function are updated to call one of the two
helper functions, packet_writer_write() or packet_writer_error().
Most of the patch noise comes from the helper functions at higher
levels getting updated to pass the packet_writer struct through the
callchain.

Which makes tons of sense.

> It will be convenient for a future patch if writing options
> (specifically, whether the written data is to be multiplexed) could be
> controlled from a single place, so create struct packet_writer to serve
> as that place, and modify upload-pack to use it.

I've singled out "ERR " in my comment above, but this only refers to
"multiplexed".  Are there reasons why we want multiplexing other
than the "are we sending payload, or an error message"?

> Currently, it only stores the output fd, but a subsequent patch will (as
> described above) introduce an option to determine if the written data is
> to be multiplexed.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

