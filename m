From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] [GITK] use "git <command>" instead of "git-<command>"
Date: Thu, 26 Jan 2006 15:26:15 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060126142615.GA12631@informatik.uni-freiburg.de>
References: <20060125075635.GB2768@informatik.uni-freiburg.de> <7v3bjcws5o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 15:26:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F284t-0000cQ-Mo
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 15:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWAZO0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 09:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWAZO0S
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 09:26:18 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:25258 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932337AbWAZO0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 09:26:17 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F284m-00041k-GE; Thu, 26 Jan 2006 15:26:16 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0QEQGGY012834;
	Thu, 26 Jan 2006 15:26:16 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0QEQF81012833;
	Thu, 26 Jan 2006 15:26:15 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3bjcws5o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15166>

Junio C Hamano wrote:
> Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:
> 
> > Otherwise gitk is not able to work with installations using a gitexecdir
> > different from bindir.
> 
> For something like gitk that lives for some time and spawns git
> number of times, it is considered a good practice to:
> 
>  (1) Run "git --exec-path" at the beginning, to learn
>      GIT_EXEC_PATH;
>  (2) Prepend that to PATH;
>  (3) And invoke "git-foo" commands in the rest of the script.
(I remember darkly that was already discussed, but I cannot find the
thread ATM.)

Just to get the patch right:
If
 - PATH=$(HOME)/bin:/usr/bin
 - GIT_EXEC_PATH=/usr/bin

then gitk should use

	PATH=/usr/bin:$(HOME)/bin:/usr/bin

to call git-<command> and

	PATH=$(HOME)/bin:/usr/bin

to call the rest, right?

Best regards
Uwe

-- 
Uwe Zeisberger

fib where fib = 0 : 1 : zipWith (+) fib (tail fib)
