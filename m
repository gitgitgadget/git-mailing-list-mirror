From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/4] fast-export: fix comparisson in tests
Date: Tue, 30 Oct 2012 11:57:31 -0700
Message-ID: <20121030185731.GH15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:57:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTH0Z-00086e-5K
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab2J3S5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:57:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37900 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab2J3S5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:57:36 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so385525pbb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vna7s6gMBjLa9KgTBjl7iH2R7ggo707jjUcWcWxACx8=;
        b=gItE5pcXg9Y0bknzxFalkiOY9VwjgpvCL008pPBMlalBx6R34Cu/Nrjnn3xdb9L2cR
         x400CtQqFW0lmL4zuHv+XLr/L1qkhpnBjyH2HoXEPVxqgEe9/sXkyJI+PjJ2Pa/J5v/V
         f2+YkY5tByGodDiU+BTh8j4O7DoRfq8RFVMBYUK3glL84qLKj6yI0dtRCFBSJl8SprKP
         nw4v/4PI3/xEGmd4QyzRNQYalY8tsRjVUEjKr4hGSGYmkSG6AU+Gurn3TQ+vEo1br1Ax
         4BxGvH/XqmmCSXV1DiBcVpRlMWKdsJyjE4Qb2ku6l2b0g3EQD6JNS3DpcSPNTialZ4s5
         HLLA==
Received: by 10.68.200.33 with SMTP id jp1mr101380961pbc.54.1351623456092;
        Tue, 30 Oct 2012 11:57:36 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id jw14sm935006pbb.36.2012.10.30.11.57.34
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 11:57:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351617089-13036-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208724>

(actually cc-ing the git list this time.  Sorry for the noise, all.)
Felipe Contreras wrote:

> [Subject: [PATCH v2 2/4] fast-export: fix comparisson in tests]
>
> First the expected, then the actual, otherwise the diff would be the
> opposite of what we want.

Spelling: s/comparisson/comparison/.

Semantics: this isn't actually fixing anything --- it's a cosmetic
thing.  It would be clearer to say:

	fast-export test: swap arguments to test_cmp

	This way if diff output is produced, it describes how the
	actual output differs from what was expected rather than the
	other way around.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

For what it's worth, with amended message,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Patch left unsnipped because it hadn't hit the list.

> ---
>  t/t9350-fast-export.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 3e821f9..49bdb44 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -303,7 +303,7 @@ test_expect_success 'dropping tag of filtered out object' '
>  (
>  	cd limit-by-paths &&
>  	git fast-export --tag-of-filtered-object=drop mytag -- there > output &&
> -	test_cmp output expected
> +	test_cmp expected output
>  )
>  '
>  
> @@ -320,7 +320,7 @@ test_expect_success 'rewriting tag of filtered out object' '
>  (
>  	cd limit-by-paths &&
>  	git fast-export --tag-of-filtered-object=rewrite mytag -- there > output &&
> -	test_cmp output expected
> +	test_cmp expected output
>  )
>  '
>  
> @@ -351,7 +351,7 @@ test_expect_failure 'no exact-ref revisions included' '
>  	(
>  		cd limit-by-paths &&
>  		git fast-export master~2..master~1 > output &&
> -		test_cmp output expected
> +		test_cmp expected output
>  	)
>  '
>  
> -- 
> 1.8.0
