Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B478F1F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 14:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbeL1Of1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 09:35:27 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40994 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeL1Of1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 09:35:27 -0500
Received: by mail-wr1-f45.google.com with SMTP id x10so21061294wrs.8
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Rb9Y/98KeEQtaP+eIHHdMF4bQnZr+HBXOsEAj1CBC0U=;
        b=hYY6CYOrYyk140OERujFAwNTPpoGEOpxVaBm7MxmRd30fLPqYIwibjVZkDzqd53l5y
         +lxoFJJEOJjdz+Iu2s0D21adJDM1VaU/skY6LSPsQqcaHq17nhnVFzctW1hkoDlaJWwo
         FN8IGtueTv7vpX9uKZn6AeWDrvN9O80JrSFgUjnWZeaJgONERyLjlH7EkL3BmLnGAnOU
         9WlU9zsbLnmdd9u/zCWpUadLaxYKY0sISbvatge1DZv6bEWYB8R5Oixq06ns2AcEOvCu
         GshbyKEYXkM6aoZkuwqestTiPkSzgxQvxbAO4QFJQcFZQ94huDHDSY3wSzJFXzbEeauA
         M0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rb9Y/98KeEQtaP+eIHHdMF4bQnZr+HBXOsEAj1CBC0U=;
        b=a9iN1u/LQg90K7HDv51w5hPxlBCntEc+rvFg1kSo71AREptrBXXq5bDEjfw73zcqb0
         iekuNv5wdYZi/Dtf9PpGNhl/zN4Uc6636ioVNYxPDebpEMPg3jSeosLFbX5iXY1Zjq53
         H9drYc9Ao92ba1mN8vw3gOqBVm4o/0i7sm/UToIs+9i9hWK0yWEp4J2uPjmip29J9OJS
         tNmZbFHAcyVY0rX5xF1ae5fD4oARhpPQkGcRgFSPcBUVwqNu43N83hDu5/aX3uniGkkW
         RqWIQPmb/pkWmZ8nCifETzNyduEJArLm4DWOoe0NE55Q4RNGCyd0MK+PDaP8iuXuAxEg
         WmNw==
X-Gm-Message-State: AJcUukdToFsv6x8G1A+7FPBe97GNO2+C6lkhF3/Y6YngUiRYHkuUUEkM
        XKIK0r8HRM8hHtYLDBWlKYSG0SAn
X-Google-Smtp-Source: ALg8bN4F16N9tFD3owLVr8a3628CBUWY20QGT+3HviVUz3HSVcnBGwPs0oU01RJJl8rd9nJo8Cic8Q==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr26132610wrm.115.1546007724938;
        Fri, 28 Dec 2018 06:35:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c12sm28859340wrs.82.2018.12.28.06.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 06:35:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
Subject: Re: RFE: version-controlled merge rules
References: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com>
        <20181227235526.GF146609@google.com>
Date:   Fri, 28 Dec 2018 06:35:23 -0800
In-Reply-To: <20181227235526.GF146609@google.com> (Jonathan Nieder's message
        of "Thu, 27 Dec 2018 15:55:26 -0800")
Message-ID: <xmqqo995pvmc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The main issue I see is that this would make it a little *too* easy to
> run arbitrary code on the user's machine.  Build systems often already
> lead to that, but users are more familiar with the risks for build
> than for version control.
>
> See [1] for some related discussion.
>
> That said, using the include.path feature (see git-config(1)), it's
> possible to do something similar:
>
> 	[include]
> 		path = ../.gitconfig
>
> Thanks and hope that helps,

The issue the arrangement to specify what kind of files they are in
the attribute system and to specify what exact commands to be run in
the configuration addresses is twofold.  The security issue is one
and poking a hole with include.path mechanism is probably OK as
there is end-user consent, but I tend to agree that a similar risk
already exists by a project shipping Makefile et al.

There is the other side of the issue.

The arrangement allows project not to be monoculture by leaving the
exact command sequence to use on the kind of files (specified by the
project with the attribute system) up to the end-user in their
configuration.  While Peter may feel that sort piped to head may be
available on all the reasonable UNIX systems, his merge driver would
not work on other platforms.  There already is a similar reliance of
monoculture by a project shipping Makefile et al, which is an
interesting parallel.
