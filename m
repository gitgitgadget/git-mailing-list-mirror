From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] completion: enhance "current branch" display
Date: Sun, 10 May 2009 12:59:07 +0200
Message-ID: <200905101259.07175.j6t@kdbg.org>
References: <7vvdo91glm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 13:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M36lg-00038f-IQ
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 13:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbZEJK7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 06:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbZEJK7L
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 06:59:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63829 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbZEJK7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 06:59:11 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 93B9ECDF95;
	Sun, 10 May 2009 12:59:07 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A31225B01F;
	Sun, 10 May 2009 12:59:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vvdo91glm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118714>

On Sonntag, 10. Mai 2009, Junio C Hamano wrote:
>  				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||

While you are here, you could turn this line into

		{ b=$(< "$g/HEAD") && b=${b:0:7}...; } 2>/dev/null ||

to save a process. $(< foo) is a bash feature and does the same as $(cat foo), 
but faster.

-- Hannes
