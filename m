Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9CA1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 22:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfACWGU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 3 Jan 2019 17:06:20 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39980 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfACWGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 17:06:20 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x03M6EuM078648
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 17:06:14 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        <randall.s.becker@rogers.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Randall S. Becker'" <randall.becker@nexbridge.ca>
References: <20190103210351.13920-1-randall.s.becker@rogers.com> <20190103210351.13920-4-randall.s.becker@rogers.com> <CAPig+cSdheCx-Ucnmg5eSXyNhyGPFF3L6N_Nc5uXQdc8Ytx2DA@mail.gmail.com>
In-Reply-To: <CAPig+cSdheCx-Ucnmg5eSXyNhyGPFF3L6N_Nc5uXQdc8Ytx2DA@mail.gmail.com>
Subject: RE: [Patch v5 3/4] git-compat-util.h: add FLOSS headers for HPE NonStop
Date:   Thu, 3 Jan 2019 17:06:08 -0500
Message-ID: <007a01d4a3b0$8ae10000$a0a30000$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMvgCHt68OIXko24hzpvmTXcJA7igIGD/VzAm7JVGGixLm7YA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 3, 2019 16:41, Eric Sunshine wrote:
> On Thu, Jan 3, 2019 at 4:04 PM <randall.s.becker@rogers.com> wrote:
> > The HPE NonStop (a.k.a. __TANDEM) platform cannot build git without
> > using the FLOSS package supplied by HPE. The convenient location for
> > including the relevant headers is in this file.
> >
> > The NSIG define is also not defined on __TANDEM, so we define it here
> > as 100 if it is not defined only for __TANDEM builds.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> > diff --git a/git-compat-util.h b/git-compat-util.h @@ -397,6 +397,17
> > @@ static inline char *git_find_last_dir_sep(const char *path)
> > +#ifdef __TANDEM
> > +#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
> > +#include <floss.h(floss_getpwuid)>
> > +#ifndef NSIG
> > +/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the
> highest
> > +   known, by detective work using kill -l as a list is all signals
> > +   instead of signal.h where it should be. */
> 
> Style nit: With two minor exceptions, all other multi-line comments in this file
> are formatted as:
> 
> /*
>  * Multi-line
>  * comment.
>  */

Doh! I just missed that one. I'll fix this on the next round, if that's ok.

