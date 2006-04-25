From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] add 'prior' link in commit structure
Date: Mon, 24 Apr 2006 22:18:42 -0700
Message-ID: <7vpsj62pxp.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<20060425043106.18382.24344.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 25 07:18:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFwm-0006BT-7Y
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 07:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWDYFSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 01:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWDYFSp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 01:18:45 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7075 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932097AbWDYFSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 01:18:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425051843.FOOH9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 01:18:43 -0400
To: git@vger.kernel.org
In-Reply-To: <20060425043106.18382.24344.stgit@localhost.localdomain> (Sam
	Vilain's message of "Tue, 25 Apr 2006 16:31:06 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19129>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> For now this is just recorded as a char* pointer, as it is not an
> error condition for the commit not to be present locally.

Object ancestry is parsed lazily, so you should not have to do this.
Just point at another commit if you are to have only one (I
recommend against it) or have another commit_list, but when you
instantiate you may want to have a flag in the commit object
itself that says "this need not exist".
