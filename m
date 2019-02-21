Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA53D1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 04:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfBUEqn (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 23:46:43 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33452 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfBUEqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 23:46:43 -0500
Received: by mail-it1-f194.google.com with SMTP id g137so8324014ita.0
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 20:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyulwaduEAOl/06ajhhjM3lVylq7Tnbie9QONIVkkpk=;
        b=wDf0mYw7Qde7l4i3AYgmzukhaDag0tUtZqtVvmqsUHoPhpIYChddJdQQHpMZp6vQiU
         KyuWwqT/zdvZI+rt7qRmZpCBon6R7On3d8YgvByV+MMXPsB2HUZZLekhOIfPZFM4xxwH
         ypwV8vQE19MRzfrlWrBL4ElbE6+ZFstCOiBDgAuNdQ2nS8QA4x7u8QagKP7uWc8vTntw
         uSWY2XEiXBc5XihAYPwZ3p3CwaR2Ptnls7KkRAmh5xthJfN5iu6Wp6v6Op6m73NGoYem
         Bb9dnp4OcYp8Fl5DAZSkM4X995ip/OWcJ/6gQtp2VK1IQk8HKPU1FKrWwtRV1e/UKDhs
         Htig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyulwaduEAOl/06ajhhjM3lVylq7Tnbie9QONIVkkpk=;
        b=VHWyridOPTdIUBRQk3WKC80PWV3O52kHg7pmJuAAY6yDLzNKKwWW70/8FO2FaYm5Ks
         wmHQQcoA6VpDr/nlNib+Xd42Srwwn2HuKZ/mbbv+J6Nbo+0/jGk/SGI4+KhgZbLW/8ym
         gM5YB8ervJZppLpka34jszmO+SvQ+TP/veDQ7F0wFObrfhzB3Wh8uRGdORpe4xNP857s
         6EYW5GcprwC8YQNTi+yWwihZxq/b1VMPDFxtT/LKDSauK+BPioxBvRLwXq3ziD1cUqez
         JgsJ21ynUlX2z6mq2GQPgPyxjAyqYLI89DO6Fjx7Ny68tP3HEtY7OT+0jMWfvvAQN/0h
         tE8Q==
X-Gm-Message-State: AHQUAuYZh8I2F6MraFeLcLz1NZSS97U3u+fpO8vtyLmZzbSc37U7yTug
        LfzUUM3kr5NIcsPElnS8Ym5v1/t+jaoKUwbVoi0pUQ==
X-Google-Smtp-Source: AHgI3Ibn5D+gQK/KrLfrPcQR0LWwMQ+gcJ6wo215wgpAZa6Nk4syEnznzOtf7191L0AAFs4MljiUREwkzsfeWD6M1vo=
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr7020340ite.72.1550724401946;
 Wed, 20 Feb 2019 20:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-3-matheus.bernardino@usp.br> <20190216143824.GJ6085@hank.intra.tgummerer.com>
 <CAHd-oW60a+zz9J+u0HiRuTy-FKYN4s95fCcR3mgJz0hUokhTCQ@mail.gmail.com>
 <20190218233541.GK6085@hank.intra.tgummerer.com> <CAHd-oW6m6JSgxwdE6U5vBw=DcPigK+P8eODoie0_Mag3Lg_eYw@mail.gmail.com>
 <20190219234506.GL6085@hank.intra.tgummerer.com>
In-Reply-To: <20190219234506.GL6085@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 21 Feb 2019 01:46:30 -0300
Message-ID: <CAHd-oW6VPrHMo1QjAXn6G8P_gmJOQ91LVO+UDK1a8T7uhuM9uQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir traversal
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, I think I'm almost there and I should be able to send a v2 on the
weekend. But again, a few questions arose while I'm coding v2. Please,
see inline.

On Tue, Feb 19, 2019 at 8:45 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/19, Matheus Tavares Bernardino wrote:
> > Ok, I agree. I noticed copy_or_link_directory only skips hidden
> > directories, not hidden files. And I couldn't think why we would want
> > to skip one but not the other... Could that be unintentional? I mean,
> > maybe the idea was to skip just "." and ".."? If that is the case, I
> > don't even need to make an if check at copy_or_link_directory, since
> > dir-iterator already skips "." and "..". What do you think about that?

[...]

> I feel like you are probably right in that it could be unintentional,
> and I don't think anyone should be messing with the objects
> directory.  However that is no guarantee that changing this wouldn't
> break *something*.
>
> For the purpose of this change I would try to keep the same behaviour
> as we currently have where possible, to not increase the scope too
> much.
>

I understand your point, but to make copy_or_link_directory() skip
just hidden directories using dir-iterator seems, now, a little
tricker than I though before. The "if (iter->basename[0] != '.')"
statement in the patch I sent for v1 only skips the hidden directories
creation, but it does not avoid the attempt to copy the hidden
directory contents (which would obviously fail). If we were to do
that, we would need to check every directory in the relative path
string of each iteration entry looking for a hidden directory. That
seems a little too much, IMHO. Because of that and the intuition that
skipping over hidden dirs was an unintentional operation, I think we
could modify copy_or_link_directory() to skip '.' and '..', only.
Also, hidden dirs/files are not expected to be at .git/objects anyway,
are they?

And to have copy_or_link_directory()'s behaviour changed as little as
possible, I could add the option to not follow hidden paths (dirs and
regular files) at dir-iterator.c and use it at
copy_or_link_directory() (now that I'm adding the 'pedantic' option,
this won't be so difficult, anyway). Would these suggestions be a good
plan?

Thanks,
Matheus Tavares
