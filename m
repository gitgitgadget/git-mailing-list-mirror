Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C051FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 00:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbcICAhN (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 20:37:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34693 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbcICAhM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 20:37:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id g202so6388011pfb.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T5dS4RAJd+eDgYmEzAW4z6erkPwVtGZYp95K1DHmb3A=;
        b=czHQ0805jkEXEH9m3V6uMowvzpgF9s6G42guahEJKWJ4GgKgReZ3PRwc2F3fkdY3SQ
         jMrTaL71n9c7O69+5fPhW49taXUUOapoxr9TFEMZCpV5KaL/ACZ8gcM38FQ6SMXiSV/8
         idK3Q9eDeGriBLRT6RUiJRmycTZpkYL/WYnq+H5TmjbGqVY/RgKIXyqH4yWPqDiV3I6D
         Pc5jH6Ugxz4xfPX6L5KeArz8uuQYcmhIb8vQ2FwFYuvOnIg6WPZVzbjzsYh9XRsCBAxJ
         Mtlt6LRGSlfMax/Qe+02GG7vs4pO4BvqfYSd+i62JvdpjqxOax+bFQF+8jd9bxvkg1rp
         zQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T5dS4RAJd+eDgYmEzAW4z6erkPwVtGZYp95K1DHmb3A=;
        b=hYmIiq/d4L3ag9zTp1fg4AxIi4kCJFczMqmEQqQILSqWErqX0mWIb5ZiOgKYMMrQEn
         h/sS0OumtocR9xlSWmO3DdOloAdINezl3a8CPGC/Z830/wJj4E3e6r8m348zdtlONJR0
         hQZn48+msGQqyu7Aa9MrS7BniJN9Nkwho6C62psMh38g/FrgyRoKQzIgoNFFv0tY/FdE
         JJb6ufKBaCw9SqFFSLMbJMOufLlqNZu5FxEZVvKUGAjxfE6SzN+3RecOvhdwIgKSO683
         J+/n0QPHEx21bOYdT9vk7jotQU/tO+KONhGYJ6DonxBWazR8vziT7LozT1wV7qWz6Ky0
         VpoQ==
X-Gm-Message-State: AE9vXwPejAeDlrf0l4RHPigFQbRLyo7xM+jDOPX78aqaRhPTisKQPutrTAaqKgYd/F0Uyw==
X-Received: by 10.98.108.4 with SMTP id h4mr41405339pfc.128.1472863031966;
        Fri, 02 Sep 2016 17:37:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:34:ec2f:e9e8:7f87])
        by smtp.gmail.com with ESMTPSA id p64sm17362792pfd.11.2016.09.02.17.37.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 17:37:10 -0700 (PDT)
Date:   Fri, 2 Sep 2016 17:37:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
Message-ID: <20160903003708.GJ14758@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1472853827.git.jonathantanmy@google.com>
 <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
 <20160902233547.mzgluioc7hhabalw@sigill.intra.peff.net>
 <CAGZ79ka0VvXbkR+JYJwK9oyRzcsDXDoqKXyp4F+moDc4qDuv7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka0VvXbkR+JYJwK9oyRzcsDXDoqKXyp4F+moDc4qDuv7w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Fri, Sep 2, 2016 at 4:35 PM, Jeff King <peff@peff.net> wrote:

>> I'd be more interested in the pain of this transition if there was a
>> concrete use case for "hide literally all refs, but still allow
>> fetches". Is that a thing that people do?
[...]
> Not to derail the discussion to much, but let's talk about protocol v2
> for a second:

Uh oh. ;-)

>     One of the ideas we floated around for protocol v2 would be exactly
>     that: the server advertises only a small portion (could be just master
>     or no branch eventually) with a capability "v2" and then the client
>     selects that capability and after that there comes protocol 2.

Sounds scary to me.  What would happen when I try to clone a
repository with a v1 client?  I'd see nothing.  I'd want at least a
"master" branch with a README file (or an ERR packet?) saying "please
update your client".

>     The advantage of this approach would be have a functional
>     v1 server still running, but the meat is found only in v2: e.g. via
>     v2 you can obtain all pull requests/changes or even wiki/meta
>     information stuff that would be too large to advertise in v1.

This sounds less scary, but it doesn't answer the question Peff
raised.  Wouldn't it still be typical to advertise at least one ref,
which can contain a capabilities line?

However, another idea I think you've mentioned before on-list about
changing the ref advertisement could answer it.  Suppose that I always
include the ref advertisement in my first reply, but I provide a
capability saying that further requests to this server can use a
different mechanism that skips the long advertisement.

Normally that would work great --- I only pay the cost of the large
advertisement once, and from then on I can cache what the server told
me about how it prefers to be contacted.  Except what happens if this
was a new repository and my first contact with the server was to clone
that empty repository?

In that case, getting capabilities with the ref advertisement would
benefit me.

Likewise for other capabilities that may come with such an empty
fetch: for example the server could tell which unborn branch the HEAD
symref points to.

Thanks,
Jonathan
