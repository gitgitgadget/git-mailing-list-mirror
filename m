From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 20:26:53 +0100
Message-ID: <200911302026.53933.j6t@kdbg.org>
References: <cover.1259524136.git.brlink@debian.org> <7v8wdnooza.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:27:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFBu2-00058S-Mx
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 20:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbZK3T1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 14:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbZK3T1G
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 14:27:06 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:19913 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753027AbZK3T1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 14:27:06 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 928DFCDF82;
	Mon, 30 Nov 2009 20:27:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4C2D019F6B5;
	Mon, 30 Nov 2009 20:26:54 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v8wdnooza.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134132>

On Montag, 30. November 2009, Junio C Hamano wrote:
> To avoid that, I think (1) the marker has to be more reliable than just
> "happens to have the same tree", and (2) the traversal done by Porcelains
> (your patches 3 thru 5) by default should be unaware of eqt.
>
> I don't know what a suitable marker should look like, though.  The marker
> must be easily identifiable by the lowest level rev-list machinery, so it
> needs to be a sign left somewhere in the commit object.

Wouldn't the pathspec . be the marker:

    git rev-list HEAD -- .

follows only one of the branches that have identical trees.

-- Hannes
