From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] git-p4: Fix support for symlinks.
Date: Tue, 7 Aug 2007 02:10:49 -0700
Organization: Google, Inc.
Message-ID: <20070807091049.GA13308@bulgaria>
References: <200708071025.47965.simon@lst.de> <7vtzrb68kq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org,
	Han-Wen Nienhuys <hanwen@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 11:13:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIL8R-0002Au-Sy
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 11:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224AbXHGJNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 05:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757172AbXHGJNo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 05:13:44 -0400
Received: from smtp-out.google.com ([216.239.33.17]:55225 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbXHGJNn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 05:13:43 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id l779BhPp007124;
	Tue, 7 Aug 2007 10:11:43 +0100
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:in-reply-to:organization:user-agent;
	b=hEs1+YmT1VmixLY7KmVNfKzMQQXsOL8NWfgvsa18rOOzMdqF8TnUF+hXPfwG5JGip
	7LQJGtHaJeVz5SWzLLCUw==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps75.corp.google.com with ESMTP id l779BXLf008838;
	Tue, 7 Aug 2007 02:11:33 -0700
Received: by bulgaria (Postfix, from userid 1000)
	id 405F48F363; Tue,  7 Aug 2007 02:10:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtzrb68kq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55237>

[Junio C Hamano <gitster@pobox.com>]
> Simon Hausmann <simon@lst.de> writes:
> 
> [ patch for correct symlink handling ]
> 
> Thanks for a quick fix.
> 
> Brian, does this resolve the issue for you?  I do not have an
> access to p4 myself so I won't make a good judge in this area
> myself.  An Ack is appreciated.

Ack.

Looks good here.  I can now sync from the p4 tree into git, check out
from git and do a clean build, and everything's happy.

Thanks for the quick fix, Simon!

One observation on git-p4 -- it's a little memory hungry when processing
large syncs.  I haven't tried incremental syncs on top of the initial
one though -- if it's only the initial that's expensive it's not that
big a deal.

It seemed to top out around 988MB resident.  The branch I was importing
is about 562MB when checked out and the resulting git repository is
about 175MB.

Brian
