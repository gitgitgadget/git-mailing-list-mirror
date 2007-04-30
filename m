From: Junio C Hamano <junkio@cox.net>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch content
Date: Mon, 30 Apr 2007 15:18:50 -0700
Message-ID: <7vtzuxbj5h.fsf@assigned-by-dhcp.cox.net>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
	<87y7kdo6pn.wl%cworth@cworth.org>
	<7vps5pl3jl.fsf@assigned-by-dhcp.cox.net>
	<873b2ho73n.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue May 01 00:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HieD9-0005kF-C4
	for gcvg-git@gmane.org; Tue, 01 May 2007 00:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423740AbXD3WS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 18:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423747AbXD3WS7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 18:18:59 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52538 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423740AbXD3WSv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 18:18:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430221851.BHLF1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 18:18:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id taJq1W0061kojtg0000000; Mon, 30 Apr 2007 18:18:50 -0400
In-Reply-To: <873b2ho73n.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	30 Apr 2007 15:00:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45882>

Carl Worth <cworth@cworth.org> writes:

> On Fri, 27 Apr 2007 17:56:46 -0700, Junio C Hamano wrote:
>> ...
>>                                      I would like to know if
>> you have or do not have problem with base64 ones, as that is
>> what indicates your opinion on making --attach unconditionally
>> do base64 which was the suggestion made in the thread.
>
> I definitely have a problem with base64-encoded patches.

Thanks, and I agree with everything you said why base64 is
inconvenient.  So _if_ somebody does an enhancement to do
base64, it needs to be a separate option.

Honestly speaking, though, I think that kind of "attachment"
should be left to MUA, not format-patch.  If somebody knows his
MUA has a tendency to corrupt in-line text, tell the MUA to
attach the format-patch output stored in the filesystem as an
application/octet-stream attachment.  MUA may or may not do
base64 or QP but at that point the only thing the user cares
about is a byte-for-byte faithful reproduction at the
recipient's end, and he does not worry a whit about
readability), so either base64 or QP would suffice.  And the
format-patch does not have to care.
