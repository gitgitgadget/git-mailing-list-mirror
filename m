Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971AF207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980003AbdDYCRp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:17:45 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33744 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979955AbdDYCRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:17:37 -0400
Received: by mail-qk0-f179.google.com with SMTP id h123so48225113qke.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JCFG9QaUnD6I4+Jcx0V6UtHKTZxGD20z4/HlybzSx5A=;
        b=oCdVUiI48BWrDT3quFsnctNogu7csTrk9DjB1IzDtX6MBMmPACptnLNEf6JeRTboy+
         JBJc9TiZvH1MAgyjqqxhDUAOvYrF0FK0p9Sl5yzRZ9UEJAhk4eURQqGidbrNy/fqJvUG
         5cYQ/QhR2P5uZfp0Z3PeKUfCRa6lEtg27YT/yWFwf89AVjwLBk4mT+4M7cgaeSkWJs53
         HdJYAJ7ugWt9AnoDY4D5oYqXY5QF1j55rFLhcGYLHFTxg+7xkjsFtsggjBhLwPuCSHhW
         XY1AjDCnoUDJozvWuGDuR6yp8461DBaysHWbzP4EP+f3jEXESmW85vfYy7r6okcpKmta
         MQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JCFG9QaUnD6I4+Jcx0V6UtHKTZxGD20z4/HlybzSx5A=;
        b=biQcx1x9IWM3pLZJ5LniykqV/kh/U9XKHuA1/c2tm1Ii2vsFm8G+eJusAJ0XTgVFTZ
         YDOK7/sRgjtepspfHp38+ltyyyETuQC3Cnpi4emdbx9mz4E7gxHCKeh7J3af/M0fFMTN
         sqRYBn01BvcDG2JQ2tR6LDoiu8ysMxtYNu/x/oZQIITNsp8NsYO3AhWs2nm02gBUQlUZ
         S+MEJrV6/HeDjEN5Pwusmz3GClOPtTKh6JIUZKbdqRSimXrgZ8iNhLbtqRUP01jiqdW1
         QOv1IFk7NdSlKRlYpzC/KuhXGSQEYhj5KhvYRz19VrwcQheB1RHeGd9DkZ07MleeT8UP
         wq/A==
X-Gm-Message-State: AN3rC/5sbRftdejGT7oufbyO8NYzLJ/Kj9nyw8+GfHwckN4EPQzOrERc
        lqH642x1Rylfqe6tEbQ1tz2uVWglEQ==
X-Received: by 10.55.72.143 with SMTP id v137mr5267723qka.222.1493086656413;
 Mon, 24 Apr 2017 19:17:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.96.65 with HTTP; Mon, 24 Apr 2017 19:17:35 -0700 (PDT)
In-Reply-To: <ADC645666B1F4ECA92E9082F0565F475@PhilipOakley>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox>
 <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
 <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org> <alpine.DEB.2.20.1704241622510.3480@virtualbox>
 <ADC645666B1F4ECA92E9082F0565F475@PhilipOakley>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 Apr 2017 04:17:35 +0200
Message-ID: <CAP8UFD2pHjoJmMQ7VXX0QGQ6_3-_yXtaAtzNzSsPjAgPVz8Fag@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 6:34 PM, Philip Oakley <philipoakley@iee.org> wrote:
>
> Sorry if I'm bikeshedding here, but it does look like adding an alternate
> 'bisect' strategy may be useful for this style of integration testing.
>
> To me, given the multiplicity of independent branches being brought
> together, it should be possible to do a check on each of the branches
> separately, before the tests along the line of integration . The tests would
> not be a true 'bisection' as they are separate single point tests, but they
> do establish good commits at the tips of those branches.
>
> Thus, for each of the merges in the --first-parent traversal, the option
> could test (in the OS of choice) the *second parent* commit of the merge.
> This sets the known good points. The breakages during the integration then
> become easier to bisect, as it is only looking for the integration of a good
> series into mainline that breaks. [1]

I think what you suggest is very similar in practice as the
--first-parent strategy that we have been suggesting for some years to
add to bisect as a GSoC project:

https://git.github.io/SoC-2017-Ideas/

> In addition, an aside that dscho made earlier about the merge-base of some
> branches relative to Windows may have been missed. The normal bisect process
> assumes that we start from a set of good merge bases.

When a good commit is not an ancestor of the bad commit, we test the
merge bases first and we abort if one of them is not good.

> However, dscho noticed
> that occasionally some series may choose an older point on maint (etc.) that
> itself would _not_ be classed as good when tested on Windows (or on other
> OS's). Those older mergebases can make the classic bisect across all the
> commits in the DAG between here and there a tortuous process, especially if
> the local OS implementation percieves the base points as bad! (which breaks
> expectations).

My understanding of the bisecting problem that Dscho is reporting is
that the process is sometimes buggy or tortuous because bisect is not
smart enough to optimize the testing of the merge bases when there are
a lot of them.

It is not because bisect expects or assumes that some merge bases are
good or bad when in fact they are not.
