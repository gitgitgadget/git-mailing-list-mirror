Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA19202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdB1Viz (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:38:55 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36384 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdB1Vix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:38:53 -0500
Received: by mail-pg0-f48.google.com with SMTP id s67so10733899pgb.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1d6GdrNgHkORQlU/Z4J2G+K0KraX/flDuUON36h1Nsg=;
        b=rJCx/C2LhIoFYPHKNFxHndhtV1pf5ZmyA+LjzS9ssiCnN3sMxWR9WdXmfsdnAzBGLg
         +6gPTrwidqB4aW8uECK/HkwaWysn4sOAkxRMirmtS+mQrtK5Jz0fVmowPZBMO3EH05Gl
         /dUgFUlCjz/sKOFUmYStheBUqHnBrARiTeXwbNfFMJwmp/rkkV+fNKFBLfPIRcvtxcQs
         cIL4j88ld5sc4WtJ9vN9phn6qCzEjYocJoujIGigbtUlzdRn78o1UXd0KVWn/V6G1Y3d
         fnU/wzNVw4HI3ifi1jTCahWvz2ZE9bLamIXwz2kux/C2Z9yJQpFu3oL4WJYAn9dO+nUu
         4ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1d6GdrNgHkORQlU/Z4J2G+K0KraX/flDuUON36h1Nsg=;
        b=NK48pSeMkQ33SrquNESgdzj3PYXXVjRKzVs2GnYrZNvl2TQJon+4C6pnKp5IbjnHDq
         BTOMPeCMytjT2HyFiNLzj5REbsODryF+DF75znqyXefxAAzd8rY5SqlNSFmzgyxtdamv
         9I7aud9yhj/2qbfY/+zDtZ9y0pP1czAO0j01tgiAvXKPlLegEVbW2j2KdudKozMEuEBg
         Vxq1/43CkXaMW0fZE+cgmPZNy6qAUQ+pihiv6ZDhlunh/WSr2vNiOR1fOn84d0xvgl01
         Qvd+xcU5w566iFlb1R+XOT4ouzVxioti2BdHzd2IADv045FaIjqQIBZWgYgcqjCdVAhU
         hKQw==
X-Gm-Message-State: AMke39k1fnbK1SSGxI43Kd6+nIzoS3p3amw3Luvc/tDRdRHj0/npdjDf4+ac+xMlbnNNSVFZ
X-Received: by 10.98.30.4 with SMTP id e4mr4636403pfe.19.1488314532225;
        Tue, 28 Feb 2017 12:42:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:a439:8863:7534:1ae1])
        by smtp.gmail.com with ESMTPSA id 15sm5949988pgh.21.2017.02.28.12.42.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 12:42:10 -0800 (PST)
Date:   Tue, 28 Feb 2017 12:42:09 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] strbuf: add strbuf_add_real_path()
Message-ID: <20170228204209.GA110257@google.com>
References: <4d191b86-d36c-e3ec-99c6-d15baa6b659a@web.de>
 <20170227182217.GC153455@google.com>
 <3063b6fb-02aa-703c-0b56-300109cf054d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3063b6fb-02aa-703c-0b56-300109cf054d@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, René Scharfe wrote:
> Am 27.02.2017 um 19:22 schrieb Brandon Williams:
> >On 02/25, René Scharfe wrote:
> >>+void strbuf_add_real_path(struct strbuf *sb, const char *path)
> >>+{
> >>+	if (sb->len) {
> >>+		struct strbuf resolved = STRBUF_INIT;
> >>+		strbuf_realpath(&resolved, path, 1);
> >>+		strbuf_addbuf(sb, &resolved);
> >>+		strbuf_release(&resolved);
> >>+	} else
> >>+		strbuf_realpath(sb, path, 1);
> >
> >I know its not required but I would have braces on the 'else' branch
> >since they were needed on the 'if' branch.  But that's up to you and
> >your style :)
> 
> Personally I'd actually prefer them as well, but the project's style
> has traditionally been to avoid braces on such trailing single-line
> branches to save lines.  The CodingGuidelines for this topic have
> been clarified recently, though, and seem to require them now.
> Interesting.
> 
> René

Having the project's guidelines align with your own preference makes
things a bit easier!

-- 
Brandon Williams
