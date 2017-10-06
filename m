Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3225B1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdJFOTI (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:19:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35976 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdJFOTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:19:07 -0400
Received: by mail-pf0-f194.google.com with SMTP id u12so4059883pfl.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=00+iThfgkfteFr6hhIBAMbaQ5WHGvR1zuTq6Rf9DXX0=;
        b=JIZL40k+WnFXGIxe0ciSb0J26fQR/82wD5DVYZdhx0l1vgr+LQ6VJWcw8eR92l+RQo
         Scs213LgNFCOevFTCM7CsxIlMsNdmw7kfVLKJXHFjxcfIZmhMWRG1IbwmhGuuTLzCtU5
         YTBypZJ4s1+yWgLPxlrfZJtlg9gjts4ZtWafOpoakMDB89HjN/IvU4hySO94DG0Zgq7F
         ioMWeDAGy2SxfF3Sg1bvMv+phANeUEeaz8ac7Lep5HxtY4Gehmo7fRo4gisrd0Dv0X5i
         +knqC+fWcpsRLquHToSGi8Clmu+5gOcqWwk3SDY6N1M6T3UzeUkRUIHCNDLW6ggbbOfV
         L2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=00+iThfgkfteFr6hhIBAMbaQ5WHGvR1zuTq6Rf9DXX0=;
        b=kNgfwwsL765UArR76sqWFUVcB9SiL1TgY9rHkdSBE1IlVpW4KlFqUPqMTmmkKiUW9w
         EkKSUGYdW7GZr2eI9wp3bSTz0RDVHa8aoywvoIad11JOLjy3UhPFXHOTE7StGrSqyy24
         vB8e8K9mdG/6fvVWCeXpTNnpqDefQqOnlss7WttL/juXnKvuWKgYYA+A9IDcY6y3Bon5
         FaPtcZItkLkFsJvgbqtFXYaDNGzH7LprUBXerwG/ogdglQJK3ime9b8z/MA4WCA9JAnl
         Z2ryS+KGquWfCMU9JpQIQh8NadE9RoOVZrJbCAwP7PhiC++M4+T9SJ1MpfRaeS77Jm8J
         sMyQ==
X-Gm-Message-State: AMCzsaUZKsfQmH5wC3SptbJm/SHaO0ZbAKVuqP9buKjh0IgMjFNACeWS
        3XlcMkSpOROEkIfiTXuRN/VDeAzr
X-Google-Smtp-Source: AOwi7QDS06GbH1oEIa4hJHWobMwTiqlx5FilEAIYUSJPrBjZfxvifczDliM774SMOfq25vJSPaotMA==
X-Received: by 10.84.234.196 with SMTP id i4mr2103998plt.432.1507299546943;
        Fri, 06 Oct 2017 07:19:06 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id l74sm4302884pfi.9.2017.10.06.07.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 07:19:05 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam@gmail.com>
Message-ID: <1507299524.12554.9.camel@gmail.com>
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
To:     rpjday@crashcourse.ca, git@vger.kernel.org
In-Reply-To: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 06 Oct 2017 19:48:44 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-10-06 at 06:14 -0400, rpjday@crashcourse.ca wrote:
>    and in this funny grey area in between, we have .git/info/exclude,
> to be used for ... what, exactly? the one argument i've come up with
> is the situation where you discover that a repo you've cloned has an
> incomplete set of .gitignore patterns, and while you submit a patch
> for that to the maintainer, you can temporarily add that pattern
> to .git/info/exclude, and as soon as the patch is accepted, you can
> toss it.
> 
>    but even that isn't a really compelling reason. so what's it for?
> 

Thanks for asking this question. I have long been in the scenario you
just described above except that I didn't know of .git/info/exclude all
these days. I was longing to find if there was a way to ignore files in
 a repo without touching the .gitignore of that repo . Now I have found
one, the ".git/info/exclude".

Thanks, again.

-- 
Kaartic
