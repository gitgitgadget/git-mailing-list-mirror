Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49101FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbdCaN0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:26:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35601 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933266AbdCaNY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:24:59 -0400
Received: by mail-lf0-f66.google.com with SMTP id v2so7363132lfi.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/Ss7o216CwQGDt3yXEpl/YJc4eVSfuE2zGnjhjx/54Q=;
        b=V9yaVBkC2hwjcRejAVasUaSZVRxtd1OGzJ8ZkJY9Rf03/sFT8GobHsC8GOXnbGxbpO
         W4fM6k4dDJiWceXmChPtxm4NMs+KI69bShMGNAw/zWb46s3CVdeQkoQUUaMMbr5VBuRs
         rRcsQ93ninibMigMVEgpPHdA4gwbO53XXT3AboGQxH9SJvxSoglKn5xPMLkcaBT1YY/s
         3NWfJ4bLJDUN5TWuayrIvvNCwxSmJfgORRkmcZMO8HhI6KdnwO5aPgiNj2EuVaKp1c83
         B5QkigRseGSR6VS6O+BQIl3cN9sZdhuWMTRenIgU+1/X5ohiT2lzY2EbLUF6g2gOxIb7
         Daiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/Ss7o216CwQGDt3yXEpl/YJc4eVSfuE2zGnjhjx/54Q=;
        b=aZOk2FrTnUUBl8lk5Oc+mAVnByMnv5ojn97epg50Vp8XchgOidPBziklypKCIn/u78
         bPmyLVzlp7leVfSJdEVwEraLGXecR2yh9StB3DQF0nkfQ2NwXwLmdstzlfn6o7yIa+v5
         6vrRj9XxOL3G+Sa/sa7+Zx1Vfplp0ksgmMVQ2IdL2UD9soOfIZobCy0CxvYBfcjRGCON
         URI7x588owgr/z39oY/v6oaJOcMSeJ5rL3teGFpHAjeXA98ZJfEkfXRuIvRPXPJGSteX
         l5+USxgyc46eYTHL5WMDCeWrU7G8no+aynl4/JrjcHKRWmFmZYJhFPbxoBWZr8J7X+xM
         sWHg==
X-Gm-Message-State: AFeK/H1p5Eqs3fK6r1LZvl9kjzOvG5cP+6oDymqF1sCK0ezwyST5hj6yFT4INnzkqVZghA==
X-Received: by 10.46.20.69 with SMTP id 5mr1177363lju.81.1490966696800;
        Fri, 31 Mar 2017 06:24:56 -0700 (PDT)
Received: from [192.168.1.26] (ewi85.neoplus.adsl.tpnet.pl. [83.20.232.85])
        by smtp.googlemail.com with ESMTPSA id f72sm944391lfk.2.2017.03.31.06.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Mar 2017 06:24:55 -0700 (PDT)
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
To:     Jeff King <peff@peff.net>
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
 <20170330200021.c2l5jak3xb5aoxyc@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e1a6d44c-b01b-993c-6a22-e6ac0abca03c@gmail.com>
Date:   Fri, 31 Mar 2017 15:24:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170330200021.c2l5jak3xb5aoxyc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 30.03.2017 o 22:00, Jeff King pisze:
> On Thu, Mar 30, 2017 at 09:35:27PM +0200, Jakub Narębski wrote:
> 
>> And everything would be all right... if not the fact that Git appends
>> spurious ^M to added lines in the `git diff` output.  Files use CRLF
>> end-of-line convention (the native MS Windows one).
>>
>>   $ git diff test.tex
>>   diff --git a/test.tex b/test.tex
>>   index 029646e..250ab16 100644
>>   --- a/test.tex
>>   +++ b/test.tex
>>   @@ -1,4 +1,4 @@
>>   -\documentclass{article}
>>   +\documentclass{mwart}^M
>>   
>>    \usepackage[cp1250]{inputenc}
>>    \usepackage{polski}
>>
>> What gives?  Why there is this ^M tacked on the end of added lines,
>> while it is not present in deleted lines, nor in content lines?

Gah, I forgot that Git for Windows installed with default options uses
`core.autocrlf=true`, so file contents is stored in repository and
in the index using LF end-of-line convention -- that is why there is
no ^M in pre-image (in removed lines).
 
> Perhaps it's trailing whitespace highlighting for added lines? You can
> add "cr-at-eol" to core.whitespace to suppress it.

Thanks! That solves the problem (or rather workarounds it).

> 
> I suspect in the normal case that git is doing line-ending conversion,
> but it's suppressed when textconv is in use.

I would not consider this a bug if not for the fact that there is no ^M
without using iconv as textconv.

Compare (without textconv => no ^M, but mojibake):

  $ git diff test.txt
  diff --git a/test.txt b/test.txt
  index 029646e..38cd657 100644
  --- a/test.txt
  +++ b/test.txt
  @@ -1,9 +1,10 @@
  -\documentclass{article}
  +\documentclass{mwart}
  
   \usepackage[cp1250]{inputenc}
   \usepackage{polski}
  
   \begin{document}
  +Za<BF><F3><B3><E6> g<EA><9C>l<B9> ja<9F><F1>!
  
   \end{document}

with the following (with textconv => no gibberish, but ^M):

  $ git diff test.tex
  diff --git a/test.tex b/test.tex
  index 029646e..38cd657 100644
  --- a/test.tex
  +++ b/test.tex
  @@ -1,9 +1,10 @@
  -\documentclass{article}
  +\documentclass{mwart}^M
  
   \usepackage[cp1250]{inputenc}
   \usepackage{polski}
  
   \begin{document}
  +Zażółć gęślą jaźń!^M
  
   \end{document}

-- 
Jakub Narębski

