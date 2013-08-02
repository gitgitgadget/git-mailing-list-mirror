From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 03/13] contrib/subtree: Better Error Handling for add
Date: Fri, 02 Aug 2013 10:19:16 +0200
Message-ID: <87bo5g5wu3.fsf@igel.home>
References: <1360064219-28789-1-git-send-email-greened@obbligato.org>
	<1360064219-28789-4-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Fri Aug 02 10:19:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5AaD-00080S-Bp
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 10:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab3HBIT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 04:19:28 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52056 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab3HBITZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 04:19:25 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3c61Vw5j1dz3hhZc;
	Fri,  2 Aug 2013 10:19:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3c61Vt0PmTzbbn3;
	Fri,  2 Aug 2013 10:19:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id oG_lCJpmQN68; Fri,  2 Aug 2013 10:19:17 +0200 (CEST)
X-Auth-Info: raiDIuXiSVZu3xVTHLghD3NHeVCw84yX/OMhASnITH0=
Received: from igel.home (ppp-88-217-110-98.dynamic.mnet-online.de [88.217.110.98])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  2 Aug 2013 10:19:17 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id CA2F82C0045; Fri,  2 Aug 2013 10:19:16 +0200 (CEST)
X-Yow: I have seen these EGG EXTENDERS in my Supermarket..
 ..  I have read the INSTRUCTIONS...
In-Reply-To: <1360064219-28789-4-git-send-email-greened@obbligato.org> (David
	A. Greene's message of "Tue, 5 Feb 2013 05:36:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231519>

"David A. Greene" <greened@obbligato.org> writes:

>  	elif [ $# -eq 2 ]; then
> -		"cmd_add_repository" "$@"
> +	    git rev-parse -q --verify "$2^{commit}" >/dev/null ||
> +	    die "'$2' does not refer to a commit"

That doesn't make any sense.  $2 is a commit in a remote repository
which hasn't been fetched yet, so it can never be verified against the
local repository.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
