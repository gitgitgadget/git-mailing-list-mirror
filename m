Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5A51F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 21:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNVmi (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 16:42:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43630 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNVmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 16:42:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id a18so3240934plm.10
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 13:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q4mVvWDZ1zrijX+A+GKGaYDcQmaWZOvPL84wpx5PCx0=;
        b=ZmvQdLSOzuCrTyx4p3iDdyo+VcMuFAqGWRJ/Te7CrnwQGSU8BfaD7VidVQDNtgEGa2
         barlQkldnCFBuE5JNYuuj7L5oATxAHpVwSXTwi1Xq2x4gQMtNnswqvN8FQhKLoXRrJvz
         sDoZ/sHS91KHzXl1WKPk/u9WjdKCQOeDuaCZ+sww0OTsO6pvK013x72cH3FARvq3SFcg
         VtDXZcpCojtVE+VPcefhvUMn5AxT+bw4rPr5D2NzkSCcPgaLADcUAJVFD/XcUtP+2huQ
         G+pZQY0+cAnbRviDFq73TUvjPP0sCt85gbodRsLrBpnPFEgtHTVqKN0WXIlCJv4rvy8b
         xZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q4mVvWDZ1zrijX+A+GKGaYDcQmaWZOvPL84wpx5PCx0=;
        b=OBiw+oTsP7rlrBn3h/8gmnakxO7IPAcAByN061o0DylGF08U33NspvVPAH77SscJ3y
         9EFLN2DWiqZDpTkyvGq4FNROV1hAewinHaEAF3iAOPlPmIVVuIByL6uk7KTvMUGVa5Wo
         kzpXRxqr41FSp1Sio8/ZKlUQyrFpiyPvQKJmMCjQVJ1pQXC9yDnZ2WpxysRwlVhqPbgt
         cFHVhLQ5iP7YQQ0E8XxkjcmAKni1iV5Q/vm0EsT0vkg1prAFWGolHHN0zUbEoKUfi6I8
         tce1lXUs89JwIAkaf0f+zb5zWhHxHAhVjiRC1F7PtXsDKHWMFk9fd33x0qtPLQGyb6RX
         dmdw==
X-Gm-Message-State: APjAAAXyp7VLclWN+KQU5qkbaU/qP/FAxfWf3Jpk7hOFz2CNlTet1Q0M
        sKunpyFZuo1tmpVCmy+5TfcUYw==
X-Google-Smtp-Source: APXvYqzm+RxJf2Bfc9omC8B/B19mbPM9K20hLOmqcAUpYIVrz+SqKJFNGYdGuq4huzrpYY/kTaP2cQ==
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr11536686plp.111.1573767756135;
        Thu, 14 Nov 2019 13:42:36 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id v3sm9658145pfi.26.2019.11.14.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 13:42:34 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:42:30 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/9] bugreport: add version and system information
Message-ID: <20191114214230.GA36377@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-4-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1910281432180.46@tvgsbejvaqbjf.bet>
 <20191108214757.GB22855@google.com>
 <nycvar.QRO.7.76.6.1911111439510.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911111439510.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 02:48:13PM +0100, Johannes Schindelin wrote:
> > > > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > > > index 2ef16440a0..7232d31be7 100644
> > > > --- a/builtin/bugreport.c
> > > > +++ b/builtin/bugreport.c
> > > > @@ -1,4 +1,5 @@
> > > >  #include "builtin.h"
> > > > +#include "bugreport.h"
> > > >  #include "stdio.h"
> > > >  #include "strbuf.h"
> > > >  #include "time.h"
> > > > @@ -27,6 +28,13 @@ int get_bug_template(struct strbuf *template)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +void add_header(FILE *report, const char *title)
> > > > +{
> > > > +	struct strbuf buffer = STRBUF_INIT;
> > > > +	strbuf_addf(&buffer, "\n\n[%s]\n", title);
> > > > +	strbuf_write(&buffer, report);
> > >
> > > This leaks `buffer`. Why not write into `report` via `fprintf()`
> > > directly?
> >
> > Rather, to match the style of the rest of the builtin, modified
> > get_header to add the header to a passed-in strbuf instead of
> > modifying the file directly.
> 
> Hmm. It makes the code less elegant in my opinion. I would rather either
> render the entire bug report into a single `strbuf` and then write it
> via `write_in_full()`, or use `fprintf()` directly.

Yeah, that sounds good. I will do that. :)
