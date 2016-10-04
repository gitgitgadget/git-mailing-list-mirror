Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E1120986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbcJDWgu (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:36:50 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36853 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbcJDWgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:36:49 -0400
Received: by mail-qk0-f180.google.com with SMTP id o68so63734680qkf.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 15:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RkZVrrdD6oMosFFCy2sxgeX0fhlwp6dw+7gfgGtnBjA=;
        b=L3p5yVVlbRj+NjgUw82RUElFztGoWOL/g23nr+mwQf7ico28hWoA3SqKUuWRmqLjCW
         2LWDeXIB8xUXMF/wGTlmEJRP+qyyWb+C4b7s6Gox9Ev2Ujt2+mE0xb0PQvel30RkVJwd
         8EtzBExjVPd10+KDk5rRWoTJZmVE0gk/nLVK63d8v+GE6jXF29ozn4ThXB+V4kYSIIDu
         8W1B9OxDTnyEBBwEmkGw+ZPYY8Lux033VtYxV1ROhQleVsKFgQUD0cdSyQMWFtX9WLPD
         v84H5Byow8aYf9zTCKCuJoN0/SGZOj4Fv02Fk80PrLd792nbixWIa6wCCIGq0zaNoGqL
         EgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RkZVrrdD6oMosFFCy2sxgeX0fhlwp6dw+7gfgGtnBjA=;
        b=c8Mm7cZGlOSTx4h+YY/0j3v3dQES3X7mxVV6cAZ4cy5/rjSnaRKu3wo/0pMbL6o8iQ
         SYyspha+7qEk8Cn0G5NibowoUD7gltAoKaC3Q9ULm2qAFJH/8Yh4Xoy0kzQDI25HcYOy
         SpWt0x1KAmcLsJEIWCBIH0WuonC20KLClamBWkwjMlaAkfjOyool5Ed5osAgSZOIeB5/
         qAaCXbbt5hdOs2Wgbf4jk5pa2S/HMH7JmGZpkP+OREPWnT9fT4vWCZfTafZXikhzyBZ+
         P4OxDiAo6zbV/sibzt4fquq+mPlBkhSGF9LiIcdyqyTKpBHq+R38ekbMzA41+zFIYEhF
         g+yg==
X-Gm-Message-State: AA6/9RkghBp9cVCu+EZjxyNzibxLgG+XSinsIJNbeikxJ8vA9EBGTu4TVpIOmexNFjpxuzfmTC2+d0MPTKctDdfD
X-Received: by 10.233.216.194 with SMTP id u185mr6350500qkf.173.1475620608612;
 Tue, 04 Oct 2016 15:36:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 15:36:48 -0700 (PDT)
In-Reply-To: <xmqqh98sw0tv.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com> <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
 <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com> <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
 <xmqqwphp5f9q.fsf@gitster.mtv.corp.google.com> <CAGZ79kYt+Z=ff1b2G+wWRAGGS=je+dpksfmMXj0fWwYVvHk8Cg@mail.gmail.com>
 <xmqqh98t5c69.fsf@gitster.mtv.corp.google.com> <CAGZ79kY+yB-AxRUt0rArGw6DaLDsMZDjKt2jQh9B=P-79T+qYQ@mail.gmail.com>
 <xmqqh98sw0tv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 15:36:48 -0700
Message-ID: <CAGZ79kbmSVF42C4FxgC6Bvp0edfq1_XOZKWgwb13JZgug6NsBQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 9:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The question git_all_attrs() asks is quite different.

And as far as I can tell it is only used by builtin/check-attr.c which we do not
intend to convert into a threaded beast in the foreseeable future I'd expect.

So maybe we can just punt on redefining the API there, i.e.
we keep the question and answer together in a struct git_attr_check.


<some return value here>
git_all_attr(const char *path); /* no other arguments except path*/

That looks great, and I incorporated that into the proposal I sent out
as an RFC.
