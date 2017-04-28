Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BF4207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424309AbdD1PsS (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:48:18 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37703 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbdD1PsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:48:16 -0400
Received: by mail-it0-f44.google.com with SMTP id x188so42035822itb.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f9WkgzdAA1ZsSw1Ms1uduGEOWI4H+OQtgVx0xF8iUrM=;
        b=I2skvnzCEQ+yGkdu5dQVVciBLvyUgV05DjdQK1r2dn//Fi2W9dZo1sYpAGXIro5wHA
         CK65n9rr3n162pWAaU9DtryxwlO4oR4H1N5RcfC/KDx8JaWgSFdmCCtZRRpsJFTZ4YLC
         jsaPDkk2bPzmTrH2/nhYo5gX3RVfYkpGS2pK2t0G52plHyjZ5pdZW9e/K4WWkoUpz3gM
         GY6qj4Y82+ojturVR72B5xT5R3RabJ711zHO/n79Vv28hQZ7O1uIVrznpoZk08NZDgl4
         TGEU8vHOHS6ZoqwcGb/t74aKpb1siUHYWYpdDKt/Kw6+A0fzeSkevoQ2306p4hR9PNBY
         bE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f9WkgzdAA1ZsSw1Ms1uduGEOWI4H+OQtgVx0xF8iUrM=;
        b=G1AirEvZcEyFNWHTI4BTIXe/+A051kb6cERopOBrcROH/Jn/xLeJuoSLgbArrHihF9
         cdLXIkNUkFWX+e2p+vGynzu8hBnu2hz5LCu82vAEIwf7mjjPY577wPqKLOT7YHhWmXeO
         cn22/u3sKzHUgFGGibq3djE1oMMyIBfUaCk75fcFDrVGOneazERrhYi+2v4TqdmLAZAx
         NtFgp3+LnMxveTWYJgGpCVuCTgrWFWK7CsRHIEHqItSSeol/eQciGsAXQaAYOvhIm0oW
         syRPfVoY1rEZr4y/SxOO7PQ83BaErJpr4jrTBkpj7ps/yUJNLX5yxhvahtPzKRy6Xi9Z
         BV0w==
X-Gm-Message-State: AN3rC/731Osdl67LZE4u1RwPtk5wY5CZaD1kJG0pPo1ZAj5QtWv238pY
        JyJZ+BPvwidE1kF9ne0/GEEEVBbQVQ==
X-Received: by 10.202.207.145 with SMTP id f139mr4474953oig.55.1493394495318;
 Fri, 28 Apr 2017 08:48:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.136.13 with HTTP; Fri, 28 Apr 2017 08:48:14 -0700 (PDT)
In-Reply-To: <20170428153446.z5pp55kdniubt5ia@sigill.intra.peff.net>
References: <CAH6sfJUn99ezs-uZuYVj15qOeMv79ji7r0Ldvoreef0z3LzG8Q@mail.gmail.com>
 <20170427201804.3abt5ht6dkwwqo4r@sigill.intra.peff.net> <CAH6sfJX338f=WyEbCBXX_bzq=homhMs=cjPtzmH9cSvtBKPnaw@mail.gmail.com>
 <20170428152025.7lgkirbhpsccupt3@sigill.intra.peff.net> <CAH6sfJUoCPVJz47U8wA306hkCo_Z+gv5s0XHjtkGH6fj8-hUZQ@mail.gmail.com>
 <20170428153446.z5pp55kdniubt5ia@sigill.intra.peff.net>
From:   Andrew Watson <andwatsresearch@gmail.com>
Date:   Fri, 28 Apr 2017 11:48:14 -0400
Message-ID: <CAH6sfJVFKJAEm-RpAGXoTaE6eDCnFiuQaw2K1Pk2ZBu36dZvfQ@mail.gmail.com>
Subject: Re: push fails with return code 22
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You are the best Peff.

It was indeed the hierarchy. So just had to change document root.

Thanks a bunch.

On Fri, Apr 28, 2017 at 11:34 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 28, 2017 at 11:28:14AM -0400, Andrew Watson wrote:
>
>> $ GIT_CURL_VERBOSE=1 git clone http://git.site.domain.com/foo/gitrepo.git
>> Cloning into 'gitrepo'...
>> * Couldn't find host git.site.domain.com in the _netrc file; using defaults
>> * timeout on name lookup is not supported
>> *   Trying 192.168.16.138...
>> * TCP_NODELAY set
>> * Connected to git.site.domain.com (192.168.16.138) port 80 (#0)
>> > GET /foo/gitrepo.git/info/refs?service=git-upload-pack HTTP/1.1
>> Host: git.site.domain.com
>> User-Agent: git/2.12.2.windows.2
>> Accept: */*
>> Accept-Encoding: gzip
>> Pragma: no-cache
>>
>> < HTTP/1.1 200 OK
>> < Date: Fri, 28 Apr 2017 15:25:02 GMT
>> < Server: Apache/2.4.6 (CentOS) PHP/5.4.16
>> < Last-Modified: Tue, 25 Apr 2017 18:11:35 GMT
>> < ETag: "0-54e01a77ac500"
>> < Accept-Ranges: bytes
>> < Content-Length: 0
>> < Content-Type: text/plain; charset=UTF-8
>
> OK, so this is not doing smart-http either (the content-type should be
> application/x-git-upload-pack-advertisement when the CGI generates it).
>
> Looking at your config again, I see:
>
>   ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
>
> but your example output shows:
>
>   GET /gitrepo.git/info/refs?service=git-receive-pack
>
> I.e., not in the /git/ hierarchy. So that might explain why the CGI is
> not kicking in.
>
> -Peff
