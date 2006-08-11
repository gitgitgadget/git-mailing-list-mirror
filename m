From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] http-push: Make WebDAV work with (broken?) default apache2 WebDAV module
Date: Thu, 10 Aug 2006 21:58:01 -0700
Message-ID: <20060811045801.GA4544@reactrix.com>
References: <20060809185423.GB7841@nospam.com> <7vk65h3drd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@wingding.demon.nl, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 11 06:58:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBP6f-0004BM-RC
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 06:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWHKE6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 00:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHKE6J
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 00:58:09 -0400
Received: from mail.reactrix.com ([69.26.37.12]:52458 "EHLO mail.reactrix.com")
	by vger.kernel.org with ESMTP id S1751427AbWHKE6I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 00:58:08 -0400
Received: from sc-exch1.corp.reactrix.com (unknown [172.16.1.1])
	by mail.reactrix.com (Spam Firewall) with ESMTP
	id B4DE213BC3; Thu, 10 Aug 2006 21:58:09 -0700 (PDT)
Received: from localhost.localdomain ([10.5.23.177]) by sc-exch1.corp.reactrix.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 10 Aug 2006 21:58:03 -0700
Received: from localhost.localdomain (teapot [127.0.0.1])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id k7B4w3dw026597;
	Thu, 10 Aug 2006 21:58:03 -0700
Received: (from nickh@localhost)
	by localhost.localdomain (8.13.1/8.13.1/Submit) id k7B4w2Xl026596;
	Thu, 10 Aug 2006 21:58:02 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk65h3drd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 11 Aug 2006 04:58:03.0989 (UTC) FILETIME=[BA4DE850:01C6BD02]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25218>

On Wed, Aug 09, 2006 at 12:33:42PM -0700, Junio C Hamano wrote:

> > WebDAV on Debian unstable cannot handle renames on WebDAV from
> > file.ext to newfile (without ext) when newfile* already
> > exists. Normally, git creates a file like 'objects/xx/sha1.token',
> > which is renamed to 'objects/xx/sha1' when transferred completely.
> >
> > Just use '_' instead of '.' so WebDAV doesn't see it as an extension
> > change.
> >
> > Signed-off-by: Rutger Nijlunsing <git@tux.tmfweb.nl>
> > Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Good problem and workaround description.  Nick, does this look
> sane to you, or is there a more kosher way to handle this?

This looks good to me - while it seems like the problem is in the DAV
server it also seems like problematic DAV servers will be less likely to
trip up on an underscore in the filename.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.

This message (including any attachments) contains confidential information intended for a specific individual and purpose, and is protected by law. If you are not the intended recipient, you should delete this message. Any disclosure, copying, or distribution of this message, or the taking of any action based on it, is strictly prohibited.
