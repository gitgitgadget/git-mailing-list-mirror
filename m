Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9295320756
	for <e@80x24.org>; Fri, 20 Jan 2017 13:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbdATNXo (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 08:23:44 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36517 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbdATNXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 08:23:42 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so6936524pgf.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 05:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tElRk2LiBtGEr3Ds0gxeT3DgC33GUecV2/pqsQsau68=;
        b=BRXrIqrdvJRIzxHuWh0+Uag4B11DNUaXnop5OjQTFJEmBBeW6naTIXWOwW/uWuLkUJ
         DPizWUheGSnMNpeUyRsHZWkYt6pQuvxjoBINzj8swkAiiD8poL0CpdfggI9DIUOU+BoC
         2FD6b+Tid2vSon9v3pBCnchyhS0xYCAMoB4kNu8d/nvAGguh9GpR0b+um00tCWks/ugN
         E/3I5W2k2qHPMGm++3ZM38fXu3kB7/sS1NUz0TEl3GZR9cXQD4BHPnYoUORY0BC4dNnk
         wHoZ80kN4eC4RmNVmGeUdSPFw6Jdr9jRI8fhoYdpXV+JK11Sy22gccInStq/xsxSz1YX
         aC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tElRk2LiBtGEr3Ds0gxeT3DgC33GUecV2/pqsQsau68=;
        b=LmplJbPVNuGsTPx0VMug0bopU+0KMcvIGOC0QXUoVIVeZjnyiB605V108DBPN/IGLp
         ptvbWkrohJeZTInj0ONGYVArbcv8vs6mdfW+UjoY4JLQnfkBhi1lbCHvgMoD40Uuptn3
         KHa5f7/TWVD33AI7JsK7byTSbxkNwU0JwmRcwqxKdhzCRqaZXOVVBaLyqk+8oIvcSkoe
         TkIt2EREwp2+GTc/ebKa6t/OgXrVs7sR/InzR+j3de+uwPXhdNiK22szgLuCIyDUFQLl
         Q2oDLjJqIkc349Q9/Wqxtodty1+kPcCgY7yIy6vUDjQ1C44Y2P+g0piOPv5qvvHBx8dJ
         zFSw==
X-Gm-Message-State: AIkVDXL8z5U7CohN65CiE8rxwh3DBMTJ1Z6Y7c19DipyjzGa0NGxWW6jWT/9h5ijzlnzCA==
X-Received: by 10.84.232.133 with SMTP id i5mr21297392plk.79.1484918607231;
        Fri, 20 Jan 2017 05:23:27 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id p67sm17041383pfb.2.2017.01.20.05.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 05:23:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 20 Jan 2017 20:23:22 +0700
Date:   Fri, 20 Jan 2017 20:23:22 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Localise error headers
Message-ID: <20170120132322.GA23030@ash>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
 <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
 <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 06:37:25AM -0500, Jeff King wrote:
> > To find a good example, "git grep die" giving me some food of though:
> > 
> > die_errno(..) should always take a string marked up for translation,
> > because the errno string is translated?
> 
> Yes, I would think die_errno() is a no-brainer for translation, since
> the strerror() will be translated.

I agree. And the main (*) changes are relative simple too. I've tested
it a bit. Seems to work ok.

-- 8< --
diff --git a/Makefile b/Makefile
index d861bd9985..6f88c6cac5 100644
--- a/Makefile
+++ b/Makefile
@@ -2102,7 +2102,7 @@ XGETTEXT_FLAGS = \
 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
 	--from-code=UTF-8
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
-	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
+	--keyword=_ --keyword=N_ --keyword="Q_:1,2" --keyword=die_errno
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
diff --git a/usage.c b/usage.c
index 17f52c1b5c..c022726f9c 100644
--- a/usage.c
+++ b/usage.c
@@ -159,7 +159,7 @@ void NORETURN die_errno(const char *fmt, ...)
 	}
 
 	va_start(params, fmt);
-	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	die_routine(fmt_with_err(buf, sizeof(buf), _(fmt)), params);
 	va_end(params);
 }
 
-- 8< --

(*) We would need another patch to remove _() from die_errno(_(..)).
But that's something I expect coccinelle to be excel at.
--
Duy
