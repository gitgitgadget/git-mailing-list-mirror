From: Nicolas Pitre <nico@fluxnic.net>
Subject: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 15:28:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 21:28:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk0Mj-0003Kt-3r
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239Ab1AaU2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 15:28:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9039 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab1AaU2m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 15:28:42 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW00J45M703MA0@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 15:28:12 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165748>

To me the source tree looks highly untidy to me.

We do have subdirectories for documentation, tests, contributions, etc.  
But a sizeable part of the tree is just a big splat of source files 
dumped right in the root of the tree.

So I'd suggest doing the following:

1) Create a src/ directory and move *.c, *.h, *.sh, *.perl, *.py and 
   the builtin directory from the root directory to it.

2) Create a build/ directory, or bin/ if prefered, to hold the result of 
   the build.

3) Consider dropping the ppc/ directory.  Unless someone really cares 
   deeply, it would be nice to simply always use the block-sha1 code and 
   move it straight into src/.

4) Consider moving some more directories into src/ such as xdiff/.
   I'd leave compat/ outside src/ to make it more explicit that this is 
   not about Git proper.

5) Rename t/ to testsuite/ so this doesn't look like some garbage 
   leftover.

6) And fix up all the Makefiles to cope with the above movements.

What do you think?


Nicolas
