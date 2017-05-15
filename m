Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B7C201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935346AbdEOTEU (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:04:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35866 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934078AbdEOTET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:04:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so13286291pge.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rGGLM0aq0IeNX5ByC+EJRQ/yMJiYaTmxj72ksZqRyAQ=;
        b=tnqV65ImDHQvfmhM06xBYPxQ2Ot9VxFbNqVmI1ScmihXUEW8H4c1lvjxRIhyZG0iRJ
         SvCJsCEF56hy6OkQNufZAJuWllecuVkq9E1qU4Nl/h0Mloo2JwX5sDtz8bEmNickw2Nl
         FqHim7Wvngd8uSFIYnvIunYrEPklfbx2+jnTCcXsfH5mpW2e/bH52qExoQR02GfJF0Ex
         te98VSRsqGYojWiU5ikbygPeb5+q/n4pGTP3tlUUet3ZLn9fPpYBOA9DUwGmWN8DkVf9
         SFn1xkBbBbc1wcvEG6wrsdBLfqfrMSxyTLoKmhrubL/PYI/kLGALzi/MsdzwD1Zvqx9t
         FepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rGGLM0aq0IeNX5ByC+EJRQ/yMJiYaTmxj72ksZqRyAQ=;
        b=D9BbEJCEqvwGl+1KUzL2Ey2hqpd1hVdrl+jVOciKtVgEUSRJpQY2dkLdkYariLzIYx
         YyMNTWV5OzPHI17vuIfr18RU6lIra519I6Q2dYEuUi0cdQHJWF2mkKhWMrUuGNn45BG+
         jc7E0MtUQ3OvJurSCgGcGDwIuXXBgkuKtKJ2pedV/ltwhjMhhjCsvpkOChX0d0SzICh2
         yvWeF1tReosCy24I/nWS7guIlK1TqULlDwjCij5Wt468vggJ7a7F1HYTTwlsd0Ba8Y0I
         2qOIs5XeZKpm8ZAt+70WmWojWL+YHAbGwshFjDy5O7sUGVSHIA/cQKLT6/0DBNweC+b9
         MzHw==
X-Gm-Message-State: AODbwcBVt9vxEXOea5kqtFzDLH3pLQBp5gOUbDUFiRxGHKgT19xWgdPT
        ujGXeKhxIEJ24w==
X-Received: by 10.99.103.7 with SMTP id b7mr7948988pgc.2.1494875058659;
        Mon, 15 May 2017 12:04:18 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:6582:4c54:354a:7413])
        by smtp.gmail.com with ESMTPSA id l198sm18191556pga.50.2017.05.15.12.04.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:04:18 -0700 (PDT)
Date:   Mon, 15 May 2017 12:04:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style
 options & config
Message-ID: <20170515190415.GM27400@aiede.svl.corp.google.com>
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
 <20170512234414.GF27400@aiede.svl.corp.google.com>
 <alpine.DEB.2.21.1.1705132037050.146734@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705132037050.146734@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Fri, 12 May 2017, Jonathan Nieder wrote:

>> Would something like
>>
>> 	test PIPE_IN_FILENAME '
>> 		>"a|b" &&
>> 		test -f "a|b"
>> 	'
>>
>> work?
[...]
> Back to the subject: The MSYS2 emulation layer inherits a neat trick from
> Cygwin, where it *can* create file names containing pipe symbols. They
> will be quietly mapped into a private UTF-8 page, and when Cygwin or MSYS2
> read the file back, the file name maps from this page back to ASCII
> transparently.
>
> That strategy is all good and dandy, as long as you stay within the POSIX
> emulation layer.
>
> Git for Windows avoids the POSIX emulation layer as much as possible, for
> speed, and also for robustness.
>
> Which means that Git does *not* map the file names using said private
> UTF-8 code page. And therefore, your test would succeed (because the shell
> script would stay within the POSIX emulation layer, which creates that
> file using above-mentioned strategy), but Git (being a regular Win32
> program) *still* would fail to create said file.

Wow.  Thanks for a clear explaination.

I'll be keeping a copy of this message handy for the next time I'm
confused about filename handling in the testsuite on Windows.

Sincerely,
Jonathan
