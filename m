Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9411F954
	for <e@80x24.org>; Fri, 17 Aug 2018 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeHRBJl (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 21:09:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51170 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeHRBJl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 21:09:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so8841342wmc.0
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1zQLGYrCgWdV97bDG5chmcu6QY5KJUNizWvC4Du2pYY=;
        b=QMBv3ZMdrVVpmra7LDk1p5NhIxeCi1pvLsoQc0IYOQF+DJl7LCwUboSw2s62GuLy9X
         JN843ScE+DPV8xIQzcZdnHQtNjQD4jkKLYHowGaVgiWxHlNUv5EvwGdm/uIJB1Srz0aY
         cLgJvaUjVB2Vn5mUatC52d9sJGbCPC5SJlPbGCOJWyLNJfFb6HNDjqC0OVriqVCxyfJ4
         e8NfFJ/kP+N54pD3TAxHTHqZQkXiTNjh55w0skXcP4mRiFE6gjINQeOM/3//7KvpzpLS
         9SsntNE3oLV/RZd+8cgUyN9FZ9jBpuNey5Gtt/Aej3nzXAWHiru1nsP/V4XZXLv4MTpb
         lAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1zQLGYrCgWdV97bDG5chmcu6QY5KJUNizWvC4Du2pYY=;
        b=gbr1NimaLgzU+WekfND06rwcmPyVLUVKPEC/0yluG1dAJbbHS0Mj4O+cI2H5pqWeSo
         f8peli5ekC7b9wTMnjwbBf3/EPYfyU1jKgJ3aAgS3ykrYUYkVy8Qus0jo2u2ZlTv+L7O
         PXG5HZYmd9lmoGvOJ8Lf+h5PdWnp54a+AwIJmwJciqEFn/xlQ5W58fyW7J8hIRuxM2Wb
         mRZIEK+UPDaNlUi3HwB8O+teJDC9IEFacc9tt0TICsWuQgL8H4eCyatxDlVkd6JSUAzu
         60XtQY2Vbk3l16InutXy3mip+a7h/sVe6zNVwhR+WCJgMCUEGXpYibS5qYZY4L/WSYlF
         1FSg==
X-Gm-Message-State: AOUpUlHkwjWRLQFkrjOFJQgNfjNwm4xHARdBeFizMVYZUt0UVcHr0Km6
        b+rDs7qnuO685yub9v4pQfM=
X-Google-Smtp-Source: AA+uWPxqXedLdaNJL1lQbdfD/bxkf4SXSaTMZtre6rgyyxETDnQ/w8WR4wLSqtVtc2Nj5C6PcNiY7w==
X-Received: by 2002:a1c:dac6:: with SMTP id r189-v6mr19893497wmg.150.1534543473547;
        Fri, 17 Aug 2018 15:04:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o14-v6sm11487971wmd.35.2018.08.17.15.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 15:04:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     johannes.schindelin@gmx.de, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Better colors in range-diff
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet>
        <20180817204354.108625-1-sbeller@google.com>
Date:   Fri, 17 Aug 2018 15:04:32 -0700
In-Reply-To: <20180817204354.108625-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 17 Aug 2018 13:43:51 -0700")
Message-ID: <xmqqzhxkabv3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This improves colors of the range-diff, see last patch for details.

How does this relate to your other "color with range-diff" topic
that is still in flight?  This supersedes it?  Builds on it?
Something else?

Thanks.

