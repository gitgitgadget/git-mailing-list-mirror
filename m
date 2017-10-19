Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52931202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 19:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753451AbdJSTzz (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:55:55 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:46686 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbdJSTzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:55:51 -0400
Received: by mail-qt0-f182.google.com with SMTP id 1so15959989qtn.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uJFS51eiqf9NjWYi0koaI+ltjQHGFVtca1tstMIwsGE=;
        b=XmzKNYIg+Whkkbb3EmhPPWgmd+nsyLIj5huQFLaUg5bgmUY7ckU+JTsUuK0SNjnR3K
         wqslgysqRhIcx37v7HCufJSnrudx5/n/n8Q+mOogm97nkLdjc889nkBfXjQ79/0pSBtm
         +k7Irl5OrdD5jCY/N8EOUoryXj2+sUgOb8BL2DLbzv4E1N7fHaQHWIhwgZW53YvHxrJO
         2CYlOlnYN1PJbkTGY346t6lRjh/In68UoEFGS3XhXwmOKB+g59HhRS8I73vL+91EdX7I
         3mBP3M9ygJ759iXpvpQooVgIhftTn31NybgSML54ZYXQBrJ7ml9YW1h/k7kn2la8Zdx2
         2OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uJFS51eiqf9NjWYi0koaI+ltjQHGFVtca1tstMIwsGE=;
        b=YSiTiGEQxz7FieyDe48Oak7eNtq7s4dj2leM89JP6LYFgp0Wzlrvs+6lo4CRVBsdGR
         sILhEYVPfXcFeJIo30MARqFqgdxX1N6PIz5oE77lwq1iiD1i+1C+jTSDVRz6F1LS4s19
         1/MWjsAx884sogViaYgwX0oAVBFp6eXsg7CYHDLC0TU5S5vKBBhmj4TiCHfvitkVMccq
         JXp8gYYiRTPw+RZ3dPsUgOC4Lb4mFsPxcCM4NACPKGAgT1oUAZE9u1C0vpoY7dHzZChD
         44fikLxZQaXUGo6tTnKdnL6FXH/msT5uxhtU1UPPhTrhRRavpLTHNJxPvcI15we1ozY7
         0VgQ==
X-Gm-Message-State: AMCzsaWgxIRPwSh5BwgsmVcmDLD/wOmk9TLELejMyZHa/Nd5WEE2Mr4k
        Rsw6dDaTNpOBD78k4ARuOUogQm81iZcku9+WgtKZVA==
X-Google-Smtp-Source: ABhQp+RLoSbAez/WJraBn2maaQvOkMIsRHytpLvuBETsL1am1maDpiMIPRxDKaI2htoXEOGlkW36YCxMEP1H/nWnp3E=
X-Received: by 10.237.34.201 with SMTP id q9mr3842866qtc.198.1508442950124;
 Thu, 19 Oct 2017 12:55:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 12:55:49 -0700 (PDT)
In-Reply-To: <20171019054246.jii62lq2druohbpo@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com> <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
 <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net> <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
 <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net> <xmqqzi8niu1r.fsf@gitster.mtv.corp.google.com>
 <20171019054246.jii62lq2druohbpo@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 12:55:49 -0700
Message-ID: <CAGZ79kb7pz6sWG_hMJLt3TmPNmDqWB1Jy1xNO73-P6iMPM-BYg@mail.gmail.com>
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 10:42 PM, Jeff King <peff@peff.net> wrote:

>
> So I think the right fix is this:
>
[...]
>
> It's late here, so I'll wait for comments from Stefan and then try to
> wrap it up with a commit message and test tomorrow.
>
> -Peff

I agree that this is better and looks correct.
Thanks for offering to send a patch. I'd be happy to review it.

Thanks,
Stefan
