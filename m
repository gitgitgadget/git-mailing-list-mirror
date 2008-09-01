From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH v2] Improve portability: Cast pid_t's to intmax_t
Date: Mon, 01 Sep 2008 04:28:01 -0400
Message-ID: <20080901082801.29621.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: sn_@gmx.net, linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 10:36:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka4t6-0003Mn-6U
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 10:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbYIAIeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 04:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbYIAIen
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 04:34:43 -0400
Received: from science.horizon.com ([192.35.100.1]:14014 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753476AbYIAIen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 04:34:43 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Sep 2008 04:34:42 EDT
Received: (qmail 29622 invoked by uid 1000); 1 Sep 2008 04:28:01 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94543>

This seems rather pointless.  Whatever Solaris thinks, I really doubt
that process IDs will ever overflow an int, which is 32 bits on all
machines that will ever support more than 32k processes.

You can be paranoid if you like and cast to long, but I don't think
even a massive 64-bit cluster is likely to have more than 2G processes
in the forseeable future.

I'd support a cast to int or unsigned, or a cast to long as a second choice.

Using uintmax_t is formally correct, but practically pointless clutter.
