From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: git-filter-branch behavior
Date: Wed, 13 Aug 2008 16:00:23 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808131552130.11537@harper.uchicago.edu>
References: <e0b44a890808130914oced739cy2aaf54aebfcfcbce@mail.gmail.com>
 <Pine.GSO.4.62.0808131533320.10800@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Neu <david@davidneu.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:01:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNTH-0002US-45
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYHMVA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbYHMVA0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:00:26 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:53017 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbYHMVAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:00:25 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7DL0ONY011296;
	Wed, 13 Aug 2008 16:00:24 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7DL0NMp011790;
	Wed, 13 Aug 2008 16:00:23 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808131533320.10800@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92274>

Jonathan Nieder wrote:

> # prune-empty-commits - filter-branch filter to avoid boring commits
> #
> # Usage: git-filter-branch --tree-filter <something> \
> # 		--commit-filter 'prune-empty-commits "$@"' -- <refs>
[...]
> 	map "$sha1" | while read parent

Oops - the 'map' function is not passed on to scripts, so one should
use this script with "--commit-filter '. prune-empty-commits'".

> 	test "-n interesting" && break

s/"-n interesting"/-n "$interesting"/

Sorry about that.
