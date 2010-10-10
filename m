From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v5 3/4] [RFC] Only show bulkmoves in output.
Date: Sun, 10 Oct 2010 14:39:54 +0200
Message-ID: <20101010123954.GB4983@home.lan>
References: <1286659895-1813-1-git-send-email-ydirson@altern.org>
 <1286659895-1813-2-git-send-email-ydirson@altern.org>
 <1286659895-1813-3-git-send-email-ydirson@altern.org>
 <1286659895-1813-4-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 14:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4v20-0007pr-Dl
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 14:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384Ab0JJM3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 08:29:30 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:34349 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399Ab0JJM33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 08:29:29 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 549C7D480A3
	for <git@vger.kernel.org>; Sun, 10 Oct 2010 14:29:22 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P4vBy-0007Xo-EF
	for git@vger.kernel.org; Sun, 10 Oct 2010 14:39:54 +0200
Content-Disposition: inline
In-Reply-To: <1286659895-1813-4-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158657>

On Sat, Oct 09, 2010 at 11:31:34PM +0200, Yann Dirson wrote:
> In theory we could just append those at display time (possibly diluting
> the code too much ?), or before queing the diff.  In practice we cannot
> do the latter easily in either case (strcat to a constant string ("./"),
> nor to the paths tighly-allocated from alloc_filespec).
> 
> So I went the way of including the trailing "*" from the beginning.
> Since I'm still unsure whether keeping it that way, I leave it as a
> separated patch for now.

Thinking twice, that approach has a major problem: it will break when
a file is named "*".  Finally looks like differing this to display
time will be the most sensible solution.
