From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: make pointer selection visible in highlighted
 lines
Date: Mon, 2 Dec 2013 09:41:32 +1100
Message-ID: <20131201224132.GB12576@iris.ozlabs.ibm.com>
References: <20131127180601.GA31211@wheezy.local>
 <20131128212018.GA24615@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Dec 01 23:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnFi7-0008Jm-0V
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 23:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab3LAWls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 17:41:48 -0500
Received: from ozlabs.org ([203.10.76.45]:57545 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab3LAWlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 17:41:47 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9A12B2C009A; Mon,  2 Dec 2013 09:41:45 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20131128212018.GA24615@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238597>

On Thu, Nov 28, 2013 at 11:20:18PM +0200, Max Kirillov wrote:
> Custom tags have higher priority than `sel`, and when they define their
> own background, it makes selection invisible. Especially inconvenient
> for `filesep` (to select filenames), but also affects other tags.
> Use `tag raise` to fix `sel`'s priority.
> 
> Also change `omark` tag handling, so that it is created once, together
> with others, and then only removed from text rather than deleted. Then
> it will not get larger priority than the `sel` tag.

This conflicts with the recent change to highlight the current search
hit in orange (c46149, "gitk: Highlight current search hit in
orange").  With the selection being the highest-priority tag, the
current search hit gets shown in grey instead.  I think I prefer the
orange.  I agree though that if the user explicitly selects part of
the text using the mouse, the selection highlight should be the
highest priority in that case.  Maybe the solution is to not select
the search hit automatically?

Paul.
