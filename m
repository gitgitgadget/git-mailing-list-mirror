From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] git-prune: never lose objects reachable from our refs.
Date: Fri, 09 Dec 2005 12:38:20 -0800
Message-ID: <7vvexy2egz.fsf@assigned-by-dhcp.cox.net>
References: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
	<1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
	<7v4q5jb149.fsf@assigned-by-dhcp.cox.net>
	<7vzmnb9m7w.fsf@assigned-by-dhcp.cox.net>
	<7voe3r9krf.fsf@assigned-by-dhcp.cox.net>
	<7vmzja91gp.fsf_-_@assigned-by-dhcp.cox.net>
	<20051209193922.GA31228@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 21:41:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekp0b-0004o3-Np
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 21:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVLIUiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 15:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVLIUiX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 15:38:23 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44197 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932448AbVLIUiW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 15:38:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209203633.UVLH20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 15:36:33 -0500
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20051209193922.GA31228@ebar091.ebar.dtu.dk> (Peter Eriksen's
	message of "Fri, 9 Dec 2005 20:39:22 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13434>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> On Thu, Dec 08, 2005 at 11:25:10PM -0800, Junio C Hamano wrote:
>> Explicit <head> arguments to git-prune replaces, instead of
>> extends, the list of heads used for reachability analysis by
>> fsck-objects.  By giving a subset of heads by mistake, objects
>> reachable only from other heads can be removed, resulting in a
>> corrupted repository.
>> 
>> This commit stops replacing the list of heads, and makes the
>> command line arguments to add to them instead for safety.
>
> Shouldn't the first sentence be "Explicit <head> arguments to git-prune
> extends, instead of replaces,...", that is, interchange the words 
> extends and replaces?  Did I miss something?

Sorry, what I meant was: "before this proposed change, it
replaces instead of extends --- which means DANGER.  This
proposed change is to make things safer".
