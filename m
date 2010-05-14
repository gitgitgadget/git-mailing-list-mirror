From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v5 01/18] Makefile: pass CPPFLAGS through to fllow
 customization
Date: Fri, 14 May 2010 11:04:59 +0000
Message-ID: <robbat2-20100514T110034-766521339Z@orbis-terrarum.net>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100514093725.884968000@mlists.thewrittenword.com>
 <robbat2-20100514T094909-157386852Z@orbis-terrarum.net>
 <20100514105832.GB31921@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 14 13:05:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCshh-0005LS-Qd
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 13:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075Ab0ENLFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 07:05:09 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:51197 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754512Ab0ENLFH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 07:05:07 -0400
Received: (qmail 7777 invoked from network); 14 May 2010 11:05:03 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Fri, 14 May 2010 11:05:02 +0000
Received: (qmail 1482 invoked by uid 10000); 14 May 2010 11:04:59 -0000
Content-Disposition: inline
In-Reply-To: <20100514105832.GB31921@thor.il.thewrittenword.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147082>

On Fri, May 14, 2010 at 10:58:32AM +0000, Gary V. Vaughan wrote:
> As a matter of fact, Automake even jumps through hoops with
> AM_CPPFLAGS to make sure that the package maintainer doesn't
> accidentally trample over the package builder's CPPFLAGS settings - I
> can't think of a scenario where the person who writes the build system
> for a package knows more about what CPPFLAGS the person who builds it
> will need that the person doing the actual building.
AM_CFLAGS != AM_CPPFLAGS. My concern was the mixing of them.

IIRC the correct direction was that all CPPFLAGS should be valid CFLAGS,
but not all valid CFLAGS are valid CPPFLAGS (depending on your cpp, they
might be passed to other layers).

> I'm pretty sure I'm missing the point though, since letting the
> package builder choose their own CPPFLAGS has been at the core of
> building Unix packages for as long as I can remember...
As a middle ground:
CFLAGS = $(OPTCFLAGS) -Wall
CPPFLAGS = $(OPTCPPFLAGS)
LDFLAGS = $(OPTLDFLAGS)
CC = $(OPTCC)
AR = $(OPTAR)

(and pass them suitably to the various binaries).

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
