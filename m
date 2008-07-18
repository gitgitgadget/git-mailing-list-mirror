From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH] Support gitlinks in fast-import/export.
Date: Fri, 18 Jul 2008 15:43:38 -0500
Message-ID: <20080718204338.GB27528@spearce.org>
References: <200807182103.37272.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 22:44:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJwog-0000bH-Lt
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 22:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbYGRUnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYGRUnj
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 16:43:39 -0400
Received: from george.spearce.org ([209.20.77.23]:54616 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYGRUni (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 16:43:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 40F00382A4; Fri, 18 Jul 2008 20:43:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807182103.37272.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89078>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> Currently fast-import/export cannot be used for
> repositories with submodules. This patch extends
> the relevant programs to make them correctly
> process gitlinks.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> 	I noticed that fast-export & fast-import cannot work with
> 	repositories using submodules: import complains about
> 	an invalid mode, and export fails while trying to open the SHA
> 	as a blob.
> 
> 	As I didn't see any particular reason for it to be so, I tried to
> 	implement support for gitlinks.
> 
> 	What I'm unsure of is, should fast-export try to reuse commit
> 	marks for gitlinks where it happened to recognize the object,
> 	or always output the SHA as it is stored in the tree?

Its unlikely that the commit objects are in the repository the
export is running in, so its unlikely you can use a mark.  Its
fine to just always output the SHA-1 I think.

-- 
Shawn.
