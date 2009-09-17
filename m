From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Update the usage bundle string.
Date: Thu, 17 Sep 2009 08:12:52 +0200
Message-ID: <4AB1D364.1080701@viscovery.net>
References: <1253136011-12011-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 08:13:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoAEu-0001t6-QU
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 08:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbZIQGMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 02:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753886AbZIQGMu
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 02:12:50 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14094 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611AbZIQGMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 02:12:50 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoAEe-0000DT-S1; Thu, 17 Sep 2009 08:12:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A4556BC81; Thu, 17 Sep 2009 08:12:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1253136011-12011-1-git-send-email-tfransosi@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128714>

Thiago Farina schrieb:
> @@ -11,6 +11,12 @@
>  
>  static const char *bundle_usage="git bundle (create <bundle> <git rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";

Is this variable still used? Shouldn't it be removed?

> +static const char builtin_bundle_usage[] = "\
> +  git bundle create <file> <git-rev-list args>\n\
> +  git bundle verify <file>\n\
> +  git bundle list-heads <file> [refname...]\n\
> +  git bundle unbundle <file> [refname...]";

You indent the usage text. Do other commands do that, too? If you resend,
it may be worth using this style:

static const char builtin_bundle_usage[] =
	"git bundle create <file> <git-rev-list args>\n"
	"git bundle verify <file>\n"
...

i.e. not to use backslash-at-eol.

> -	if (argc < 3)
> -		usage(bundle_usage);
> +  if (argc < 3)
> +		usage(builtin_bundle_usage);

This re-indentation is an accident, isn't it?

-- Hannes
