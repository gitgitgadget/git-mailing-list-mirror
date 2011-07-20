From: Chris Wilson <cwilson@vigilantsw.com>
Subject: Re: [PATCH] Fix config_file file leak.
Date: Wed, 20 Jul 2011 09:12:14 -0400
Message-ID: <20110720131214.GC25822@localhost>
References: <20110714181948.GA23288@localhost>
 <4E25BEDB.6040002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 20 15:12:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjWZd-00051G-L9
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 15:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab1GTNMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 09:12:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50334 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1GTNMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 09:12:19 -0400
Received: by iyb12 with SMTP id 12so168809iyb.19
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 06:12:18 -0700 (PDT)
Received: by 10.231.211.199 with SMTP id gp7mr5589008ibb.188.1311167537989;
        Wed, 20 Jul 2011 06:12:17 -0700 (PDT)
Received: from localhost (c-67-180-177-185.hsd1.ca.comcast.net [67.180.177.185])
        by mx.google.com with ESMTPS id g10sm165413ibe.12.2011.07.20.06.12.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jul 2011 06:12:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E25BEDB.6040002@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177535>

On Tue, Jul 19, 2011 at 06:28:59PM +0100, Ramsay Jones wrote:
> Chris Wilson wrote:
> > Hi,
> > 
> > We are using Sentry (a C/C++ static analysis tool) to analyze
> > git on a nightly basis. Sentry found that a file leak
> > was recently introduced in the commit 924aaf3.
> 
> Hmmm ..., commit 924aaf3 did *not* introduce a file handle leak.
> It would seem that the change in scope of the file handle made it
> easier for Sentry to see the *existing* (potential) file handle leak.
> 
> no?

Ah yes, that does seem like that case. Thanks for pointing that out.

> Other than that, ...

Looks like this file handle will leak whenever a write fails.

Chris
