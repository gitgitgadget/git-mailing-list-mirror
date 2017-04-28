Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8340207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163867AbdD1P2T (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:28:19 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36886 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163674AbdD1P2R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:28:17 -0400
Received: by mail-it0-f46.google.com with SMTP id x188so41365883itb.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kjWVnfRNAsDzIqzbLfheAJ+daUg/nMK+HcG9qHfs5+E=;
        b=SYZ3y4Qv2cns7aD+FgprWP+9/ShPfAW8r8eRmX9u6cKS/WSAUn/2LcBZ/c93Kn1dtW
         QFKP1p3eh+56p1ZAKWU4l9+ns6zlyXys2BpTO5jO9rhwfRCIRGabxfqTqIYKbMKZfVbn
         AadmtcmLEUx4FJcIFb4f0k9Bywtqa9aoHLVutjhLtDaBu0+zoj9kYYuReWfAVEGWGpKa
         Zi1EwIVb9hYv18I3tHcyoFbHjKjoGp0elJQ0VlmReiWQmATLoMGRH1neWrPbsjt9jdne
         12J339b6IQ/wNG601wzcp2uEBwe6yHbbg7nD09Plu7CBlpr1B3R/qfr8nfo3kBS19x6R
         qcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kjWVnfRNAsDzIqzbLfheAJ+daUg/nMK+HcG9qHfs5+E=;
        b=jNTc9WchbrDfOsFuXZM6iUr6ivchVCaTJodOf78YMfw4pM2wczxFJfp6fQjPN1bkur
         PpsL4tcXmPamqoqU4Vbh9XKSIFp5xYLDmhaQbKn/sNulWKf662u6oflMPdfGehJqZMHm
         +/YEUq4J05Yk0iPfnVpGvS3XxaK47d/0JaUY8gVVF9Lp0B0X6NWAL7mA3EAjlxOIa1LQ
         IUNeOiE8zICoxJ2+SynpmWRX/C1W6GJxEc+zqqrpwadl7UVL+Sl7VtQJvhVrkbwD0/xR
         m3oL4ZBME6qkOcaY5HDCjMctBAcWmQTh/3rxXfp3FUPoPq3nuM+FryVWlFv2clsSN/hS
         ZXZA==
X-Gm-Message-State: AN3rC/6IrMb4HbhEJjkEWs3e2f3IZE/7+9j7SISVx9kHJQjzgOBLlI6D
        IaY+KKFboZd788f07mqmvs+l47g2T35agpM=
X-Received: by 10.157.36.226 with SMTP id z89mr4361715ota.45.1493393295351;
 Fri, 28 Apr 2017 08:28:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.136.13 with HTTP; Fri, 28 Apr 2017 08:28:14 -0700 (PDT)
In-Reply-To: <20170428152025.7lgkirbhpsccupt3@sigill.intra.peff.net>
References: <CAH6sfJUn99ezs-uZuYVj15qOeMv79ji7r0Ldvoreef0z3LzG8Q@mail.gmail.com>
 <20170427201804.3abt5ht6dkwwqo4r@sigill.intra.peff.net> <CAH6sfJX338f=WyEbCBXX_bzq=homhMs=cjPtzmH9cSvtBKPnaw@mail.gmail.com>
 <20170428152025.7lgkirbhpsccupt3@sigill.intra.peff.net>
From:   Andrew Watson <andwatsresearch@gmail.com>
Date:   Fri, 28 Apr 2017 11:28:14 -0400
Message-ID: <CAH6sfJUoCPVJz47U8wA306hkCo_Z+gv5s0XHjtkGH6fj8-hUZQ@mail.gmail.com>
Subject: Re: push fails with return code 22
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Thanks for the help.

$ GIT_CURL_VERBOSE=1 git clone http://git.site.domain.com/foo/gitrepo.git
Cloning into 'gitrepo'...
* Couldn't find host git.site.domain.com in the _netrc file; using defaults
* timeout on name lookup is not supported
*   Trying 192.168.16.138...
* TCP_NODELAY set
* Connected to git.site.domain.com (192.168.16.138) port 80 (#0)
> GET /foo/gitrepo.git/info/refs?service=git-upload-pack HTTP/1.1
Host: git.site.domain.com
User-Agent: git/2.12.2.windows.2
Accept: */*
Accept-Encoding: gzip
Pragma: no-cache

< HTTP/1.1 200 OK
< Date: Fri, 28 Apr 2017 15:25:02 GMT
< Server: Apache/2.4.6 (CentOS) PHP/5.4.16
< Last-Modified: Tue, 25 Apr 2017 18:11:35 GMT
< ETag: "0-54e01a77ac500"
< Accept-Ranges: bytes
< Content-Length: 0
< Content-Type: text/plain; charset=UTF-8
<
* Connection #0 to host git.site.domain.com left intact
* Couldn't find host git.site.domain.com in the _netrc file; using defaults
* Found bundle for host git.site.domain.com: 0x1cc9fc0 [can pipeline]
* Re-using existing connection! (#0) with host git.site.domain.com
* Connected to git.site.domain.com (192.168.16.138) port 80 (#0)
> GET /foo/gitrepo.git/HEAD HTTP/1.1
Host: git.site.domain.com
User-Agent: git/2.12.2.windows.2
Accept: */*
Accept-Encoding: gzip
Pragma: no-cache

< HTTP/1.1 200 OK
< Date: Fri, 28 Apr 2017 15:25:02 GMT
< Server: Apache/2.4.6 (CentOS) PHP/5.4.16
< Last-Modified: Mon, 24 Apr 2017 20:51:42 GMT
< ETag: "17-54defc6469818"
< Accept-Ranges: bytes
< Content-Length: 23
<
* Connection #0 to host git.site.domain.com left intact
warning: You appear to have cloned an empty repository.

Content length is again 0.

On Fri, Apr 28, 2017 at 11:20 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 28, 2017 at 11:09:55AM -0400, Andrew Watson wrote:
>
>> Thanks for pointing me to git help http-backend. I confirmed the
>> modules are loaded and the CGI environment variables. I've added
>> "AcceptPathInfo On" to my httpd.conf just to be safe.
>>
>> I'm not sure what /info/refs is supposed to look like, but it is
>> empty. Could that be the issue?
>
> No, that shouldn't matter. The on-disk file is used only for dumb-http
> requests. In a working smart-http system, the info/refs request should
> go to the CGI, which will generate the ref advertisement dynamically.
>
>> Do you see anything in my apache configuration that looks wrong?
>
> It looks reasonable to me, but I'm far from an expert on Apache config.
>
> When you clone, is it using smart-http there? Try using GIT_CURL_VERBOSE
> to see what the response is to the initial /info/refs fetch when you
> clone.
>
> -Peff
