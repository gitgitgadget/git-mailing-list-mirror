From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-gui: Do not select Revert Changes by default
Date: Sat, 17 Mar 2012 21:02:21 +0100
Message-ID: <4F64EDCD.1000405@kdbg.org>
References: <loom.20120317T161127-418@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthew L Daniel <mdaniel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 21:02:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8zpp-0003Mt-R7
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 21:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab2CQUCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 16:02:34 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11102 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756078Ab2CQUCY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 16:02:24 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 47845A7EB2;
	Sat, 17 Mar 2012 21:03:19 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4158119F349;
	Sat, 17 Mar 2012 21:02:21 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <loom.20120317T161127-418@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193349>

Am 17.03.2012 16:12, schrieb Matthew L Daniel:
> Currently, if one activates the revert changes dialog,
> it has the destructive button selected as the default.
> 
> This change moves the default action to "do nothing".
> ---
>  git-gui/lib/index.tcl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
> index 8efbbdd..252aa33 100644
> --- a/git-gui/lib/index.tcl
> +++ b/git-gui/lib/index.tcl
> @@ -437,7 +437,7 @@ proc revert_helper {txt paths} {
>  
>  [mc "Any unstaged changes will be permanently lost by the revert."]" \
>  		question \
> -		1 \
> +		0 \
>  		[mc "Do Nothing"] \
>  		[mc "Revert Changes"] \
>  		]

Gah! Please no!

The destructive action is that you chose Branch->Revert. The dialog is
the "Are you sure?" question. Your change is the equivalent of an "Are
you sure that you are sure?" question. It does not make a lot of
difference for point-and-click people, but you force another keypress on
people who operate git-gui with the keyboard.

-- Hannes
