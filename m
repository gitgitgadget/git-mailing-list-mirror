Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2BA1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbdCJSxh (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:53:37 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35100 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755427AbdCJSxf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:53:35 -0500
Received: by mail-pg0-f50.google.com with SMTP id b129so41911936pgc.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xBNemHo0mkGB7/9zaw27tHHv+2W7DaXqBQXCD2iUxo8=;
        b=rQ9pPJWaXVVblmPPM4hsDXuqsz/sD075y8y+pg3HQPMCVVA6xzaIKuippcLhXhJkRJ
         8R7ljFuOtgA5oUNRrBisvhqc2F3dhJ/dwrdUht0AnAh0fUGsGbaSSCTagAXRjmdPNTM2
         N+qrR6ZCLwoCFUTgUmbfm96NjYC85QEWPgioC3YzuKFeWf9iyVULavBBm5aKTsAP2Dtc
         tyV5E/AuFgj/ia8plX0/BhhuI/l5MLgOOoe6GLJtOoup0Gw1OTdObqWa7M+bO1Cs/LTK
         Y7iHHTyTefO18oU+vh1HodjBuUCEPlZKd8MPNOdrjbf8U4KLkNdPhefXTadad6++CHZH
         o6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xBNemHo0mkGB7/9zaw27tHHv+2W7DaXqBQXCD2iUxo8=;
        b=NuJFuUq0caP0QnTPjDDwt9RUMxuZGjXsxFFZIs8OUPKnNHBbXt8vC0wyE+QWSQveJl
         5N01XVsAfsSkBp6iScZwo3GY6jtlGGcU5pYNhOQTlJCyTfwTOlSHLgYmubT8x60yj4/y
         uYC2XRIkx51AqplQ9edqgLaZ8R5NONBh+WrmibkNsn+PoEawY8ETVCRvLVfUy8ljGv6O
         i0wIlcSQsEAuX/ntPiaNBfrfudIE+iw8ymiSbk1BdVuS6WPgEOpwxPKxVbbqlF+GgbBm
         YB4kivDxmIuh31CVFrQwpUhW5gv/KCC7Q65eapcLveTDuMWDMgtWPmTD6mXIfS+ciKhp
         rztA==
X-Gm-Message-State: AMke39mKGmfbT/UwFhuM+qK3J/LFg2+6FZ3JiGxDknNwOCsxElIaY2DlldH7E94cFQBdDRNJ
X-Received: by 10.99.101.199 with SMTP id z190mr21417252pgb.219.1489172014473;
        Fri, 10 Mar 2017 10:53:34 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:c69:ce9:a41e:fd0])
        by smtp.gmail.com with ESMTPSA id r71sm19982733pfa.104.2017.03.10.10.53.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 10:53:33 -0800 (PST)
Date:   Fri, 10 Mar 2017 10:53:32 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 2/2] pathspec: allow escaped query values
Message-ID: <20170310185332.GC53198@google.com>
References: <20170309210756.105566-1-bmwill@google.com>
 <20170309210756.105566-3-bmwill@google.com>
 <a81ad8b5-3b49-8232-1656-66b2e9d78569@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a81ad8b5-3b49-8232-1656-66b2e9d78569@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Jonathan Tan wrote:
> On 03/09/2017 01:07 PM, Brandon Williams wrote:
> >diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
> >index b5e5a0607..585d17bad 100755
> >--- a/t/t6135-pathspec-with-attrs.sh
> >+++ b/t/t6135-pathspec-with-attrs.sh
> >@@ -178,4 +178,13 @@ test_expect_success 'abort on asking for wrong magic' '
> > 	test_must_fail git ls-files . ":(attr:!label=foo)"
> > '
> >
> >+test_expect_success 'check attribute list' '
> >+	cat <<-EOF >>.gitattributes &&
> >+	* whitespace=indent,trail,space
> >+	EOF
> >+	git ls-files ":(attr:whitespace=indent\,trail\,space)" >actual &&
> >+	git ls-files >expect &&
> >+	test_cmp expect actual
> >+'
> >+
> > test_done
> 
> Is there a way to verify that `\,` is not escaped by the shell into `,`?

You can run with GIT_TRACE=1 to see the actual string passed to git.
'\,' is indeed passed to git with no problems. 

> 
> Maybe also add tests that show \ as the last character and \
> escaping another \.

Done

-- 
Brandon Williams
