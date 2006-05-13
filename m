From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking branch history
Date: Fri, 12 May 2006 21:56:12 -0700
Message-ID: <7vody2v7yr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
	<Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
	<20060513034051.GA21586@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 06:56:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FemB5-0003Ck-12
	for gcvg-git@gmane.org; Sat, 13 May 2006 06:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWEME4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 00:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWEME4O
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 00:56:14 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17111 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932329AbWEME4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 00:56:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060513045613.HCFT27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 May 2006 00:56:13 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060513034051.GA21586@spearce.org> (Shawn Pearce's message of
	"Fri, 12 May 2006 23:40:51 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19926>

Shawn Pearce <spearce@spearce.org> writes:

> git-udpate-ref.  So just have it append the ref's history to a file:
>
> 	.git/log/refs/heads/$branch
>
> where the history records are stored as:
>
> 	40 byte commit-ish SHA1
> 	<SP>
> 	<committer>
> 	<LF>
>
> e.g.:
>
> 	cbb6d91d95e523c2b6a6b52577c4be28d18ace83 Shawn O. Pearce <spearce@spearce.org> 1137039378 -0500
> 	ae8c74e96a1e02bbfb7f1a9669b77d6f8ee6c3cf Shawn O. Pearce <spearce@spearce.org> 1136921470 -0500
>

Because the question we often would want to ask is "two days ago
my tip worked but today it does not", recording the timestamp
makes sense, but I do not know what the point is for the name
and e-mail.  If it is in your local repository (i.e. the program
that updates the tip ref is not receive-pack which is invoked by
your pushing into a remote repo), it will always be you.  And in
the receive-pack case, the information is not available to begin
with (you may have a UNIX UID but that is about it).
