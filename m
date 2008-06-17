From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well [V2]
Date: Tue, 17 Jun 2008 10:30:35 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171027200.6439@racer>
References: <1213633441-29185-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:33:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8XYu-0002Vj-PZ
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 11:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYFQJcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 05:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbYFQJcO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 05:32:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:52652 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753641AbYFQJcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 05:32:12 -0400
Received: (qmail invoked by alias); 17 Jun 2008 09:32:10 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp059) with SMTP; 17 Jun 2008 11:32:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1946WsMwQB40T4x+HQkVHQ2Yp7RLqp06KWnSVtU6/
	QBXfh8IRsjrkdf
X-X-Sender: gene099@racer
In-Reply-To: <1213633441-29185-1-git-send-email-dzickus@redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85279>

Hi,

On Mon, 16 Jun 2008, Don Zickus wrote:

> Changes since v1
> ================
> - converted to path-list structs
> - added testcases for renaming a patch and apply a new patch on top inside
> the same patch file

Just for future reference: commonly, this is not put into the commit 
message, but after the "---" separator into the mail comments.

> +/*
> + * Caches patch filenames to handle the case where a
> + * patch chunk reuses a filename
> + */
> +struct fn_cache {
> +	char *name;
> +	struct patch *patch;
> +	struct fn_cache *next;
> +};

It is still not a path_list.  Even if you said so in the "Changes since 
V1".

See 
http://repo.or.cz/w/git/vmiklos.git?a=blob;f=Documentation/technical/api-path-list.txt;h=9dbedd0a67ce6c1cecd157b0d89f9b1333e180e3;hb=340d6344cfe13bb93740f40d3268ca39b8c7c15d#l36 
for a nice example how to use path_lists.

You want to use path_list_has_path().

Hth,
Dscho
