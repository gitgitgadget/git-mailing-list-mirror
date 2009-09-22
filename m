From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] bash: teach 'git checkout' options
Date: Tue, 22 Sep 2009 08:28:46 -0700
Message-ID: <20090922152846.GQ14660@spearce.org>
References: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de> <7c8c4f6a4c581bcba101b8ca467d241738aa376e.1253009868.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: SZEDER G??bor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 22 17:28:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq7IP-0000ej-Fh
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 17:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZIVP2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbZIVP2k
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 11:28:40 -0400
Received: from george.spearce.org ([209.20.77.23]:39294 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbZIVP2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 11:28:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0FCB138151; Tue, 22 Sep 2009 15:28:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7c8c4f6a4c581bcba101b8ca467d241738aa376e.1253009868.git.szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128941>

SZEDER G??bor <szeder@ira.uka.de> wrote:
> @@ -809,7 +809,18 @@ _git_checkout ()
>  {
>  	__git_has_doubledash && return
>  
> -	__gitcomp "$(__git_refs)"
> +	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	case "$cur" in
> +	--*)
> +		__gitcomp "
> +			--quiet --ours --theirs --track --no-track --merge
> +			--conflict= --patch

If we are completing long options, shouldn't we also complete the
supported values for --conflict?  According to the docs, this is
'merge' and 'diff3'.

-- 
Shawn.
