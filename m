From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] t0090: mark add-interactive test with PERL prerequisite
Date: Tue, 18 Nov 2014 18:10:24 -0500
Message-ID: <20141118231024.GA8159@padd.com>
References: <20141118172231.GA16387@peff.net>
 <20141118174309.GB31672@peff.net>
 <20141118183838.GD6527@google.com>
 <20141118184347.GE6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 00:18:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqs2S-00019J-KC
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 00:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbaKRXSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 18:18:21 -0500
Received: from honk.padd.com ([71.19.245.7]:53584 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbaKRXSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 18:18:20 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Nov 2014 18:18:20 EST
Received: from arf.padd.com (unknown [50.111.156.210])
	by honk.padd.com (Postfix) with ESMTPSA id E72271E58;
	Tue, 18 Nov 2014 15:10:25 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4ADBF20831; Tue, 18 Nov 2014 18:10:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20141118184347.GE6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jrnieder@gmail.com wrote on Tue, 18 Nov 2014 10:43 -0800:
> ... and here's a patch on top to give git-p4 the same treatment.
> 
> -- >8 --
> Subject: Makefile: have python scripts depend on NO_PYTHON setting
> 
> Like the perl scripts, python scripts need a dependency to ensure they
> are rebuilt when switching between the "dummy" versions that run
> without Python and the real thing.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 8f980e0..7482a4d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1736,6 +1736,9 @@ $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
>  	mv $@+ $@
>  endif # NO_PERL
>  
> +# This makes sure we depend on the NO_PYTHON setting itself.
> +$(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
> +
>  ifndef NO_PYTHON
>  $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
>  $(SCRIPT_PYTHON_GEN): % : %.py
> -- 
> 2.1.0.rc2.206.gedb03e5

Looks obviously correct, thanks for remembering the other
scripting languages.  :)

Acked-by: Pete Wyckoff <pw@padd.com>
