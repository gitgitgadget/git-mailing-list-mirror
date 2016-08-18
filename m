Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB7B2018E
	for <e@80x24.org>; Thu, 18 Aug 2016 19:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbcHRTKW (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 15:10:22 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33110 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbcHRTKS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 15:10:18 -0400
Received: by mail-io0-f169.google.com with SMTP id 38so28061596iol.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 12:09:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jXM7NAc2Ln6EnQeljZNQ6E3vXedtOD2/SkNN7x5WXhc=;
        b=MmOMoDyZ4xOlNdE2eq0U5qTIYmW1S6N65H1Qd5O8QJqpMZSlFn/+H/Hum7y8FL6tuS
         wIrNnBNB/YjrphYGsPQd27cnWSnrhyoMxkGHmdh2E4UTIyGyMt6NX2vzQ5ri+uhpXa5c
         nwyrP/bVVPXHRdSMCjdldnAAtmVksVqYWQXv5S6KIO8sjuhVUscAsHSGO3IDQ3s7YGs+
         vy6AOQuEAZIPnJNUOT3ZNa4Ehr1MwasxtdjtcLVd6aPfdtFNeA9oHmMlVxvqcGP+q4Vw
         mrTT0Q0qKHgerOn/bYKjU6eK8RrSKMRtGHQ0cMFw4VNRx45Kb6q3EDmAjMamrsbTeMoI
         K2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jXM7NAc2Ln6EnQeljZNQ6E3vXedtOD2/SkNN7x5WXhc=;
        b=GDV8/cbM8y2tMyKUkDsWMt9zW1ERwtF8K2RJbCFlHvZ30olmPweC+eMtzN4e6oqC1A
         8HE3mGNO3W/nwqe76j5OxrBKYTkl5xHdzYNgjJ4TebSZS6nZtXUv/VNNcIXNLkSDNklj
         RZf1W4xIzTfQ1yJS4sgM+LNQoe2XXBGOi4+7LJmHAmH9D4GEyuAqpEo7D6SnEgYuMEbZ
         VjEigDyZNn1kGuYPKlGWbCXA+Ediz/0+of5rzJBc3YOaW+Z4Fx48oO5GVKpTrL5UzEpl
         BPvWKVisrwWQgh51xOvhlXNtsTeLbNaLnJhCR8M8pKTWwe9OA7POvA96cu6a/xNWIAFH
         krqA==
X-Gm-Message-State: AEkoouvRsuMEyH8t3YnqM+Lk2HTsQFAU+a9ISwUio1Y2RG2a07/R9EDffkv/LMqT2KMprnoyN93olYogg35hXzBi
X-Received: by 10.107.131.38 with SMTP id f38mr4853044iod.173.1471543415808;
 Thu, 18 Aug 2016 11:03:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 18 Aug 2016 11:03:35 -0700 (PDT)
In-Reply-To: <20160818005131.31600-4-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com> <20160818005131.31600-4-jacob.e.keller@intel.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 18 Aug 2016 11:03:35 -0700
Message-ID: <CAGZ79kawPmnUOGu0ErJj4LJq=oPOj-g1Nbg+R26GxvQtFn_10g@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] diff: prepare for additional submodule formats
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> A future patch will add a new format for displaying the difference of
> a submodule. Make it easier by changing how we store the current
> selected format. Replace the DIFF_OPT flag with an enumeration, as each
> format will be mutually exclusive.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

Looks good,
Thanks
Stefan
