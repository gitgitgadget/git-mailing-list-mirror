From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well [V2]
Date: Tue, 17 Jun 2008 10:14:52 -0400
Message-ID: <20080617141452.GJ16941@redhat.com>
References: <1213633441-29185-1-git-send-email-dzickus@redhat.com> <alpine.DEB.1.00.0806171027200.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8byU-0004rD-Ma
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918AbYFQOO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 10:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757715AbYFQOO7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:14:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218AbYFQOO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 10:14:58 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5HEEswn005651;
	Tue, 17 Jun 2008 10:14:54 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5HEEr3j018591;
	Tue, 17 Jun 2008 10:14:53 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5HEEr1L022997;
	Tue, 17 Jun 2008 10:14:53 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5HEEr7X019778;
	Tue, 17 Jun 2008 10:14:53 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5HEErxG019777;
	Tue, 17 Jun 2008 10:14:53 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806171027200.6439@racer>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85300>

On Tue, Jun 17, 2008 at 10:30:35AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 16 Jun 2008, Don Zickus wrote:
> 
> > Changes since v1
> > ================
> > - converted to path-list structs
> > - added testcases for renaming a patch and apply a new patch on top inside
> > the same patch file
> 
> Just for future reference: commonly, this is not put into the commit 
> message, but after the "---" separator into the mail comments.

Ok. Thanks.

> 
> > +/*
> > + * Caches patch filenames to handle the case where a
> > + * patch chunk reuses a filename
> > + */
> > +struct fn_cache {
> > +	char *name;
> > +	struct patch *patch;
> > +	struct fn_cache *next;
> > +};
> 
> It is still not a path_list.  Even if you said so in the "Changes since 
> V1".

Yeah, I attached the wrong patch, see V3. :-)

Cheers,
Don
