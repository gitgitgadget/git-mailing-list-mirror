Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A8C207B3
	for <e@80x24.org>; Sat,  6 May 2017 00:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdEFAKG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 20:10:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34018 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdEFAKF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 20:10:05 -0400
Received: by mail-pg0-f67.google.com with SMTP id u187so2505538pgb.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OybZR2Y4yOxaUY0e5JcF4zoaawUboXWcpdJd4jSq5Bg=;
        b=K1akeav3CMA7P4BrM/aMwGS1qE+Tl1448EtVXVLKWS2Fqt+yRmBQ7KY1qUJvYX+1my
         fUTaS7tIHXMZiUW2/czonpJECn+CotKkmMzkuIzBZ9RXh5JkWkXijOVNfWaCZP9afdot
         WBpr/Bl++PiVcqRhl7i9UcHGBcaYyoqoaN9d0e1GmtMx8rTNCugBSvvMf4btnsiVtiV4
         cf+B1fVPIRKrrnZVa1Zl//GAXsBDpVVwG/z5YciGE4S4KHYUM1muAvP8aj44neIVsaV6
         K3tjBUOmqceD67u+cgPJPWA+R+2ic1fychhRnP9uylgnEDUaEZCaw5HJ4vwZL+swGlri
         sOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OybZR2Y4yOxaUY0e5JcF4zoaawUboXWcpdJd4jSq5Bg=;
        b=ab3IcyTdHfdfzoV4pKqEPts6jW6Kx0TZ2ugIDH1ICIOUV58ufu+kTxVfe9LvDD+nNx
         9/eeEF55Sia5uZGs0Td+juYal5xJSwEluAXrDfWESBDcNnDZDQcZfYImd2/i6TXTGL+P
         fwnoIHrWsPU4TebSNAtOXZ+QCPce39XtmqnKKe10gU7XrTDkMp1oCnEqyfA5DdrDVOlN
         lm0YvFvCYN5CNcXohKFFWv8JcB5oKaTdBr0TQYtGLN1QstNeFwgm6Oc8mi0rNiQvOK6v
         cE9bEoj54A2wQ8wLTdGrUDemK3hZZoA3T2lGp6uoV3MeQVeL7QCAHUa6DTItJqBOapqq
         IV0g==
X-Gm-Message-State: AN3rC/4a5U6V6st7XPksV2cFbsYByQqksEnuGeoIvnbYoPAu1V2P1ke/
        rblsaW/JXgBpoQ==
X-Received: by 10.98.61.150 with SMTP id x22mr20085107pfj.170.1494029405084;
        Fri, 05 May 2017 17:10:05 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:5d98:2d3c:6099:849])
        by smtp.gmail.com with ESMTPSA id 202sm5483905pge.12.2017.05.05.17.10.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 17:10:04 -0700 (PDT)
Date:   Fri, 5 May 2017 17:10:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2/3] receive-pack: verify push options in cert
Message-ID: <20170506001002.GK28740@aiede.svl.corp.google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
 <01e098de2da2e5f0b341ab6d967d032d840c365e.1494027001.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e098de2da2e5f0b341ab6d967d032d840c365e.1494027001.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> In commit f6a4e61 ("push: accept push options", 2016-07-14), send-pack
> was taught to include push options both within the signed cert (if the
> push is a signed push) and outside the signed cert; however,
> receive-pack ignores push options within the cert, only handling push
> options outside the cert.

Yikes.  Thanks for fixing it.

[...]
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -106,6 +106,16 @@ the following environment variables:
>  	Also read about `receive.certNonceSlop` variable in
>  	linkgit:git-config[1].
>  
> +`GIT_PUSH_CERT_OPTION_STATUS`::
> +`BAD`;;
> +	For backwards compatibility reasons, when accepting a signed
> +	push, receive-pack requires that push options be written both
> +	inside and outside the certificate. ("git push" does this
> +	automatically.) `BAD` is returned if they are inconsistent.

In this manual page the reader doesn't need to know it's for backword
compatibility.  It is simply what the protocol requires.

The protocol doc and especially the commit message are better places
to talk about rationale (as you already are doing nicely in patch 3).

> +`OK`;;
> +	The push options inside and outside the certificate are
> +	consistent.

Hm.  I would have thought it would be simpler to simply reject the
push without invoking hooks in the BAD case.  But
GIT_PUSH_CERT_NONCE_STATUS provides precedent for this, forcing me to
think longer.

Is the idea that invoking the hook despite a bad client is a way to
provide an opportunity to audit log the error?

... okay, I've thought longer.  I think this is a different kind of
error than a bad nonce: for example, a bad nonce might be the result
of a misconfiguration that makes the client get the wrong nonce or a
sign of a caller trying to brute-force a stable nonce.  For
comparison, this error is a more simple protocol violation, like a
malformed pkt-line.

When we see a malformed pkt-line, we error out and do not invoke the
pre-receive hook.  For this error I think we should behave the same
way: show an error to the user and abort the connection, without
invoking hooks.

[...]
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -124,6 +124,21 @@ test_expect_success GPG 'signed push sends push certificate' '
>  	test_cmp expect dst/push-cert-status
>  '
>  
> +test_expect_success GPG 'signed push reports push option status in receive hook' '

Is there a straightforward way to test the error case?  (If there
isn't, I can live with that --- it would just be nice to have a test
that the behavior introduced here is preserved.)

Thanks and hope that helps,
Jonathan
