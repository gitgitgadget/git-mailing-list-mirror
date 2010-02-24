From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 1/3] t9151: Fix a few commits in the SVN dump
Date: Thu, 25 Feb 2010 12:14:20 +1300
Message-ID: <4B85B2CC.3090509@vilain.net>
References: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com> <1266825442-32107-2-git-send-email-tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Tuomas Suutari <tuomas.suutari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:23:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQZk-0006GE-2A
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758349Ab0BXXXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:23:23 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:51188 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178Ab0BXXXW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:23:22 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2010 18:23:22 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 086B232EA1;
	Thu, 25 Feb 2010 12:14:21 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kaxo85VcbEQv; Thu, 25 Feb 2010 12:14:20 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 926E532815;
	Thu, 25 Feb 2010 12:14:20 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <1266825442-32107-2-git-send-email-tuomas.suutari@gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141002>

Tuomas Suutari wrote:
> A few "svn cp" commands and commit commands were executed in incorrect
> order. Therefore some of the desired commits were missing and some
> were committed with wrong revision number in the commit message. This
> made it hard to compare the produced git repository with the SVN
> repository.
>
> The dump file is updated too, but only the relevant parts and with
> hand-edited timestamps to make history linear.
>   

>  say "Make PARTIAL branch"
>  svn update
> -i=$(commit $i "make partial branch")
>  svn cp trunk/subdir branches/partial
> +i=$(commit $i "make partial branch")
>  
>  say "Make a commit to PARTIAL"
>  svn update
> @@ -194,13 +194,13 @@ cd ../../
>  
>  say "Tagging trunk"
>  svn update
> -i=$(commit $i "tagging v1.0")
>  svn cp trunk tags/v1.0
> +i=$(commit $i "tagging v1.0")
>   

Whoops.  Yes, that looks eminently sensible, probably my fault :-).

Acked-by: Sam Vilain <sam@vilain.net>

Sam
