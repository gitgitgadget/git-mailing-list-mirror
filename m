From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Problem compiling git-1.6.4 on OpenServer 6.0
Date: Fri, 07 Aug 2009 15:53:18 -0500
Message-ID: <cY-iS6BS6knyjPKeVQI3ZIsIw3A3y5VK1oW-MNzUUztRn8CbeqRdew@cipher.nrlssc.navy.mil>
References: <alpine.LNX.2.00.0908071326250.13290@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:54:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZWRp-00015B-3r
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933901AbZHGUxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 16:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933883AbZHGUxW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:53:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57641 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbZHGUxV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:53:21 -0400
Received: by mail.nrlssc.navy.mil id n77KrJ6c027246; Fri, 7 Aug 2009 15:53:19 -0500
In-Reply-To: <alpine.LNX.2.00.0908071326250.13290@suse104.zenez.com>
X-OriginalArrivalTime: 07 Aug 2009 20:53:19.0138 (UTC) FILETIME=[17E29820:01CA17A1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125225>

Boyd Lynn Gerber wrote:
> Hello,
> 
> I just tried to compile the latest git and I get this error.
> 
> CC builtin-pack-objects.o
> UX:acomp: ERROR: "builtin-pack-objects.c", line 1602: integral constant
> expression expected
> gmake: *** [builtin-pack-objects.o] Error 1
> 
> I will look into it when I have a bit more time, but this is a heads up.

Did you set THREADED_DELTA_SEARCH=1 when you compiled?  That could be the
problem.

Line 1602 of builtin-pack-objects.c is wrapped in #ifdef THREADED_DELTA_SEARCH,
so it is only compiled if THREADED_DELTA_SEARCH has been set.  Also, it's not
a new line, it has been around since 2007.

-brandon
