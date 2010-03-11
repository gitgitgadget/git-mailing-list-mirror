From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Thu, 11 Mar 2010 18:40:37 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1003111838260.29993@cone.home.martin.st>
References: <20100311163715.GE7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 17:41:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NplRj-0000b0-2R
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 17:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227Ab0CKQlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 11:41:09 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:55120 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933196Ab0CKQlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 11:41:07 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi2.inet.fi (8.5.014)
        id 4B17EFA6041BFB51; Thu, 11 Mar 2010 18:41:01 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <20100311163715.GE7877@thor.il.thewrittenword.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141986>

On Thu, 11 Mar 2010, Gary V. Vaughan wrote:

> Many of our supported platforms do not have this declaration, for
> example solaris2.6 thru 2.7.  Lack of ss_family implies no IPV6
> support, so we can wrap all the ss_family references in an ifndef
> NO_IPV6, and assume sockaddr_in otherwise.

While this probably is ok as such, you can actually do the same without 
accessing the sockaddr_storage->ss_family; just cast it to (const struct 
sockaddr*) and use ->sa_family instead, that should work just as well, as 
far as I know.

// Martin
