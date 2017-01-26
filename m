Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F811F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 05:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbdAZFF0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 00:05:26 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33549 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbdAZFFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 00:05:25 -0500
Received: by mail-lf0-f53.google.com with SMTP id x1so53275830lff.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 21:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X2KKhsXTtpYnZreUldn9/niHooq+c/qnusuc0CY4L14=;
        b=AOECOMBu0VDtZq5jxcbE96wjzK0TaD4amBJbtti4795+F8Qyq9NxAAksLvLS+ls+3q
         FVsREiV6/+YeAFSNb6BoiQ6Wf8Ypw/Q6g4s73owDfD3DFcNt+yMZvzFf4KT+9GQ/JGmt
         9SniiRPUx5SMQPA5ZBFyJ0fzuBD+fq7QI2XaEnm6cyODKs6j1JKzf0OJwVLTMzwWkM7Z
         4mNCuejwRGY2Pb7dSC+xVg5ayj6X82z2rBB7Eb6flBWWrYJPQ1RVIsLB0gBWdGtm2bGF
         qumo63mhJitn8kw0IDAP0utXptQBSU/tYict3qu5T9IONDXoj0+5n5UcYm5qiVztl0kV
         8Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X2KKhsXTtpYnZreUldn9/niHooq+c/qnusuc0CY4L14=;
        b=raR6wDtv3lbRTcaBqMexODBstP9ORGYuKRKiqv6t4mDHtlge2bJMslseghnpUOLimA
         JkDIxQNJdfZ2npZiQmqXjYZT89b6ZkcQ/NTU5S6SV96f1XAETIcw5oObri5Yolbgi3B0
         pu8czEtetF3C/kUGLuj3EaeWpGgKlAgNp6ZPVwUCnlOAz+zvg3AL0lFFnj0hi4b6qHdg
         FQjLhYk+zOeyFFxx9OcuI1wiQMr3kAJ55PhRAVRrRCuI6Lv+alumFa+dMfUs/5ZXAg7M
         lPwBxQmIb9TV21NpOWvikgzM5L2soEH6/1Y5uMkBFFVVAK/ciVWFbvE18aBgBKViJ2bz
         qDQg==
X-Gm-Message-State: AIkVDXK5tkSNjkMU+T46DaSZj5oz3DWYs4I9AKpGeeTlHTsUU31eCSnA01AcKGrBVlYrtGhB+4wgC7JzEg64wA==
X-Received: by 10.46.1.153 with SMTP id f25mr231604lji.47.1485407123512; Wed,
 25 Jan 2017 21:05:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 25 Jan 2017 21:05:02 -0800 (PST)
In-Reply-To: <xmqqd1fa7dqf.fsf@gitster.mtv.corp.google.com>
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
 <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
 <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
 <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com>
 <xmqqh94m7leb.fsf@gitster.mtv.corp.google.com> <CAE1pOi0CgfxQTygg_i3dc_-_Lb8qgOOk_0hg+goJvm7PyLZseg@mail.gmail.com>
 <CA+P7+xocc==-8ad-OVTahMDABA0-spDPEw05JTHopfO7Ovj2RQ@mail.gmail.com> <xmqqd1fa7dqf.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 25 Jan 2017 21:05:02 -0800
Message-ID: <CA+P7+xqnaxWY+3Ve77ijFx4g-xLUh57c2+fadyHj5_iEuKtdUg@mail.gmail.com>
Subject: Re: Force Confirmation for Dropping Changed Lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 6:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Where did you get that "unset" from?  If that is this paragraph in
> Documentation/gitattributes.txt:
>

Ok so that whole section of documentation is very confusing to me.
Maybe it could be improved for more readability. I'll see if I can't
help clear up some of my confusion.

Thanks,
Jake
