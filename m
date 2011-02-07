From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git pull: Remove option handling done by fetch
Date: Mon, 7 Feb 2011 01:41:57 -0600
Message-ID: <20110207074157.GA2736@elie>
References: <4D4C5EBC.2090100@web.de>
 <201102042326.08607.j6t@kdbg.org>
 <4D4D33E7.4000303@web.de>
 <7vipwwx56r.fsf@alter.siamese.dyndns.org>
 <4D4F19D0.2000408@web.de>
 <20110206220939.GC17210@elie>
 <4D4F273C.8030003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 07 08:42:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmLjj-0002gM-RK
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 08:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab1BGHmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 02:42:10 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62217 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab1BGHmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 02:42:09 -0500
Received: by gwj20 with SMTP id 20so1596012gwj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 23:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=w7UslqVKnO0X+82t3K6xYvwac923Hcw5Z+wWH29wQaU=;
        b=XJixE8B1cYDrN65b71a6xSDcJOBitoqe4NvCeK9CPIv4AvyQqnE1q8Oyr848tbJs7R
         gUeYZf/HDfClhWYw1/Vjunv/LEV2fcW790+aWdwJjXAWBMjKAtZXwYhJjhg4JDdUYcE2
         SvOmYUXinCv9p/S4EMYZwweXgwIYTl12jEFOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tWkUOrX7Ozp/QfV3xYMcPlh7pFTHRsdQ8CLHixFqvRTIUlUr7/wUbJK9R7ZlDOXApT
         nRFzCA806sCJqXpPrkAB30ThhbMn1DyaytPlJPbVsqyqZ7blOPmS6KKY+VEYokhfWztd
         O0qcjR9nCOpzL83+6imM1nAMNSm/nNGBr8BmU=
Received: by 10.236.103.11 with SMTP id e11mr10907611yhg.43.1297064528868;
        Sun, 06 Feb 2011 23:42:08 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id g14sm2702591yhd.5.2011.02.06.23.42.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 23:42:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4F273C.8030003@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166240>

Jens Lehmann wrote:

> 2) Document "--[no-]recurse-submodules" as " as "git pull" options
>
> (And then I can later pass the same option to "git merge", which is
> much better than the solutions I came up with ;-)

Hmm. :)

[...]
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -84,6 +84,10 @@ must be given before the options meant for 'git fetch'.
>  --verbose::
>  	Pass --verbose to git-fetch and git-merge.
> 
> +--[no-]recurse-submodules::
> +	This option controls if new commits of all populated submodules should
> +	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
> +

Is it worth mentioning that this does not (yet) automatically check
out the new commits in submodules after a merge, or would such
documentation be too likely to be forgotten and left stale in the
future?
