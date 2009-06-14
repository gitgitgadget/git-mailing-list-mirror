From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: add --filename-prefix to prepend a prefix to output file names
Date: Sun, 14 Jun 2009 01:59:01 -0700
Message-ID: <7vd497qjhm.fsf@alter.siamese.dyndns.org>
References: <7vr5xsozcm.fsf@alter.siamese.dyndns.org>
	<1244963400-1739-1-git-send-email-pclouds@gmail.com>
	<4A34B4ED.6060301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:59:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFlYV-0007e0-7Z
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 10:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbZFNI7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 04:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbZFNI7A
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 04:59:00 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:32947 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZFNI67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 04:58:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090614085901.YPMB18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 14 Jun 2009 04:59:01 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3kz11c0064aMwMQ04kz1r5; Sun, 14 Jun 2009 04:59:01 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=0x9OhrcHy5gA:10 a=yTbM2EVNuUQA:10
 a=pGLkceISAAAA:8 a=w1TFlc0t8Cn8SpxyGn8A:9 a=Anpq4vMXKS9fSIDM_pyaRbZYVkEA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A34B4ED.6060301@gmail.com> (Stephen Boyd's message of "Sun\, 14 Jun 2009 01\:29\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121548>

Stephen Boyd <bebarino@gmail.com> writes:

> Also, this doesn't replace the numbering (0001, 0002, etc.) which I
> consider to be a prefix. Does anyone else feel the same way?

Isn't the point of the exercise to come up with something like:

      frotz-0001-first-patch-in-frotz-topic.patch
      frotz-0002-second-patch-in-frotz-topic.patch
      frotz-0003-third-patch-in-frotz-topic.patch

      nitfol-0001-first-patch-in-nitfol-topic.patch
      nitfol-0002-second-patch-in-nitfol-topic.patch

with two invocations of format-patch, and when they are dropped in the
same directory, the patches from the same series clump together?

I personally do not think this is worth the additional code (you can
easily run with --outdir=frotz and then with --outdir=nitfol and obtain
frotz/000?-*.patch and nitfol/000?-*.patch to get the same clumping) but
if the convention is to use dash instead of slash, the patch will save one
step from users.
