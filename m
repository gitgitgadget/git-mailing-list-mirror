Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4425F207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979943AbdDYCMM (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:12:12 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33654 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939521AbdDYCMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:12:10 -0400
Received: by mail-pg0-f53.google.com with SMTP id 63so21056577pgh.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jcybVCr71Y7tK1RKVYJASQl3u2I0aIJGItk6HttY/ys=;
        b=fvX/Q/XMG+Lx2Rypm9kME7BggLiIqOADEjZlEoTjFpp5VD4WaFhkAdcAxScVl+y/J4
         gF+w6y0To7yeVzWVvJSVI5810ZLvogS8po+YLsm0Uvtq5boWon76rBK9B6/WGFCPWFpK
         mQ3rfKCXCdvrMX15iS9Vtn8UfowKku5ubkRN3ODNh9KEEoY6pR0xmT9Me08L4JULL4vt
         8/C7NAKqo7Hlf+/lFVwwnji4yCxIVkOeQfTQpzmRCEu06JysZwHVHSk5wB+k6Nzawhei
         6GpgvxzU0x/LjVRB+JR4t3xmbW+QWhv8bngUK7LhX49ppY0zrwsidboEsmJX3/BH+lcn
         kS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jcybVCr71Y7tK1RKVYJASQl3u2I0aIJGItk6HttY/ys=;
        b=YiY0TiAgH4tbIDeMX7OjRT7CTzJSs5iuffl4mXmHuQEYTo9Ra8Sq1CSMb+bRzsWDJg
         bY+9yF01Krt6Uwx2ZBGbrEaLkCT5AxtYRXkQXdwwa6LA3NwmAk8XYUh0lmZIgAvcQRgL
         7Rv53i6/SvxRkp1YpEOe7oAGMWNfRnEJQ+OJcB57V8PAFhsZScwBzEzONSE/cKhtbJ/4
         bxWKZr22Pz5nFQ/7ROTx/gxorYWZY0ABMOehLpLO/w6ph9KzhyOQJL3s+vTEOt4vbwUa
         3kmnDXw3zlkZmDehcOQEK3sBwDeCJozOQIJ+E8OdMoWUJ1EWsdRyQ1cZy8m+T4aRlbUE
         28GQ==
X-Gm-Message-State: AN3rC/7b2820ihdNouPZBzyYVOjuWBmJSK1ALPIkfYxnEZC5Ci/DjwcZ
        AL6/g5OXnSE7GA==
X-Received: by 10.98.32.211 with SMTP id m80mr27001248pfj.153.1493086329817;
        Mon, 24 Apr 2017 19:12:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id g66sm32936518pfj.11.2017.04.24.19.12.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 19:12:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Submodule/contents conflict
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
        <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
Date:   Mon, 24 Apr 2017 19:12:08 -0700
In-Reply-To: <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 24 Apr 2017 10:40:36 -0700")
Message-ID: <xmqqfugxxmkn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A similar bug report
> https://public-inbox.org/git/CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com/
>
> "checkout --recurse-submodules" (as mentioned in that report)
> made it into Git by now, but this bug goes unfixed, still.

I do not mind reverting that merge out of 'master'.  Please holler
if you feel these "go recursive" topics are premature.

Thanks.
