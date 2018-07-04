Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081791F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 14:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeGDOb7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 10:31:59 -0400
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:46643 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752136AbeGDOb6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Jul 2018 10:31:58 -0400
X-Greylist: delayed 2084 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 10:31:58 EDT
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id 92A141AB182
        for <git@vger.kernel.org>; Wed,  4 Jul 2018 07:56:58 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id aiHBfBl67BMJeaiHBfaAwR; Wed, 04 Jul 2018 07:56:57 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fUtNGpEJy71G8cmxfXyjm3gunDFtTRBcH/QTIkwUFBE=; b=QCyi7i/eqDHLFYqTcHiVkjgXDA
        IcuH4s4R8u73Gv6N4t4kFeaFzDiQzDBrZ4WFUluc1bnXMfzilUSAA5hcbgbQpqIbFshiXl8WXr+s3
        kinoWvmpg/FbhwWbmb5B+M3sN;
Received: from pool-72-70-58-227.bstnma.fios.verizon.net ([72.70.58.227]:36128 helo=homebase.home)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1faiHB-002I1W-Tj; Wed, 04 Jul 2018 07:56:58 -0600
Message-ID: <55733da67095123ced63095aa554970053bef321.camel@mad-scientist.net>
Subject: Re: RUNTIME_PREFIX references in gitconfig variable paths
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>
Date:   Wed, 04 Jul 2018 09:56:56 -0400
In-Reply-To: <nycvar.QRO.7.76.6.1807041323490.75@tvgsbejvaqbjf.bet>
References: <e9d5bbec6242e47b1f4141ffd99b276eb6a41347.camel@mad-scientist.net>
         <nycvar.QRO.7.76.6.1807041323490.75@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 72.70.58.227
X-Source-L: No
X-Exim-ID: 1faiHB-002I1W-Tj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-227.bstnma.fios.verizon.net (homebase.home) [72.70.58.227]:36128
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2018-07-04 at 13:26 +0200, Johannes Schindelin wrote:
> On Wed, 4 Jul 2018, Paul Smith wrote:
> 
> > One thing I wanted to do was provide a default ca-bundle.crt file
> > along with my local build of Git.  I need my installation to be
> > relocatable and I'm using RUNTIME_PREFIX with Git 2.18.0 (on
> > GNU/Linux).
> 
> Understandable. We do this all the time in Git for Windows. Our
> config entry has this form:
> 
>         [http]
>                 sslCAinfo = /ssl/certs/ca-bundle.crt
> 
> and in the RUNTIME_PREFIX mode, this will be made relative to the
> runtime prefix. It is my understanding that bf9acba (http: treat
> config options sslCAPath and sslCAInfo as paths, 2015-11-23) makes
> this work.

Hm.  Unless I'm missing something this doesn't happen (and indeed, it
does not work for me; with:

  [http]
      sslcainfo = /etc/ca-bundle.crt

I get:

  fatal: unable to access 'https://github.com/myrepo.git/': error
setting certificate verify locations:
    CAfile: /etc/ca-bundle.crt
    CApath: none

although it works if I use a fully-qualified pathname, and using strace
I find the process never attempted to access any other path for ca-
bundle.crt).

In http.c we see how this path is treated in http_options():

        if (!strcmp("http.sslcainfo", var))
                return git_config_pathname(&ssl_cainfo, var, value);

I can't tell exactly how this function is invoked, but the result
(ssl_cainfo) is used here without further modification:

        curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);

In config.c we find get_config_pathname() which does this:

        *dest = expand_user_path(value, 0);

In path.c we find expand_user_path() which does this:

        if (path == NULL)
                goto return_null;
        if (path[0] == '~') {
            ...
        }
        strbuf_addstr(&user_path, to_copy);
        return strbuf_detach(&user_path, NULL);

I don't see any reference to system_prefix(), system_path(), etc. which
would be needed to RUNTIME_PREFIX-ize things.
