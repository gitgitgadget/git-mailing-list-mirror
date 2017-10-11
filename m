Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E550C1FA52
	for <e@80x24.org>; Wed, 11 Oct 2017 23:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdJKXKa (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 19:10:30 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:52754 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdJKXK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 19:10:29 -0400
Received: by mail-pf0-f176.google.com with SMTP id e64so2384425pfk.9
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M514bjoD9nEGXMG0YPZSkvA3n2qbhYetzln5scv3yPg=;
        b=WSposQFlJ58zt6sR/X4pN2n7dpj4Y6+kLr2joQuXyPnHqPPzaavq03YivI3aqkWCm8
         1Yrs91AI0lQZ551B/sRZuB9bKieD5ayAjuhuTdEd56UBl68nMju/TEcYr/GNHv5OX2WD
         uQs4CkVtJPo/2RAz2PHnAr56TEm+9wy8jJDIg4TounxjMZq4ORf8OMErmW16K0/ekQZc
         RtMXXbXwFTQ7FkUVkJ9ZSRhBstEN92SDVRl4H9SYvQ7LFMNk0GajprbvtJ2+xLfieUUW
         Z4OZF4BaktfnQjAHYgIOCdXVFhAPfIJiQ9UZgDw8DwjFMffeWqz3YnIdFrD5jtMFTlFw
         riLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M514bjoD9nEGXMG0YPZSkvA3n2qbhYetzln5scv3yPg=;
        b=AwwkidtTG/bKJPvVlbUPw/AkQIWseY/UYOxGLLqvzpblJ3jQ5XyQJ/fpuxH6NGXBs6
         ZFUQEUx+YIJYJtYwn2XCa/JZxbx6OVEjfPocupv++CV/ZrLiTTC1mtke/BNNM6Y8qX0y
         mS39vc01b7seeDSFDnQhWa1bcvk+5MCghgwxh4ZIIyJALCAP47+xemTRjcTo9aJsW3A8
         GzR465yqpCgxFEvVqa3xOuvk6ibY6JK5MlGr4MhMEk27QieuRiGTxBpHuSwup6LQ79Ew
         7k7ilqhnvx3Mngag2KbNf+PcVIynMkLExjz77nbgMZzp8R/B0Twny4DwjkIE59YsxvJN
         OcJg==
X-Gm-Message-State: AMCzsaXeIkUv0qNO/BJQUWD4TVN1nJA2sQMETTcCANGuyyy9XcTPoh/C
        D4v5PsS9sBejs4puVnJLXVJDpoAh
X-Google-Smtp-Source: AOwi7QCeXOTHgVPWGGshKpBj6c730Vi3hD3wqbEP6RbO+RAfLV9RWQFGz90virW+s8Z8S7QiL2qQzg==
X-Received: by 10.98.214.17 with SMTP id r17mr505183pfg.246.1507763428565;
        Wed, 11 Oct 2017 16:10:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9e:660c:b9bb:a349])
        by smtp.gmail.com with ESMTPSA id d7sm23816121pgf.20.2017.10.11.16.10.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 16:10:28 -0700 (PDT)
Date:   Wed, 11 Oct 2017 16:08:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: v2.15.0-rc1 test failure
Message-ID: <20171011230830.GA47665@aiede.mtv.corp.google.com>
References: <8dd12465-0dc2-340e-8db0-e37719f34efc@ramsayjones.plus.com>
 <20171011223433.GA6079@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011223433.GA6079@dinwoodie.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Adam Dinwoodie wrote:

> t0021.15 has PERL as a requirement, and I see semi-regular failures from
> Git tests that are Perl-based in one way or another (git-svn tests are
> the most common problems).  I've not spotted t0021 failing in that way,
> but it sounds like the same class of problem.
>
> I dig into these failures when I see them, mostly by running the script
> a few hundred times until I get the failure again, and they've always
> been Perl itself segfaulting.  That points to the problem being in
> Cygwin's Perl package rather than Git, and it's very unlikely to be
> anything that's got worse in v2.15.0.

That reminds me of https://bugs.debian.org/868738, which I tracked down
to perl's "die" helper using errno to determine the exit status instead
of deterministically using 128.  I wasn't able to track it down further
than that.

t/t0021/rot13-filter.pl doesn't have any similar suspect constructs, but
thought I should mention it anyway.

Thanks,
Jonathan
