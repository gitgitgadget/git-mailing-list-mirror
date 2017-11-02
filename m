Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B25120281
	for <e@80x24.org>; Thu,  2 Nov 2017 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934589AbdKBWSN (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 18:18:13 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:55887 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934421AbdKBWSM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 18:18:12 -0400
Received: by mail-wr0-f179.google.com with SMTP id l8so906731wre.12
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=o1uA2AskedndRYOGWnl0yFrSiqcp7F/fews2DpF895E=;
        b=SV0jJ1ihyD02BZBiTMApLkYiBPKH54cW4JXWSKjDD/NmXeHZmaEOA4OIzgYaapycwp
         oAGYeCzk5g3d+l+AEZX101ab1KIBrj4rnIpbilAnCdL8Ry4HU8cQEZ1CgZTRDdIrvcQA
         EIafHpw8pZSJ9KKeuHHfgCx7/LDLxRVcqcZc/6Tr+F6YqEFyQU7EmGoMFnzizwkXBiuM
         wJoojeGrfmQTgtKqjqmeVO438jLHvYSa9L6aDx83NglIIBkLZVNUm5kiTrcQ8T57Gylz
         LdojtCreJ3Hc6A/d34XP3wpfxehevLn6V+50gRxoiM6ufCL58t01zGdFbkazhpqj/TTk
         qe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=o1uA2AskedndRYOGWnl0yFrSiqcp7F/fews2DpF895E=;
        b=jcxNclSMbXXig/IQR5Xqccwj57YnnpurL2ztw37gd1gYzI+nQnC3N3Q57YZFFxO2vu
         EGX2gzc2iaeWycOKJHv7WLejo5LMV2fcB85rCaFubnNBTuqzx29snI5rJnAwwnaYbbT1
         KhiqFG0VMzy/9M41iSlKZS+qZ5i3n0fVr3a3F75WcSTFcg+IjobBKPu4sjvpM3ZChSLK
         zYRyQFn5eA9iK1EYYNRw3ptYpEorYRh9ZI2VH9IUlCw+exZ06uNonKvFRIK7LL+LJiuD
         86UfR5G0e324B3yAGi24yaNotOUJrUICTH3t13FPniBgHlNouLSx6mOMqg/q9z7WHR+s
         hL2w==
X-Gm-Message-State: AMCzsaV/fZq/elMOQHI9xvrQHz+Md2yWHT7+cWZo0A66xMNL0XMgaHyh
        YnRlAVZWp+SP60G0yMR0Eys=
X-Google-Smtp-Source: ABhQp+QsWwTSeAnLg62/x6tLH1jVtOEOBTjpviJhWG3K78TSgWLa0nZYQ9/iyuYH7INkD+BMPWBRTw==
X-Received: by 10.223.142.97 with SMTP id n88mr3696493wrb.244.1509661091658;
        Thu, 02 Nov 2017 15:18:11 -0700 (PDT)
Received: from laptop.local (host-78-145-151-122.as13285.net. [78.145.151.122])
        by smtp.gmail.com with ESMTPSA id r29sm5096371wra.71.2017.11.02.15.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Nov 2017 15:18:10 -0700 (PDT)
Date:   Thu, 2 Nov 2017 22:18:07 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] remote-mediawiki: show progress while fetching
 namespaces
Message-ID: <20171102221807.juon446b6zfw64cq@laptop.local>
References: <20171030025142.19421-1-anarcat@debian.org>
 <20171102212518.1601-1-anarcat@debian.org>
 <20171102212518.1601-8-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171102212518.1601-8-anarcat@debian.org>
User-Agent: NeoMutt/20170714-87-e4144b (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Nov 02, 2017 at 05:25:18PM -0400, Antoine Beaupré wrote:
> +        print {*STDERR} "$#{$mw_pages} found in namespace $local_namespace ($namespace_id)\n";

How is this any different to using warn()?  I appreciate you're using a
globbed filehandle, but it seems superfluous to me.

Kindly,
Thomas
