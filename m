From: Yann Dirson <ydirson@free.fr>
Subject: Re: [RFC PATCH v4 0/4] Detection of directory renames
Date: Thu, 7 Oct 2010 01:17:34 +0200
Message-ID: <20101006231734.GZ4983@home.lan>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <20101005014208.GE9994@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:07:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3d5G-0001Vy-IO
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759489Ab0JFXHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 19:07:30 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:53830 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758212Ab0JFXH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:07:29 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 21C5DD48024;
	Thu,  7 Oct 2010 01:07:22 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P3dEs-0005KX-9R; Thu, 07 Oct 2010 01:17:34 +0200
Content-Disposition: inline
In-Reply-To: <20101005014208.GE9994@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158349>

On Mon, Oct 04, 2010 at 08:42:08PM -0500, Jonathan Nieder wrote:
> >From my point of view, I think it would be best to start with
> the smallest usable piece, which is the raw format.  It probably
> makes the most sense to error out when -u and --detect-dir-renames are
> used together.  Then unified diff could be reenabled in a separate
> patch series on top of this one.

Well, there's probably not much to do - in the same order of work than
adding the check to error out :)

> Another nice feature might be to let the directory-move
> detection feed back into file-move detection to make it more
> accurate.  Have you thought about this?  Would it be feasible,
> and if so, would it be useful?

That was suggested by Junio at that time.  It would surely be useful
in some cases, but it's not clear to me how frequently it would.  And
I'd suspect that quite some design changes would be necessary: that
would be a 2-way influence, in that a nearly-complete bulkmove could
bump the score of the latest rename that would make it a full
bulkmove.  Probably not trivial to do right.
