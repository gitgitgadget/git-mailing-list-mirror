Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67695201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 13:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbdKLN2C (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 08:28:02 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:53874 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdKLN2B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 08:28:01 -0500
Received: by mail-pg0-f50.google.com with SMTP id s2so10756215pge.10
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 05:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=ckFu0dSeUjnBDLWozU98nFnq7i1ez6AcBqvr4PfrgkI=;
        b=gKmnuBeT8OsmzB4NRgqLA04edab1N0AQhR+fQeAS354KujJHK7777MKF8BH6Ovh//R
         vfHVcHfjv1Mz6q5OoWSUAPXghHxo5/Qq5zciiKaYdLIkIs/r05RaDV97WWgmmdsdvnJ9
         fcOHqZuw62KFUJ5gZijq6YvidlM5gcPK//PokJCNFFEDNCfOCCKc5y41L1ZeG49ClrCX
         3x7FkcoRPvUBkSeunEX5v9vpCuyF81SqhQ2F3JYiXvy4Rv+7Qkl4bSUEW6wRGS4QwPZa
         c+LxLS5gTmAAB2zY0qkyp5ZusAgk6WCgb0k/el61C/C4u3XoQqh3Wgh4+d0jTyFWZj+I
         CmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=ckFu0dSeUjnBDLWozU98nFnq7i1ez6AcBqvr4PfrgkI=;
        b=ihoMVDyF1ONs7RYF707oFSmC5xk9EIayOBeqdOG8xFc4rbh/x+MPNnvgGvfNRju1G9
         d3ftsgOdObEasvPw9Xlq47Vdz7uVdlgRQuIzg1Ia0yTxIoopA20wqpZmxQ08oAhzCGyT
         i6t5AjHCJcI9zii0/qJaSq2EkTHZ7m+jVLXMLCmgJrVJseJWtrIcLGr+n8/4h1PrRAWS
         tvSPA0fS+sH9g0Ht3RgBkh0/syxpg/WwUYEOSfsqHsgX0n1qj2iCJuy+l9kCzNGLfH+F
         wkW8wEKKH/6UVlmUknaYLJj8hAoc86/XqbUhtqAv4wkzBHX2hAJNbT35Q/DOX9QADwqQ
         S17Q==
X-Gm-Message-State: AJaThX7qjXuL7sUROh30K1vOV+1nift2jBtXxtPz2S9cPEHa1kdWAhW4
        UdXo1SY9ZdlOchlm51CFhmg=
X-Google-Smtp-Source: AGs4zMarCC/1wf2OD/CPPQ6zFBTvbEQd5NcN+HFkHifQrOiNZxVDMo+ilhYQYp6H/LThnmDMShVMTA==
X-Received: by 10.99.120.5 with SMTP id t5mr5807902pgc.138.1510493280524;
        Sun, 12 Nov 2017 05:28:00 -0800 (PST)
Received: from unique-pc ([117.246.57.0])
        by smtp.gmail.com with ESMTPSA id 19sm29455530pfj.154.2017.11.12.05.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 05:27:59 -0800 (PST)
Message-ID: <1510493270.2683.6.camel@gmail.com>
Subject: Re: [RFC PATCH v3 2/4] branch: re-order function arguments to
 group related arguments
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqbmkgjh32.fsf@gitster.mtv.corp.google.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
         <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
         <20171102065407.25404-3-kaartic.sivaraam@gmail.com>
         <xmqqbmkgjh32.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 12 Nov 2017 18:57:50 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-11-06 at 11:06 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> > From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> > 
> > The ad-hoc patches to add new arguments to a function when needed
> > resulted in the related arguments not being close to each other.
> > This misleads the person reading the code to believe that there isn't
> > much relation between those arguments while it's not the case.
> 
> I do not get what this wants to say.  "I am sending this ad-hoc
> patch that scrambles the order of parameters for no real reason" is
> certainly not how you are selling this step.
> 
> > So, re-order the arguments to keep the related arguments close to each
> > other.
> 
> This sentence (without "So,", obviously, because I do not get the
> previous paragraph) I do understand and agree with as a goal.
> 

I've tried to improve it, does the following paragraph sound clear
enough?

    branch: group related arguments of create_branch()
        
    New arguments were added to create_branch() whenever the need
    arised and they were added to tail of the argument list. This
    resulted in the related arguments not being close to each other.
    This misleads the person reading the code to believe that
    there isn't much relation between those arguments while it is
    not the case.
        
    So, re-order the arguments to keep the related arguments close
    to each other.


> I think the only two things that should be kept together are "force"
> and "clobber_head_ok" because the previous 1/4 changed the meaning
> of "clobber_head" to "it is OK if I am renaming the currently
> checked-out branch", i.e. closer to what "force" means.
> 
> I certainly would not mind the order used in the result of this
> patch (in other words, if somebody posted a patch to add
> create_branch() function to the codebase that lacked it, with its
> parameters listed in the order this patch uses, I wouldn't
> complain), but it would have equally been OK if "reflog" and "force"
> were swapped without making any other change this patch makes.
> 

Makes sense. The unwanted shuffling was a consequence of my attempt to
see if the signature of the function did change when the position of
the 'enum' was changed. It seems there isn't change in its signature as
it is possible to use integers for enums and vice versa due to liberal
checking for misuses.

I've changed the signature back to keep alone "force" and
"clobber_head_ok" together.


Thanks,
Kaartic
