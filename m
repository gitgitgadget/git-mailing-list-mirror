From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: git-http-fetch failure/segfault -- alas no patch
Date: Tue, 31 Jan 2006 09:58:13 -0800
Message-ID: <20060131175813.GD3873@reactrix.com>
References: <17374.30792.548889.344768@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 18:58:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3zlx-0005Mn-QQ
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 18:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWAaR6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 12:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWAaR6a
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 12:58:30 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:60351 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751312AbWAaR6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 12:58:30 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k0VHwELC030916;
	Tue, 31 Jan 2006 09:58:14 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k0VHwDqZ030914;
	Tue, 31 Jan 2006 09:58:13 -0800
To: Mark Wooding <mdw@distorted.org.uk>
Content-Disposition: inline
In-Reply-To: <17374.30792.548889.344768@metalzone.distorted.org.uk>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15328>

On Mon, Jan 30, 2006 at 08:34:16PM +0000, Mark Wooding wrote:

> run_active_slot.  As far as I can make out, the slot used to collect
> .../info/packs is being /reused/ by fill_active_slots (called by
> step_active_slots) before fetch_indices is returned to.

Good catch, there were a couple of places where slot result data could
be processed after the slot had been reused, with rather unpredictable
results.

There's a patch on the way after a bit more testing.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
