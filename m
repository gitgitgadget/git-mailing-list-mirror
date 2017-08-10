Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3EF208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbdHJSfD (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:35:03 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:37256 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbdHJSfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:35:02 -0400
Received: by mail-lf0-f49.google.com with SMTP id m86so7155941lfi.4
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w8gxW6NxetCJfoikQqciiD0lF57R24jhuQnId6bSQWk=;
        b=qQsrqpbHMX0VmbWOYy+ngdJk6YzTVCxZb77lMkcVWcyc7MQAw0IcrMtFDOHSGG/xGj
         cWagz1AWuHNkupmEp14hJobfEGnm6WuyKmP2LraHIBq2mdL6ZEWddbOenI3vIcqpAjRu
         Y/Nvs7bFG4sTf24WZaehzUaU+Yc/U9BgrWqgaZwa/kh2XgvJM9uld5PrzEYkQzsFjxC1
         y6pu7ZJy8yoz32NE8A88HLDV8KyKbh35Lic4pil4zH1Daw6wR8MBqpHmfUrfGHFySzQF
         JMTqe6ZhN22auLXMufgtWqDxCZFGz2td+r94rQdRsRhjFdAUT+ssp9QLAZ+bNULe2ecD
         BeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w8gxW6NxetCJfoikQqciiD0lF57R24jhuQnId6bSQWk=;
        b=uiIjIMY319pdiZt1Cy0oc2sVd69Di0RMuLWD+veuywCdlnA69/NppydbkjbMlWdr+v
         tyRMCd2SKvBgvxeLpLBZxN6bBLdohsxDXqWt5JkpJlPauWT9rRGWLWb7n8f5Wp8Akzn+
         nsDRwSuX9LNayX4YEamGSEhPBL2aEv0AKmSz5xC0mViOpGt/UrI4kjb/JFkRA+PfCPbi
         GvXEwqlv41xHBZFde+hs7az+TdGxu4uDPPt/0YhPzwErQxOk8RWPGUF9GtWknf70UEQW
         Ku+oy93lktnEY81bBcdc89qzUCmLbP4IWkc6dhIdzpJ2P6fqNzDthkT2ozZOYJcPv5of
         ppYQ==
X-Gm-Message-State: AHYfb5ioQKwT6Zz2jQ4Qoc46zyHGTCgU9FsrCUTt8WJrxhPY3gZIuuk1
        iWfD0UBQkFK10+32a/aKubL7yaKGcyiU
X-Received: by 10.25.15.221 with SMTP id 90mr4549963lfp.220.1502390101363;
 Thu, 10 Aug 2017 11:35:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 11:35:00 -0700 (PDT)
In-Reply-To: <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net> <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 11:35:00 -0700
Message-ID: <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 1:03 AM, Jeff King <peff@peff.net> wrote:
> The point of "--only-trailers" is to give a caller an output
> that's easy for them to parse. Getting rid of the
> non-trailer material helps, but we still may see more
> complicated syntax like whitespace continuation. Let's add
> an option to normalize the output into one "key: value" line
> per trailer.
>
> As a bonus, this could be used even without --only-trailers
> to clean up unusual formatting in the incoming data.

This is useful for the parsing part, but for the writing part we'd
rather want to have the opposite thing, such as
'--line-break=rfc822'. But this doesn't have to be part of this
series. With this in mind, I do not quite understand the latter
use case how you would use normalized trailers without
--only-trailers?
