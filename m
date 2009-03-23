From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 6/7] check_ref_format(): tighten refname rules
Date: Mon, 23 Mar 2009 06:59:01 -0700
Message-ID: <20090323135901.GB9732@spearce.org>
References: <cover.1237791716.git.gitster@pobox.com> <345e795e1891c628ad8356b730fade9f7a81e2f6.1237791716.git.gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llkhm-0003NW-01
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbZCWN7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 09:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756557AbZCWN7G
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 09:59:06 -0400
Received: from george.spearce.org ([209.20.77.23]:51139 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbZCWN7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 09:59:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 346D738211; Mon, 23 Mar 2009 13:59:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <345e795e1891c628ad8356b730fade9f7a81e2f6.1237791716.git.gitster@pobox.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114304>

Junio C Hamano <gitster@pobox.com> wrote:
> This changes the rules for refnames to forbid:
> 
>  (1) a refname that contains "@{" in it.
>  (2) a refname that ends with a dot.

How about also "that end in .lock" ?

  $ git branch foo.lock
  $ git branch foo
  fatal: Unable to create '.git/refs/heads/foo.lock': File exists.

  If no other git process is currently running, this probably means a
  git process crashed in this repository earlier. Make sure no other git
  process is running and remove the file manually to contin

Oh, apparently there is also something wrong with the error message...

$ git version
git version 1.6.2.1.433.g0cbc

-- 
Shawn.
