Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31427201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755568AbdERXdS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:33:18 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36749 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755400AbdERXdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:33:16 -0400
Received: by mail-pg0-f44.google.com with SMTP id x64so29548519pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMI3m7MNf4KiDRcTUm13Vmaxz3kfIAD5y6qLP8i3ul8=;
        b=Nkxfy4KjlKHNSW61XGsmNKvM1LG4TRiJesGx58cjsrwwXnbSP3wMa8xha9dy5Upsok
         y5UIJ6P7PlOkX4ltoAJp0ZkAzC38xIllsYaxMTE0gg9tbAvbu1O2vGKElyTixsz2hRXm
         MNepf5LAMm0+QPOugCWMrp/QeJi1M+Bb6IhEuBPz7OkHog9rlZhlOxf3FvLTuzK31Xm3
         COmibaus37dx5SyyuqZ/3vZ1cCVWGbDOll+eUOgaUCORI9wLCE2MgEQILQNLhrpGgLhQ
         RQDXFoy6YDi75rkcFcgPHF1iX/rAsboQEcNUP4UkN5ykMbaEuKYgTQeLJoOLpkA5SL3k
         d5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMI3m7MNf4KiDRcTUm13Vmaxz3kfIAD5y6qLP8i3ul8=;
        b=gtR0gVxH7jGXCXbh/TF/ujZKyzQQyXpazleCwl6qMChuuw90KEFBDb1M9b7AMjQHCB
         AkE7QOw1496tMVmzOgNTNLFYkHBD4ZfdkbyqhxZefxiojFV87FBMrMs78FvESOLFLDtC
         IyZ9YwESM7GytmiFgTrsLrq2jZtdAfGzW16m+AZV1G0uycVi90Uy08nERtTzk4Po/ep8
         tostfDEsDRsGecgHszdWAPDOHYSzIpXvSLdbP7k2bAuXibVEzNPoZtRdauOaRWjKPcAx
         96wlnQQd+ERllCE5j9TmHbkmqEVAihmFAwK4phRaNKLheTdOL9UJcQgPH/hWGNrliyGt
         Zwzg==
X-Gm-Message-State: AODbwcBNBn6E8YOnpirwbKOxCZBW5LEcgFBjRsMO6pAqL/sXQ0Xyav/J
        px45ZQxpieBRVkpEkb+fdA==
X-Received: by 10.99.145.195 with SMTP id l186mr6998138pge.123.1495150395198;
        Thu, 18 May 2017 16:33:15 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:841f:25dc:b0bf:50fc])
        by smtp.gmail.com with ESMTPSA id t19sm11765738pfg.31.2017.05.18.16.33.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:33:14 -0700 (PDT)
Date:   Thu, 18 May 2017 16:33:07 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net
Subject: Re: [PATCHv3 04/20] diff.c: teach emit_line_0 to accept sign
 parameter
Message-ID: <20170518163307.657caedc@twelve2.svl.corp.google.com>
In-Reply-To: <20170518193746.486-5-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
        <20170518193746.486-1-sbeller@google.com>
        <20170518193746.486-5-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 May 2017 12:37:30 -0700
Stefan Beller <sbeller@google.com> wrote:

> Teach emit_line_0 take a "sign" parameter specifically intended
> to hold the sign of the line instead of a separate "first" parameter
> representing the first character of the line to be printed.  Callers
> that store the sign and line separately can use the "sign" parameter
> like they used the "first" parameter previously, and callers that
> store the sign and line together (or do not have a sign) no longer
> need to manipulate their arguments to fit the requirements of
> emit_line_0.

I know I suggested the paragraph above, but after rereading your patch
set, I think I finally understand what you're trying to accomplish.
I think it's better to combine patches 4/20, 5/20, and 6/20, with the
following commit message:

  diff: introduce more flexible emit function

  Currently, diff output is written either through the emit_line_0
  function or through the FILE * in struct diff_options directly. To
  make it easier to teach diff to buffer its output (which will be done
  in a subsequent commit), introduce a more flexible emit() function. In
  this commit, direct usages of emit_line_0() are replaced with emit();
  subsequent commits will also replace usages of the FILE * with emit().

And the function itself can be documented this way (with the appropriate
formatting):

  /*
  Emits the following line or part of line. It is expected that "set"
  and "reset", if not NULL, should contain terminal color codes (or
  markup denoting color) and that "sign", if not 0, should contain '+',
  '-', or ' '. But those are not requirements.
  */

If you do all that, then the buffering patch (19/20) can be improved by
adding this comment somewhere in the file:

  Buffer the diff output into ??? instead of immediately writing it to
  "file". 

  NEEDSWORK: The contents of the ??? array - in particular, how the diff
  output is divided into array elements - is not precisely defined; some
  functions may emit a line all at once (resulting in one element)
  whereas some others may emit a line piecemeal (resulting in more than
  one element). Ideally, the code in this file should be structured so
  that we do not have such imprecision, but in the meantime, callers
  that request buffering should ensure that the diff output is divided
  the way they expect (and have tests to ensure that it remains so).

> With this patch other callers hard code the sign (which are '+', '-',
> ' ' and '\\') such that we do not run into unexpectedly emitting an
> erroneous '\0'.

I still don't understand this paragraph - can you rewrite this in the
imperative tense?
 
> The audit of the caller revealed that the sign cannot be '\n' or '\r',
> so remove that condition for trailing newline or carriage return in
> the sign; the else part of the condition handles the len==0 perfectly,
> so we can drop the if/else construct.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
[snip]
