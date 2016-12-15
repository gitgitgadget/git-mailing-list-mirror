Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 248201FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 07:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757432AbcLOH3X (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 02:29:23 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34484 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbcLOH3W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 02:29:22 -0500
Received: by mail-io0-f174.google.com with SMTP id p42so62089424ioo.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 23:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6MjRY4QjZ+dhBMHLXRilUOVdsc51wYXQnA1IEeQaN6E=;
        b=s25yXdVND5dU5j4LN8WxmCgNKI5JCJ4lX3cN5slqd5dRk0eZuFmHaxhcxujJ3+kIIp
         bevyJ6cgdo90yauNkG7v2Fw7m4n3a+ouieE/nn+6iXnuON0K3V1s6NCTevfL1oJvjSqu
         N81px7aqfvUI0e6KB44uOAFED2VfK/vR7Bv+YZXybGpPq4c8A4Du3oCVoqMKi7n48ET7
         BgYV6nwPLOpiyuyEOkUk1vgm36iPSH/6hHMR3fkRrYv9kKf2eIIXaYWZw5KlXkZ9NRLH
         JxERh5MLY9E3sRxN0NB5AzKnebT3L187huMMD+l7vx6yauFDHaGk18UecUi9br6a1pBo
         n4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6MjRY4QjZ+dhBMHLXRilUOVdsc51wYXQnA1IEeQaN6E=;
        b=dE0yf2JWJCU+FzrtxJiLsqbR/dMFXKDCL3YsK4olYsBWp3zi0xw19VcblVHzjraQqj
         4q1Er72CcDn5hy2k+26sldjBJ2zVLQHzy99dEStcOatzf6sE7zlN+uV5JsGLXqFL98bK
         LUwZjGrrE0vBKShOzL2JbOgNbkiVUPEYASTovJst7mKuqzGVApS9I03RZ2h4Z02UQZzD
         k6e4cIX5te//joWaf0/iH4ZPSU6GQjn3gHKrS7W7IYsgPp01E7QZV7lyoGNtZu3+r1dK
         VoDvRbq/BFNg4vPdcnCMkoEvW7xKExwEKJSsZrHc7q8WewB6FcvK7i891iMNNt7nZvpm
         v5TQ==
X-Gm-Message-State: AKaTC01PsQXv+IOP3OXUvisXprf0gjkB21lE34GGudV/cm46H/DC90rHj580Xd3sVMnZZYAK9Y2VXu+WnWmM2A==
X-Received: by 10.107.200.204 with SMTP id y195mr1115444iof.73.1481786961710;
 Wed, 14 Dec 2016 23:29:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.0.93 with HTTP; Wed, 14 Dec 2016 23:29:21 -0800 (PST)
In-Reply-To: <xmqqk2b2xu81.fsf@gitster.mtv.corp.google.com>
References: <20161213084859.13426-1-judge.packham@gmail.com>
 <20161214083757.26412-1-judge.packham@gmail.com> <xmqqk2b2xu81.fsf@gitster.mtv.corp.google.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Thu, 15 Dec 2016 20:29:21 +1300
Message-ID: <CAFOYHZD_mFMvggq4pedjGCz332i1-VcRKxu30iMzURfB3Mu8Vg@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] merge: Add '--continue' option as a synonym for
 'git commit'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT <git@vger.kernel.org>, Markus Hitter <mah@jump-ing.de>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 7:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The last one 3/3 is a nice touch that makes sure that we do not
> forget what we discovered during the discussion.  Very much
> appreciated.
>
> Will queue.  Thanks.

Did you want me to send a v4 to mark the strings for translation or
will you apply a fixup your end?
