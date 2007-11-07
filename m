From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 7 Nov 2007 14:51:01 -0600
Message-ID: <20071107205101.GE6212@lavos.net>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com> <Pine.LNX.4.64.0711071110040.4362@racer.site> <20071107145434.GB6768@mediacenter.austin.rr.com> <Pine.LNX.4.64.0711071501270.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iprrx-0008HJ-Uf
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbXKGUvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbXKGUvF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:51:05 -0500
Received: from mxsf02.insightbb.com ([74.128.0.63]:34602 "EHLO
	mxsf02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbXKGUvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 15:51:04 -0500
X-IronPort-AV: E=Sophos;i="4.21,386,1188792000"; 
   d="scan'208";a="96262801"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.124])
  by mxsf02.insightbb.com with ESMTP; 07 Nov 2007 15:51:02 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAHy0MUdKhvkY/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,386,1188792000"; 
   d="scan'208";a="131742049"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav00.insightbb.com with ESMTP; 07 Nov 2007 15:51:02 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id E4725309F21; Wed,  7 Nov 2007 14:51:01 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711071501270.4362@racer.site>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63859>

On Wed, Nov 07, 2007 at 03:04:52PM +0000, Johannes Schindelin wrote:
> I do count them.  Personally, I find it highly distracting and ugly.  
> Besides, we have the convention of putting the "}" not into the same line 
> as "else".  (See keyword "uncuddling" in the list archives.)

I was under the impression that Git followed the kernel coding standards,
which seem to want "cuddled" else statements:

136 Note that the closing brace is empty on a line of its own, _except_ in
137 the cases where it is followed by a continuation of the same statement,
138 ie a "while" in a do-statement or an "else" in an if-statement, like
139 this:
140 
141         do {
142                 body of do-loop
143         } while (condition);
144 
145 and
146 
147         if (x == y) {
148                 ..
149         } else if (x > y) {
150                 ...
151         } else {
152                 ....
153         }
154 
155 Rationale: K&R.

Searching the MARC list archives for "uncuddling" only yields the message
I am replying to.

In addition, the kernel style seems to want braces for all branches of
a conditional if any branch needs it:

163 Do not unnecessarily use braces where a single statement will do.
164 
165 if (condition)
166         action();
167 
168 This does not apply if one branch of a conditional statement is a single
169 statement. Use braces in both branches.
170 
171 if (condition) {
172         do_this();
173         do_that();
174 } else {
175         otherwise();
176 }

This makes sense (to me), as at most you're only adding one extra line
for the final closing brace, and it makes the whole conditional look more
"balanced", IMHO.

But regardless, whatever the actual style for Git should be followed.
Life's too short for arguments about coding style (even if divergence
from K&R brace style is just plain wrong.  :)

-bcd
