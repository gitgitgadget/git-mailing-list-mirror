Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004062018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S3001705AbcHEVrm (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:47:42 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:34866 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968902AbcHEVrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:47:41 -0400
Received: by mail-it0-f51.google.com with SMTP id u186so32512140ita.0
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:47:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cWDot+GlKIb+5XI8dnWmG3GdvF5CSD6eWEHP+jykIzk=;
        b=VkmZgwPUTyo4+fA+sGN+u6SF3LaNpLyu0SiVuRYRvJcNlgqiWbsuzYq98A4Q61s9TU
         b+V0b2yQVuFnlxry8g3YT+uyeB6St281t9EdLIQdGwyk9HP58XQUv/Y4aSo8eeqddwlY
         WlQEz5hV+iK1iNHurmCkTopMkzKi723BRF4ar/mwbbfCIdEkRnhnxzPn35d5s8Ch5khV
         rrA7uxFDjtkr4KyzDscNClASwTVRwqtoiJQVKOahqKEerldta6uwmTUMIzPMjlWSuuIY
         qEKRSjNspl7Jh3tV0f2/xgwIQkw5dmTYFPuxCiTkn6ORL7q7v1cHpSn7Hc18OVWrGhSV
         lXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cWDot+GlKIb+5XI8dnWmG3GdvF5CSD6eWEHP+jykIzk=;
        b=A6t9XWDWSMhf8o8wenrNLuVUfJL8W9zCqCVV8lcCKFwqWaMD+8jf/NzirI1OB7ZvaY
         9Cm+NEYw3ei+kGnSWHEfJR8QyCFaYw/DaPGQgioFXvqor4YDJZQSk7bgi431js0hO/5r
         RmPG9b3X0i4KW5k+xvw2ODdSmjReLmbUvEhjjz0OcK6A4H1KMXOK47cx3mtA2o4ki4sh
         6VMhX2RQf9gIppcoTh5Tuh7vws36FAJp4PSAn/oUVgkcqsCCzJOkO4yZvdp9XRegxJqw
         RLXcWrRzdy67cwXgy4GUrGRf4srKVLFehG8DjrEGG3phwUNjz9qraaBmRm5dO0t6fqg+
         dnSg==
X-Gm-Message-State: AEkoouvk4jpENzHrs0r4I+/Ibjl20M78ex8sTGdgMx4td8ns6+AleubUeunW9VQ7azf4rTs4BVgXAfFX1c4qc9T/
X-Received: by 10.36.29.15 with SMTP id 15mr6585371itj.97.1470433659128; Fri,
 05 Aug 2016 14:47:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 14:47:38 -0700 (PDT)
In-Reply-To: <CAGZ79kb2aO80csCfV=QbH8D1spdNLdkTCSPriZ8W9nSy6T5QAg@mail.gmail.com>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-6-git-send-email-git@jeffhostetler.com> <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
 <CAPc5daUr7OgFeefbwWLWFt3KW_9X-ijRmHa2oj0--zY4fqt82A@mail.gmail.com>
 <20160805211434.54mtaw2cty4gaxsr@sigill.intra.peff.net> <CAGZ79kb2aO80csCfV=QbH8D1spdNLdkTCSPriZ8W9nSy6T5QAg@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 14:47:38 -0700
Message-ID: <CAGZ79kZOv4rTuqg7kLWydPY4dCeivaBXZ8HeU8hxu79rPeu-5w@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] status: print per-file porcelain v2 status data
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jeff Hostetler <git@jeffhostetler.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 2:43 PM, Stefan Beller <sbeller@google.com> wrote:

>     cov-build --dir cov-int make

For this you need to download their analytic tool and put it in
your $PATH. Let me see if I need to update the tool so it
enables finding more potential issues.

So that was an initial hurdle.
