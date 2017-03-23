Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CB120958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbdCWRki (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:40:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:56150 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933152AbdCWRkh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:40:37 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lfolq-1cPF1s1prW-00pLoF; Thu, 23
 Mar 2017 18:40:34 +0100
Date:   Thu, 23 Mar 2017 18:40:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: fix missing newline
In-Reply-To: <20170323170233.50499-1-bmwill@google.com>
Message-ID: <alpine.DEB.2.20.1703231839570.3767@virtualbox>
References: <20170323170233.50499-1-bmwill@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zmN4XmTaDehJIeAo9yur+yMtHiaopt6S/ZICM74YW1l/o1IaS3h
 M3JGfm7HnzCRe2+wxWNF9QVmh1jj1seXoYNL6CCt+Gf6DF/GG5AvEbBPJE/qS1EfLze5GSx
 5wfueucQlhEa46ghLWcDvrrdiyAGWTcFHK3lceCu1PQ4GYZO34//0RsNO8LbLwNENxw/Y11
 JAbJUZwgpw6ieXAqWJ7cA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zAJC0pmjh7Y=:rJX9NuTSiIh3eZnDvhHaoo
 3LqrZegMryasAicoHWoyW9QnOOC0tqmxXJq3YLDz1Nj7pGAB9Ej6EX80ZGbb34ExMh3PF9nCT
 lulNBOqTogQt6s60rkzZ6FlgpGbIkSPWcxP8UR3T6PpQy+0kEZ6lmC+BEXmwAaD12FJypYflO
 xvfc32vAteQXIJ+nLNWY7eII6nFFQhNS2QT4TGlA6Y9dAtP/GWansXqj+WgwLt4d66VQj+zES
 UmnTJ84VcLQBjzJ/VYc/rN/hPDOd4fS6csYp/Lib3hPNEStO2UWlIuOj3t1cnZtQFNXd1Ds2I
 vBQQzDn89CHF3ZUBdj7HYj/wOXKGYiaOvxkimmnJ0efiafRW44bZAFeUQB20uK3F5ijENeghM
 4uBRl4iHabazUXnxnzVeCtLMukg9fEzPfc/4GZk8ZL6JEeHRg+O8jfSMFPHHn29OwO3xXH2MA
 eGiWVDlpN93L7TBjymqj+nj31t6KaP5V933IctMlpBX1y0Hrnzk/33f3VnG8W5GN1JfxOyH1U
 x63jYZe76Ja00snMtQVxsxwDK+JtzcLk/LNa+5rsJESx1VgM3AfOAyKUtVILzZuXRuxHHmyhO
 3ql9r4nRvNo8PKqQa51XrYungERH+q3r9fhANO9waOFVHIzgrCGBcvly4N7AlFHNR9UsEY1h2
 3vQowGznWVWvFxlPvoJ/BZwRvAyBp9tj7Zx1SvturO4GK1bRG18iIMSz9IhHGnNHKDbba3thX
 5b9K98MlK/NzQjif3iKRFcVmb3teY/zXjP2NvtCaYeGsyz/m5gVGILfwwATXbeWarBs0Qc+FT
 7LndT5TTqPJIP61mwI+UoQ934ATBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Thu, 23 Mar 2017, Brandon Williams wrote:

> When using rebase --interactive where one of the lines is marked as
> 'edit' this is the resulting output:
> 
>     Stopped at ec3b9c4...  stuffYou can amend the commit now, with

Ugh, I should have caught this. The warning() call implicitly adds a
newline, the fprintf() doesn't.

Patch is obviously good.

Thanks,
Dscho
