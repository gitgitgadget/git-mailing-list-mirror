Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADBC820A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdJBAbU (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:31:20 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:43173 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdJBAbT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:31:19 -0400
Received: by mail-pg0-f47.google.com with SMTP id s184so521248pgc.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6i0dbw3N3XaEVKiUj22/8U98mHiF9jD8Ep5Hxw10gfE=;
        b=dQJEfOOiubOdPyIbhdIbxCueWQEbipeCSEO3WfbY8OK70mz2BTcFmGiBimV6VMryZn
         pnqgRmrv9wtgTqfhs0ZsxHK6rZb2VRq5DxUoLwkR+68LHQsr3ZaiXljRpyEFyvyBprFU
         foyUkl5nCrUijx15QKC9wnWRAcIafH3O0AKI4W/FMyUqCo3AUZM/2brEP/2XbOzEcSmB
         XcatT/shsUmRx//3nWPfzEUpKV9rvAJx/KkNzFzbDEGtwGzQR9qGa92CV8ddDKSJG4/+
         IuQW3b6CGTW2yReB7pGtO8v4s7ST1e29PgcmXkyVtTq1v8rUkyDFBU1+HnTg1H8KLHCN
         78Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6i0dbw3N3XaEVKiUj22/8U98mHiF9jD8Ep5Hxw10gfE=;
        b=kkm14L5Rd2+TfW47/Glp4u/NI+FicDFdO2sFAyVY+5SA2mQk7AwbWI6WVdLjiNjN8V
         x4NWEC/gkWMYgtq35cCSViPo6HANTIZ7kZ+ZuzJziG5WRmVKy75/HWPzN1bveLLlynk1
         5f/BtT0yLUTKzxrsGupFAYXat5okzXSLTRc26j2fssSH0Xxj+Dbn+ZtkuFjKHNu28GgX
         7XBhnIhw/z9HEtl0kk42V2hRM8l7ZpqT+dyeafeT1vHdYvuxfsnjAEuGKlxkPRr46pVK
         /yZK8pPFqAx6np655Pdeyj7/hh+aFr2oStfixQhWX69CoNFgbBwNII3ijpZjmBYuXdGc
         IS9Q==
X-Gm-Message-State: AHPjjUhQuD0fXz9DyfHYfimbI3RhXTsiZLn1gKYxKZLa9flbcWUjhPVa
        uuCWvH+Y5pycn3Fb/zV512g61c59+Ds=
X-Google-Smtp-Source: AOwi7QCzuKVNJ4AFt947hSnhDlhblDdGNKp6j/Ma+dv81dMMGLl8ETftVP/CHZTVxoUibvFK5bEZxA==
X-Received: by 10.84.129.193 with SMTP id b59mr13084333plb.121.1506904278630;
        Sun, 01 Oct 2017 17:31:18 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id o17sm4776665pfj.93.2017.10.01.17.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 17:31:17 -0700 (PDT)
Date:   Sun, 1 Oct 2017 17:31:16 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v5 0/6] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the fifth revision of my patch-set "Support %(trailers)
arguments in for-each-ref(1)".

It includes the following changes since v4:

  * Clarified "ref-filter.c: parse trailers arguments with %(contents)
    atom" to include reasoning for passing NULL as "" empty string in
    contents_atom_parser.

  * Changed instances "fencing" to "quoting" in "doc: use modern
    "`"-style code fencing".

  * Changed indentation in "pretty.c: delimit "%(trailers)" arguments
    with ","" to silence the output from `make style`.

  * Fix incorrect indentation in "ref-filter.c: use trailer_opts to
    format trailers".

Thanks again.


- Taylor
