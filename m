From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit --amend -m "..." complains?!?
Date: Wed, 01 Aug 2007 10:18:12 -0700
Message-ID: <7v8x8v5g2z.fsf@assigned-by-dhcp.cox.net>
References: <86643znxgz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:18:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHpx-0003HD-OY
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 19:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757640AbXHARSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 13:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756816AbXHARSP
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 13:18:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58452 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019AbXHARSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 13:18:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801171814.IDA23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 13:18:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WhJC1X00d1kojtg0000000; Wed, 01 Aug 2007 13:18:13 -0400
In-Reply-To: <86643znxgz.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Wed, 01 Aug 2007 16:25:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54456>

David Kastrup <dak@gnu.org> writes:

> I get
>
> Option -m cannot be combined with -c/-C/-F/--amend.
>
> but that makes no sense: of course there is ample reason for providing
> an amended commit message on the command line.  -c, -C and -F indeed
> all provide an alternative commit message, but --amend doesn't.

The option --amend is about "reusing the original commit message
and make amending edit on top".  If you are restarting the
message from scratch, --amend does not make much sense.

You can do:

	$ git reset HEAD^
        $ git commit -m "blah"

if you do not want to reuse the commit message.
