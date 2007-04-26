From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-svn: Don't rely on $_ after making a function call
Date: Wed, 25 Apr 2007 19:11:48 -0700
Message-ID: <864pn3hokb.fsf@blue.stonehenge.com>
References: <11775270321427-git-send-email-aroben@apple.com>
	<20070425205948.GA12375@untitled>
	<7v4pn4w41k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, Adam Roben <aroben@apple.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 04:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgtSa-00062i-Fw
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbXDZCLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754632AbXDZCLt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:11:49 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:4878 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbXDZCLs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:11:48 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 21F7D1DE4C3; Wed, 25 Apr 2007 19:11:48 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.4.13; tzolkin = 4 Ben; haab = 1 Uo
In-Reply-To: <7v4pn4w41k.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 25 Apr 2007 14:13:43 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45596>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> I suspect Merlyn has better explanation, but...

Junio>      for (list) {
Junio> 	...	
Junio>      }

Junio> loop implicitly localizes $_ and does not share this problem,
Junio> which I really appreciate whenever I am writing Perl code, but
Junio> often enough I was bitten by scripts that use "while (<$fh>)",
Junio> which does not localizes $_, and made hard to spot bugs by
Junio> clobbering $_.

Junio> I find the patch a good safety measure for any future breakages.

I'm happy with the patch.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
