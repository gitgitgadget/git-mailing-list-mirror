From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Fri, 06 May 2005 17:24:52 -0700
Message-ID: <7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
	<2637.10.10.10.24.1115425225.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 02:18:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUD1C-0000Sg-7F
	for gcvg-git@gmane.org; Sat, 07 May 2005 02:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVEGAY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 20:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVEGAY4
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 20:24:56 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50360 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261326AbVEGAYz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 20:24:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050507002454.VJGB19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 20:24:54 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <2637.10.10.10.24.1115425225.squirrel@linux1> (seanlkml@sympatico.ca's
 message of "Fri, 6 May 2005 20:20:25 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:

S> has_sha1_file can be reduced to:

S> int has_sha1_file(const unsigned char *sha1)
S> {
S>        return (!!find_sha1_file(sha1));
S> }

Not really.  If you do not have alternates it does not even
bother to stat so you get the path that supposed to contain the
data and you need to do the checking yourself.

