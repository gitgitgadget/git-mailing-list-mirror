Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFB41F453
	for <e@80x24.org>; Mon, 28 Jan 2019 00:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfA1AdZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 19:33:25 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38905 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA1AdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 19:33:25 -0500
Received: by mail-wm1-f51.google.com with SMTP id m22so12094768wml.3
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 16:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MetUxt7R5Cc038xCJFULTM6lMDrZaPKIidYRP2rfWLs=;
        b=ZpUh2B2N1MGsWljLBugx+WaRWyvhtn4pxbRuwGdOOu+f2M3nRgVRCqwgn6/XUQ5F3r
         QdqTnOF9/t16g85ycC3y1AGGbBScbJszwhsZQkE+Cn6fT7LnAYTNEiMt6ZF/ULe+ojn8
         BcD0ppykqDnBOd+2H6shRjH0p7FdC+nn1QEi1O6mUQoOMqHfmofVTWRl4CUjgAV1nmAf
         R0fFaDVSCics1FGkQJZVu/cQhcqfQ/whKlnTO2LYhLNuHdXEVa2Cxl0TIbs3DRS2le6Y
         3ob4Z//BGSB/4Qbq04wfELW/Aay0bO8KxXqnqPSNRN/nCPEwlEAuJETQPIHTDmRGzrOv
         +BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MetUxt7R5Cc038xCJFULTM6lMDrZaPKIidYRP2rfWLs=;
        b=KI8d1lb9J1E0p3JdT/vxC5iYfy+lII7IEoAFL1o/hhaS1KIrihjLhGhsgTfwpFtpsx
         edV3uHxdo0K5pul+evBVKl9RaWeDShG1eKNXdXPb7UDoTr0+8XWq1GIyYBhPqiV8UOxQ
         rBKSjHrq8AgSUZGeybV0JZRgLf8116G7LawHDva1IMX+pLqEtn6pq/UhHQ/Fx551rVI9
         adGSSWfN/jYsEcmwsojimiIXN3Q5br03zPPCrDnb1sQ/kZa/WQM/x588wvwaLfkPRzTQ
         BtZpx/TcdZoix4rMfS4Nl6jayaKb3MxDaUhrBpc63Quz28rDa14UeENiHaVXSXF/Ywpt
         Yk4w==
X-Gm-Message-State: AJcUukeObBhhTpk6E0g2RpSfG9g6JLev1XkZv0qBaIisUd56cgRwrZWj
        aUVdjWVv5267APDVc4YxTAY=
X-Google-Smtp-Source: ALg8bN42aAEkgKhiu0FX6Lokbfkce73Uwjl+nA7kqgQIwGiUGY/uGCVI0R9yIfL3eCi4BqOoC0AMEw==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr15524875wmc.116.1548635603261;
        Sun, 27 Jan 2019 16:33:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o16sm160258241wrn.11.2019.01.27.16.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 16:33:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/14] nd/diff-parseopt part 1
References: <20190127003535.28341-1-pclouds@gmail.com>
Date:   Sun, 27 Jan 2019 16:33:21 -0800
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 27 Jan 2019 07:35:21 +0700")
Message-ID: <xmqq8sz5ei3y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This is the first part of converting diff_opt_parse() to use
> parse_options(). Compared to the full series [1] I sent earlier, 03/76
> is dropped and 02/14 is updated to allow KEEP_UNKNOWN and
> STOP_AT_NON_OPTION combination, but only for one shot mode.

Looked reasonable.  Will re-queue.

Thanks.
