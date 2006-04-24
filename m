From: Junio C Hamano <junkio@cox.net>
Subject: Re: maintenance of cache-tree data
Date: Mon, 24 Apr 2006 15:34:35 -0700
Message-ID: <7vk69e61s4.fsf@assigned-by-dhcp.cox.net>
References: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net>
	<7vodyrdas9.fsf@assigned-by-dhcp.cox.net>
	<7v8xpvd69s.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvesz8r8o.fsf@assigned-by-dhcp.cox.net>
	<7vodyq64p7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Apr 25 00:35:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY9dq-0001Nu-UI
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 00:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWDXWek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 18:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWDXWej
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 18:34:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54176 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751340AbWDXWeh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 18:34:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424223436.OCDZ15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Apr 2006 18:34:36 -0400
To: git@vger.kernel.org
In-Reply-To: <7vodyq64p7.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 24 Apr 2006 14:31:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19112>

Junio C Hamano <junkio@cox.net> writes:

> The number one reason was because the current index file format
> is pretty dense, and I did not find an obvious hole in the
> front, in the middle or at the tail to sneak extra data in
> without upsetting existing code and without updating index file
> version.

Well, I was blind ;-).  As long as the whole-file SHA1 matches,
read_cache() does not care if we have extra data after the
series of active_nr cache entry data in the index file.

I'm working on a patch now.
