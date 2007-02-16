From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for disconnected transfer
Date: Thu, 15 Feb 2007 23:31:51 -0800
Message-ID: <7v4ppma788.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0702151838250.20368@woody.linux-foundation.org>
	<11716079211954-git-send-email-mdl123@verizon.net>
	<20070216064852.GF28894@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 08:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHxZa-0001Nr-GU
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 08:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXBPHbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 02:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbXBPHbx
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 02:31:53 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53785 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbXBPHbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 02:31:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216073152.SRQJ21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 02:31:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q7Xr1W0051kojtg0000000; Fri, 16 Feb 2007 02:31:52 -0500
In-Reply-To: <20070216064852.GF28894@spearce.org> (Shawn O. Pearce's message
	of "Fri, 16 Feb 2007 01:48:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39897>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Mark Levedahl <mdl123@verizon.net> wrote:
>> +        # update only if non-fastforward
>> +        local=$(git-rev-parse --verify "$ref^0" 2>/dev/null)
>> ...
>> +        git-update-ref -m "git-unbundle update" $ref $sha1
>
> What about passing $local as the final argument to update-ref,
> so that the ref won't be modified if someone changed it while
> an unbundle was running?  Sure its mostly a manual operation,
> but imagine running it on a bare repository while someone else
> is pushing into it...

The script already has $local at that point, so adding it to
update-ref is a no-cost change to make things safer.  I think it
makes sense.

But I have to wonder...  While someone else is _pushing_ into
it?  Why are _you_ sneakernetting, then?
