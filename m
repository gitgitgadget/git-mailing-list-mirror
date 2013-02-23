From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: patch for fix build git on Haiku
Date: Sat, 23 Feb 2013 12:42:08 -0800
Message-ID: <20130223204208.GB3222@elie.Belkin>
References: <254e4f8fb172cec1e547413e2828b642@freenet59.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
To: diger <admin@freenet59.ru>
X-From: git-owner@vger.kernel.org Sat Feb 23 21:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Lvh-0000bX-SG
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 21:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758333Ab3BWUmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 15:42:15 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38659 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175Ab3BWUmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 15:42:14 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so1006397pbc.19
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 12:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=32CWZMzSs3hiprS+QiuEUy1rp8FQaTQEkwbu22YxPOQ=;
        b=DqI8n/VyTFlRG7lyDzDq4QZJkCX9kF5ZcIvQvyBs/pHC07Dl1tPUuAym1YCXH3hfVi
         sFYcxnCOD2vrmP9+981ql3YGOyzTV5imyoSkGEbDP+xUT66PkgXcUD2LfMWHUsvJL2Bj
         PvsrFu4K8K/kJaV12pL4FXIny048rOWzE9Vv4Dun2z3U8MbWxy7++vS7Pt8Uruvo9hwy
         yazG7GsV0zN+xxn+aMIY7RqH+34g1/Ngwxzz61egIwIpg3FAfNgNWCWsfRqjmMo4eZj1
         sp/n6KK6QhqMdB33/63WwufjEft0WK3MDkiplkTbUfrCa95jUHDZwSQTxoJDUls8dlWo
         MgzA==
X-Received: by 10.66.154.162 with SMTP id vp2mr10890787pab.138.1361652133222;
        Sat, 23 Feb 2013 12:42:13 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id 1sm6977842pbg.18.2013.02.23.12.42.10
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 12:42:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <254e4f8fb172cec1e547413e2828b642@freenet59.ru>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216912>

Hi,

diger wrote:

> This patch fixes build git on Haiku

Lovely.  May we have your sign-off?  (See
Documentation/SubmittingPatches for what this means.)  Does "make
test" pass?  (Just curious --- it's fine if it doesn't, though in that
case a list of test failures would be helpful.)

Thanks,
Jonathan

(patch left unsnipped for reference)

> --- Makefile.orig	2012-10-21 21:32:15.000000000 +0000
> +++ Makefile
> @@ -1211,6 +1204,16 @@ ifeq ($(uname_S),HP-UX)
>  	endif
>  	GIT_TEST_CMP = cmp
>  endif
> +ifeq ($(uname_S),Haiku)
> +    NO_R_TO_GCC_LINKER = YesPlease
> +    NO_LIBGEN_H = YesPlease
> +    NO_MEMMEM = YesPlease
> +    NO_MKSTEMPS = YesPlease
> +    NEEDS_LIBICONV = YesPlease
> +    DEFAULT_EDITOR = nano
> +    PTHREAD_LIBS =    -lroot
> +    NO_CROSS_DIRECTORY_HARDLINKS = YesPlease
> +endif
>  ifeq ($(uname_S),Windows)
>  	GIT_VERSION := $(GIT_VERSION).MSVC
>  	pathsep = ;
