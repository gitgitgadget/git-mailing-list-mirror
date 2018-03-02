Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345051F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946327AbeCBRsW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:48:22 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:55642 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946197AbeCBRsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:48:21 -0500
Received: by mail-wm0-f50.google.com with SMTP id q83so4660711wme.5
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/lUv3NckWiFHq+fhVKfasN0asZ9tCUjQ3iiDXLczztM=;
        b=Aj3r7Uey1eMPXVK8rZDXxAc2RF19Efdaf0XL6EblDAtfX9psMfCYVgL5dtmMYjkRUh
         zU6h7DepcIZKoz4M3TYMnnRfju1GEV89N/10AcuSHtbhrx7tUX/6cFS2gEUXDd8CyeZM
         oga1v2E1uEQoUeryyJDGpeGYL2zfkn+wgaX9ZLAMQCoxUuffczP4OU+WhF8NuLKmPC88
         fSDthcj+70xflnNDfBTyeaVlbSeumvJQQtPw8t5t97Mpyo0P6vZld/C4H22hUfKK6nVH
         QieEXkL14Vu21FpCoBIlgPDHuPg8oIJ0tj2M4GI4dCMvv/tavHNhd8sKtW8dcdeIEhMu
         rfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/lUv3NckWiFHq+fhVKfasN0asZ9tCUjQ3iiDXLczztM=;
        b=dL1cLYZEiqrJ6HzZ+xSZMcvoafCaY1WYaXq8gt2x3FEzOrnUnoxT/ArrYFyClcwGLx
         6ZuV6evyVFwWf7MhY5YIuGSTwEQqT0hHMJccNaLNiVGG+h37oDz5PPvgXK9D/T0eHkp5
         vGYgVuFjqGu8Busw93z3wjJRQuopZz15bnHk5sZ6bXBM7Xj95XHFxiPLYAFsDpT3aEzd
         n0mru95Riz+0UJ3Qn/VNyS9S3NkQhJK+da4Zn0OzfwlcKiMMlkDNPYJ3r7AZSMAHb7ye
         gNPdmsxjzUVGH94c8iftB+LDUvGIsK+ce2e42IymPDN5iewjlKRE11OoG3tR7pzsq7b/
         z9Tw==
X-Gm-Message-State: AElRT7E8ezM/jnBQHkYSGslJYgHwJe/2N6u5HQel50NEvGPwAWQteONN
        YhK6klqGb7R/HPpEcmWgxEo=
X-Google-Smtp-Source: AG47ELseW4iDiZ4u8CdKo7OqNuhqbEtzTzc/jEvKnIpZiJaKOsLwiDSdVvk/rf4Tq+gOWobRggw9WQ==
X-Received: by 10.28.92.17 with SMTP id q17mr2058622wmb.97.1520012899772;
        Fri, 02 Mar 2018 09:48:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w195sm1556004wmw.9.2018.03.02.09.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 09:48:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
        <20180302104232.GA11074@sigill.intra.peff.net>
Date:   Fri, 02 Mar 2018 09:48:18 -0800
In-Reply-To: <20180302104232.GA11074@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 2 Mar 2018 05:42:32 -0500")
Message-ID: <xmqqefl2cqsd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Unfortunately, I don't think there's an easy way to do what you want
> (show word-diffs but apply the full diff).

The current "word-diff" discards the information on where the lines
end, and it is pretty much hopeless/useless in the context of "add
-p".  It would be a good addition to revamp it so that it keeps the
original lines in pre/post images but only colors/highlights the
byte ranges in such a way that (1) on a pre-image line, paint only
the byte range that do not appear in the post-image, and (2) on a
post-image line, paint only the byte range that do not appear in the
pre-image.  

E.g. Given these two

    diff --git a/1 b/2
    index aa49234b68..1cd9f6b5fd 100644
    --- a/1
    +++ b/2
    @@ -1,2 +1 @@
    -a b c e
    -f g i j
    +a b d f g h

the current word-diff would give (I cannot do colors here, so I'll
upcase the colored letters):

    @@ -1,2 +1 @@
    a b C ED f g I JH

as the output, but if we produced

    @@ -1,2 +1 @@
    -a b C E
    -f g I J
    +a b D f g H

instead, then colored "add -p" would become easier to see.

And that would be useful outside the context of "add -p", which is a
huge plus.

