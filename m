From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Sun, 7 Jul 2013 10:27:01 -0700
Message-ID: <CAJo=hJsUr1osy5rDZja1WBAgzczY5Yp0CJuLoAQs7J59PsX7Zw@mail.gmail.com>
References: <1372116193-32762-10-git-send-email-tanoku@gmail.com>
 <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
 <7vtxkl28m7.fsf@alter.siamese.dyndns.org> <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
 <CAJo=hJtJoizQUubriTPvs2bsjvw+N82MCPvw263fUB8vv8_VVA@mail.gmail.com>
 <CAFFjANSr2QRLE8DSPP2zZ_baEZUqR8dzkPzMwqyEqgFX=8cnog@mail.gmail.com>
 <20130627024521.GA6936@sigill.intra.peff.net> <CAJo=hJvOq=CATrDeYAwi+jgkPpqjywWhuKeC1TVYeCXr6NVM6w@mail.gmail.com>
 <CAFFbUKKm89n0HG6xUhYMLs_yjRJ8n0jFtOEEN=vXxJfWKLx5FA@mail.gmail.com> <20130707094646.GA18120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Colby Ranger <cranger@google.com>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvskA-0006PB-9g
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab3GGR1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:27:22 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36586 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab3GGR1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:27:21 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so8295103iec.21
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UOQdpl1pYG9a5BdZ/beMHa6rj+sxsiPNvmr96mi6Vwo=;
        b=XkoPBRAws9ot0Y10Q5NgHjsY1j3rpCTX/MEECxcjM1Q5oNXFJuGktARUos1K3Csw5J
         pTwNsVR3ZQRQPdFD2oH+GJ5SJ9UMIlzNHRBQa3PSrFrNYTLUvRSI/FhH6YQinqaWmMJj
         fGLmMGUTQaauDU5YkllHlOsmNLnw66dBtjkd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=UOQdpl1pYG9a5BdZ/beMHa6rj+sxsiPNvmr96mi6Vwo=;
        b=OmVzXmXCNSiYpARI2thcVflyNgvHgUxHE/NvMZgZiv9t5VMGA1FcWrI9eWylaw+VOW
         PJZiicI+8IQ/hrjM/AT7KOPbMytsu2ltn/xQ77EAWoRGIxxF2LWQEQEKUa1blRKDg4/0
         oCkh4ZBSL9KEH+3zGLUS2lIZYL1Xctolsh1uOJ2gmzqI+ouR7JWHKj2UD8WzdG950HxM
         xsCe+Jm2ogj2c4wKtQ/Y6vLkVn59vJQuycE3eMUpGYOJRLKC7yI9sXdibsFEMhbbNS/F
         7uiF8ygE7EBEoBd7BlwSuGqiJj6GavpLKbE5HaxhgT8dOzhkv6tucUwtHga6+G6R0e2l
         1Fqw==
X-Received: by 10.50.225.66 with SMTP id ri2mr7346295igc.55.1373218041149;
 Sun, 07 Jul 2013 10:27:21 -0700 (PDT)
Received: by 10.64.143.200 with HTTP; Sun, 7 Jul 2013 10:27:01 -0700 (PDT)
In-Reply-To: <20130707094646.GA18120@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQkb3y8NC57Ah4n+LUMudcxrNumLdcRPnED+B9p9nKDI8XRhRL6k0nnHWzqMmn9v9bnn4CCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229779>

On Sun, Jul 7, 2013 at 2:46 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 01, 2013 at 11:47:32AM -0700, Colby Ranger wrote:
>
>> > But I think we are comparing
>> > apples to steaks here, Vincent is (rightfully) concerned about process
>> > startup performance, whereas our timings were assuming the process was
>> > already running.
>> >
>>
>> I did some timing on loading the reverse index for the kernel and it
>> is pretty slow (~1200ms). I just submitted a fix to do a bucket sort
>> and reduced that to ~450ms, which is still slow but much better:
>
> On my machine, loading the kernel revidx in C git is about ~830ms. I
> switched the qsort() call to a radix/bucket sort, and have it down to
> ~200ms. So definitely much better,

This is a very nice reduction. pack-objects would benefit from it even
without bitmaps. Since it doesn't require a data format change this is
a pretty harmless patch to include in Git. We may later conclude
caching the revidx is worthwhile, but until then a bucket sort doesn't
hurt. :-)

> though that still leaves a bit to be
> desired for quick commands. E.g., "git rev-list --count A..B" should
> become fairly instantaneous with bitmaps, but in many cases the revindex
> loading will take longer than it would have to simply do the actual
> traversal.

Yea, we don't know of a way around this. In a few cases the bitmap
code in JGit is slower than the naive traversal, but these are only on
small segments of history. I wonder if you could guess which algorithm
to use by looking at the offsets of A and B using the idx file. If
they are near each other in the pack, run the naive algorithm without
bitmaps and revidx. If they are farther apart assume the bitmap would
help more than traversal and use bitmap+revidx.

Working out what the correct "distance" should be before switching
algorithms is hard. A and B could be megabytes apart in the pack but A
could be B's grandparent and traversed in milliseconds. I wonder how
often that is in practice, certainly if A and B are within a few
hundred kilobytes of each other the naive traversal should be almost
instant.
