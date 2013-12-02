From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH v2] gitk: make pointer selection visible in highlighted lines
Date: Mon, 2 Dec 2013 11:04:09 +0100
Message-ID: <1ld8zlh.1h4guajnkaralM%lists@haller-berlin.de>
References: <20131201224132.GB12576@iris.ozlabs.ibm.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com (Eric Sunshine),
	tr@thomasrast.ch (Thomas Rast)
To: paulus@samba.org (Paul Mackerras), max@max630.net (Max Kirillov)
X-From: git-owner@vger.kernel.org Mon Dec 02 11:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnQMR-0003g6-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 11:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab3LBKEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 05:04:11 -0500
Received: from server90.greatnet.de ([83.133.96.186]:58896 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab3LBKEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 05:04:10 -0500
Received: from [10.1.12.147] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 3C7773B105E;
	Mon,  2 Dec 2013 11:04:08 +0100 (CET)
In-Reply-To: <20131201224132.GB12576@iris.ozlabs.ibm.com>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.9 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238621>

Paul Mackerras <paulus@samba.org> wrote:

> On Thu, Nov 28, 2013 at 11:20:18PM +0200, Max Kirillov wrote:
> > Custom tags have higher priority than `sel`, and when they define their
> > own background, it makes selection invisible. Especially inconvenient
> > for `filesep` (to select filenames), but also affects other tags.
> > Use `tag raise` to fix `sel`'s priority.
> > 
> > Also change `omark` tag handling, so that it is created once, together
> > with others, and then only removed from text rather than deleted. Then
> > it will not get larger priority than the `sel` tag.
> 
> This conflicts with the recent change to highlight the current search
> hit in orange (c46149, "gitk: Highlight current search hit in
> orange").  With the selection being the highest-priority tag, the
> current search hit gets shown in grey instead.  I think I prefer the
> orange.  I agree though that if the user explicitly selects part of
> the text using the mouse, the selection highlight should be the
> highest priority in that case.  Maybe the solution is to not select
> the search hit automatically?

I don't think that not selecting the search hint is an option: the
selection is used to keep track of where to search next.

Can't we just raise the currentsearchhit tag above the sel tag?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
