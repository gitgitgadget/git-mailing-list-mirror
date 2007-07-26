From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in gitk search box
Date: Wed, 25 Jul 2007 19:54:44 -0700
Message-ID: <7vtzrrc1sb.fsf@assigned-by-dhcp.cox.net>
References: <20070725135621.GC21692@lavos.net>
	<18087.60033.676105.538784@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bdowning@lavos.net (Brian Downing), git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 04:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDtV3-0001MP-Nc
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 04:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbXGZCyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 22:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbXGZCyq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 22:54:46 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48163 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbXGZCyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 22:54:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726025445.BYKH1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Jul 2007 22:54:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U2uk1X00N1kojtg0000000; Wed, 25 Jul 2007 22:54:45 -0400
In-Reply-To: <18087.60033.676105.538784@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Thu, 26 Jul 2007 10:27:45 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53748>

Paul Mackerras <paulus@samba.org> writes:

> It turns out that this problem crept in when I changed from using git
> rev-list --header to git log -z --pretty=raw, and the thing that
> causes it is that git rev-list puts a null character after every
> commit, while git log only puts a null between commits, i.e., there
> isn't a null after the last commit.
>
> Junio, is this behaviour deliberate?

There was a recent message from Linus on the list, stating that
NUL in -z format is inter-record separator, not after-record
terminator.
