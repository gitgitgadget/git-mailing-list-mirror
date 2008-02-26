From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix premature free of ref_lists while writing temporary
 refs to file
Date: Tue, 26 Feb 2008 15:42:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261542080.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802261358.33357.johan@herland.net> <200802261437.18950.johan@herland.net> <200802261635.51407.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 16:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU1yO-0001G0-N8
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 16:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762600AbYBZPn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 10:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762522AbYBZPn2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 10:43:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:43583 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761534AbYBZPn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 10:43:27 -0500
Received: (qmail invoked by alias); 26 Feb 2008 15:43:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 26 Feb 2008 16:43:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PZbxOKzXPrWeWVCRp6fe1+nMpvalJDsoRpnOxG7
	u0aCDuf1p7EEoa
X-X-Sender: gene099@racer.site
In-Reply-To: <200802261635.51407.johan@herland.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75147>

Hi,

On Tue, 26 Feb 2008, Johan Herland wrote:

> We cannot call write_ref_sha1() from within a for_each_ref() callback, 
> since it will free() the ref_list that the for_each_ref() is currently 
> traversing.
> 
> Therefore rewrite setup_tmp_ref() to not call write_ref_sha1(), as 
> already hinted at in a comment.

I guess the reason was to use a much of an API as possible.

If you already avoid that, why not write into .git/packed-refs directly?

Ciao,
Dscho
