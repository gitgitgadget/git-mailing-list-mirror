From: Junio C Hamano <junkio@cox.net>
Subject: Re: Smart fetch via HTTP?
Date: Tue, 15 May 2007 17:38:34 -0700
Message-ID: <7vlkfphab9.fsf@assigned-by-dhcp.cox.net>
References: <20070515201006.GD3653@efreet.light.src>
	<20070515232946.GR3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 16 02:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho7Xu-0005Du-Ri
	for gcvg-git@gmane.org; Wed, 16 May 2007 02:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758688AbXEPAig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 20:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760024AbXEPAig
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 20:38:36 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57814 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758688AbXEPAif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 20:38:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516003835.BVTY22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 20:38:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zcea1W00X1kojtg0000000; Tue, 15 May 2007 20:38:35 -0400
In-Reply-To: <20070515232946.GR3141@spearce.org> (Shawn O. Pearce's message of
	"Tue, 15 May 2007 19:29:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47398>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Jan Hudec <bulb@ucw.cz> wrote:
>> Did anyone already think about fetching over HTTP working similarly to the
>> native git protocol?
>
> No work has been done on this (that I know of) but I've discussed
> it to some extent with Simon 'corecode' Schubert on #git, and I
> think he also brought it up on the mailing list not too long after.
>
> I've certainly thought about adding some sort of pack-objects
> frontend into gitweb.cgi for this exact purpose.  It is really
> quite easy, except for the negotation of what the client has.  ;-)
>  
>> Than a question is how to implement it. The current protocol is stateful on
>> both sides, but the stateless nature of HTTP more or less requires the
>> protocol to be stateless on the server.
>> 
>> I think it would be possible to use basically the same protocol as now, but
>> make it stateless for server. That is server first sends it's heads and than
>> client repeatedly sends all it's wants and some haves until the server acks
>> all of them and sends the pack.
>
> I think Simon was talking about doubling the number of haves the
> client sends in each request.  So the client POSTs initially all
> of its current refs; then current refs and their parents; then 4
> commits back, then 8, etc.  The server replies to each POST request
> with either a "send more please" or the packfile.

I kinda' like the bundle suggestion ;-)
