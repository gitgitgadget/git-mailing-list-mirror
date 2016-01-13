From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/5] config.mak.uname: support MSys2
Date: Wed, 13 Jan 2016 20:23:05 +0100
Message-ID: <1452712985.18946.2.camel@kaarsemaker.net>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
	 <e63d391a79396e095d2ebb139bb44c390e50bb62.1452691805.git.johannes.schindelin@gmx.de>
	 <20160113161128.GA11898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:23:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJR0o-0002eh-16
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbcAMTXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 14:23:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36690 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbcAMTXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 14:23:09 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so38501871wmf.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 11:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=weEiGm4QBRZ7afXPKgBLdJiFqTeYhot2Qiaw6/VE530=;
        b=FcU4KAooVTl0CDfBdSVWstJVo4QY4MHWwfAqgwiSIoD2ZBltH26Vl9FOEzdIFa+ARr
         82Vvzf7sGB90FVGqFXRGfIsCTDEQfsb6QEpx0JZZCS0dgitdzkH5waHrGJ98EyJvGD7Q
         LSM042PY2JoF9+vbsjRzEqvqc4XE2wHolg+sZtdxjBhH8o0Jj561K/5S/yroqnxbDLhq
         z/Gt3T/8/oswXm1pbGK5RQpCXvrLkq3uUOiaue6LQSH6tuVQW3nSUeXvifd34zNNig35
         ruv3v8mLtNaawEbbI/dTyizkqv1OihFCXaZHQZnXeVPd+f3Hsjozzd/dt+TnbumFQd5h
         aEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=weEiGm4QBRZ7afXPKgBLdJiFqTeYhot2Qiaw6/VE530=;
        b=hYnwYRhPIBSbNxanjm2pAz2Lcc3deFgX6EwNWR9b+ORXEJh6WT+v0RP9bCTh2QAGkD
         gIQ+P7SNR6qdDVrIB2Jpnq+Y2McC72/YYrFqZ3pITJAkExHpgoncRnOwuWR/0RDO/FTM
         jAvMO3wPvTAIbBJQ/1xQY2BDsujyFz39NlJB8QMDVBSvvEDmp4czbo6SENI+rb+QwR6a
         8RSNJmSa0CWf76ADBbZsIsc9SGDkwKoSmP2iZXGSU5Dfn+bpfZ7EJOROs0EXupTVxNis
         wYQumdba7F4t39Yo6lZ8cmrNElPKGW4qXxg3LkWxbNXBqcU2PjLLJSMEZc6FoSaji6Xx
         KsGQ==
X-Gm-Message-State: ALoCoQnjeOCDGkzNFOuDpeO3ejvO26X+O6r3cHNhapSiU8iZcobKP23uBb3bVP4VOG12JwL6eV98SPV8Wih9YyX8kRfWKjpo8Q==
X-Received: by 10.28.194.197 with SMTP id s188mr566361wmf.44.1452712987597;
        Wed, 13 Jan 2016 11:23:07 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id q4sm2790193wja.6.2016.01.13.11.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 11:23:06 -0800 (PST)
In-Reply-To: <20160113161128.GA11898@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283973>

On wo, 2016-01-13 at 11:11 -0500, Jeff King wrote:
> On Wed, Jan 13, 2016 at 02:30:53PM +0100, Johannes Schindelin wrote:
> 
> > For a long time, Git for Windows lagged behind Git's 2.x releases
> > because
> > the Git for Windows developers wanted to let that big jump coincide
> > with
> > a well-needed jump away from MSys to MSys2.
> > [...]
> 
> I can't say much about the patch itself, but I think this commit is
> worth it for the message alone. Now I finally know the subtle
> differences between all of those systems!

Agreed. It might even make sense to have that explanation somewhere in
Documentation/technical/

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
