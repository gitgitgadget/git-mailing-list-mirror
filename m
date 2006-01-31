From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix HTTP request result processing after slot reuse
Date: Tue, 31 Jan 2006 13:39:01 -0800
Message-ID: <7v64o0ulfu.fsf@assigned-by-dhcp.cox.net>
References: <20060131190655.GE3873@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 22:39:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43DO-0006C0-JN
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 22:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWAaVjD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 16:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWAaVjD
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 16:39:03 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43741 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751524AbWAaVjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 16:39:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131213803.PRG3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 16:38:03 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060131190655.GE3873@reactrix.com> (Nick Hengeveld's message of
	"Tue, 31 Jan 2006 11:06:55 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15350>

Nick Hengeveld <nickh@reactrix.com> writes:

> Add a way to store the results of an HTTP request when a slot finishes
> so the results can be processed after the slot has been reused.
>
> Signed-off-by: Nick Hengeveld <nickh@reactrix.com>

I do not claim I understand this part of the code well, but it
feels awkward to see that a problem caused by a structure being
reused can be solved by having a pointer from that structure
that points at a static location.

These static variables are probably correct, provided if
fetch_index, fetch_indices and friends do not recurse into
themselves, but it just gives me this funny feeling...

Care to enlighten me, please?
