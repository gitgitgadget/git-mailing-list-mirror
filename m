From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Mon, 02 Oct 2006 21:19:57 -0700
Message-ID: <7vpsdat4ia.fsf@assigned-by-dhcp.cox.net>
References: <7vwt7k4clr.fsf@assigned-by-dhcp.cox.net>
	<20061002192930.86293.qmail@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 06:20:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUblZ-0006Oi-2p
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 06:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWJCET7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 00:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWJCET7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 00:19:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:48572 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965092AbWJCET6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 00:19:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003041957.GCSB6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 00:19:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VgL01V0041kojtg0000000
	Tue, 03 Oct 2006 00:20:00 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061002192930.86293.qmail@web31803.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 2 Oct 2006 12:29:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28245>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>
>> Instead of labelling each and every line with clickable commit
>> object name, this makes the blame output to show them only on
>> the first line of each group of lines from the same revision.
>> 
>> Also it makes mouse-over to show the minimum authorship and
>> authordate information for extra cuteness ;-).
>> 
>> Signed-off-by: Junio C Hamano <junkio@cox.net>
>> ---
>
> ACK.  Please commit.

Won't, at least as its current shape.  Somebody privately
mentioned that the code risks slurping the entire file in the
@chunk if it is untouched since the initial import, which is not
what we want.

The memory consumption worries aside, that would make the
clickable commit object name to appear only very at the
beginning of the page and would make it inconvenient to actually
visit the commit after scrolling down to see later lines.

It might become usable if it is given a cap to limit the number
of lines to put in a chunk.  I dunno.
