From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: Auto-refresh git-gui
Date: Thu, 5 Jan 2012 09:03:22 +0100
Message-ID: <20120105080322.GD3484@victor>
References: <20120104091547.GC3484@victor>
 <20120104163338.GA27567@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Jan 05 09:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiiIT-0001lL-1y
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 09:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118Ab2AEIDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 03:03:33 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:45462 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab2AEIDb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 03:03:31 -0500
Mail-Followup-To: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120104163338.GA27567@ecki.lan>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187967>

On Wed, Jan 04, 2012 at 05:33:40PM +0100, Clemens Buchacher wrote:
> Hi Victor,
> 
> On Wed, Jan 04, 2012 at 10:15:47AM +0100, Victor Engmark wrote:
> >
> > Is there some way to make `git-gui` rescan automatically when anything
> > in the repository changes?
> 
> How about doing it each time git gui gets focus? Or if that's to
> much do it only if it gets focus _and_ the index has changed?

Ideally (like in jEdit) this should be configurable. In Options ->
General of jEdit, there are the following settings:

"If open files are changed on disk", with options:
* do nothing
* prompt
* automatically reload and notify user
* autoreload without notification

"Check for file change upon", with options:
* application focus
* application focus, visiting the buffer or saving any buffer
* visiting the buffer or saving any buffer
* visiting or saving the buffer
* saving the buffer

Based on this, I guess we could use the following settings:

"When repository changes", with options:
* do nothing [This could optionally disable the next setting]
* prompt
* rescan and notify user
* rescan without notification

"Check for repository changes", with options:
* always [Could be implemented with something like `inotifywait -rm`]
* upon application focus
* upon staging, unstaging, committing or pushing

I think I can see use cases for all these options, although it might be
a bit much to chew for a first iteration.

-- 
Victor Engmark
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
