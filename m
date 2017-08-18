Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9258208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbdHRWd1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:33:27 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37372 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdHRWd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:33:26 -0400
Received: by mail-pg0-f52.google.com with SMTP id y129so72292469pgy.4
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9G2UGKzZp92jAmsAnIcMbWeEAVlWyQ2ALM5sMn1NXCE=;
        b=Bip5SiKawX/88fNgQp2d+fYsjtsueGTIvr5R+GXYe9dLwBLRlRb9bgtitqwiu08xVS
         8o+vDjX0oSQ6ue/0jaEvMZDi6ELfyORXEG40RNdoCHc+6EFkS4nCBen4q1pLGcaIrVF4
         xEKG7mDO0VO916zXGZ+oh8AwZ1UIeM+3dVRGLtulzuhDBZjkp1+VeXYXrXczLb6aoikw
         rVGW0hp6r0AeklPemb64EXEkRm+O1sO0CIHtyRoPhZKaNEz4pmiKesyafAdU/U3SWTgG
         mLxSacWwK+VK9Ckn48ufK/xkWTh2J7/hyPod6R6LeFrW+KrdFRT//FzO73dh/PMGKVFx
         7Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9G2UGKzZp92jAmsAnIcMbWeEAVlWyQ2ALM5sMn1NXCE=;
        b=pawVPHjfQeEi01AgJHp7fpE3UEL7vc/fIJqCwDlb4tvSjIbZbaacaO58/LZ3+iOTY7
         sk+B9I8fNsks5P8t/mZ4pTDRrZfnn1CA15uM882aGt6vgTdhta7hOWo2d1QdeAirqSjD
         XKtmWGWZuGyiTeeexf6kHFV3fCwa/3ntIb/yijmFzH97489umKVjN62dlnEwUL7B4SOI
         YeFTkiVauJWdEZLUeQ+amYfk3PK7vez2dXV/a4H19pIfiXRe8iVAilKdcTiLi/ecSABY
         ATLqYA9GvDFar/O/mQkDWHTcJt7IBgh214PZ7t8YJD/bx2/gFd/TMZWT9BLxTZB//tHh
         IGXQ==
X-Gm-Message-State: AHYfb5h4Ojw9UvGRrBY1KXS4hq30SmVxvGbMD/SdJRdiCwX74ozgCWoI
        Ed0jgNJ5sylhKA==
X-Received: by 10.99.107.9 with SMTP id g9mr9696992pgc.147.1503095605928;
        Fri, 18 Aug 2017 15:33:25 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:70fd:e2e5:b6ce:5065])
        by smtp.gmail.com with ESMTPSA id q89sm12847545pfd.156.2017.08.18.15.33.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:33:25 -0700 (PDT)
Date:   Fri, 18 Aug 2017 15:33:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, git-for-windows@googlegroups.com
Subject: Re: Revision resolution for remote-helpers?
Message-ID: <20170818223323.GO13924@aiede.mtv.corp.google.com>
References: <20170818064208.plkppke7efpucuwm@glandium.org>
 <20170818220637.GN13924@aiede.mtv.corp.google.com>
 <20170818221754.3rbh35aewj5xnu4z@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818221754.3rbh35aewj5xnu4z@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey wrote[1]:
> On Fri, Aug 18, 2017 at 03:06:37PM -0700, Jonathan Nieder wrote:
>> Mike Hommey wrote:

>>> The reason for the <helper>:: prefix is that it matches the <helper>::
>>> prefix used for remote helpers.
>>>
>>> Now, there are a few caveats:
[...]
>>> - msys likes to completely fuck up command lines when they contain ::.
>>>   For remote helpers, the alternative that works is
>>>   <helper>://<host>/etc.
>>
>> Hm --- is there a bug already open about this (e.g. in the Git for
>> Windows project or in msys) where I can read more?
>
> It's entirely an msys problem. Msys has weird rules to translate between
> unix paths and windows paths on the command line, and botches everything
> as a consequence. That's by "design".
>
> http://www.mingw.org/wiki/Posix_path_conversion
>
> (Particularly, see the last two entries)
>
> That only happens when calling native Windows programs from a msys
> shell.

Cc-ing the Git for Windows mailing list as an FYI.

I have faint memories that some developers on that project have had to
delve deep into Msys path modification rules.  It's possible they can
give us advice (e.g. about <helper>::<url> having been a bad choice of
syntax in the first place :)).

Thanks,
Jonathan

[1] https://public-inbox.org/git/20170818221754.3rbh35aewj5xnu4z@glandium.org/
