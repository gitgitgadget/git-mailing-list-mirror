From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH] entry.c: Use strerror() to print error info when
 possible
Date: Sun, 15 Apr 2007 20:54:33 -0300
Organization: Mandriva
Message-ID: <20070415205433.3b475f60@gnut>
References: <20070415185619.3fa90f3a@gnut>
	<7v7isd2qq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:55:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEZ1-00030p-Vn
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbXDOXym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbXDOXym
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:54:42 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:60589 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbXDOXyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:54:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 81ED218B6B;
	Sun, 15 Apr 2007 20:54:39 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id WRgI8LzM15iC; Sun, 15 Apr 2007 20:54:37 -0300 (BRT)
Received: from gnut (unknown [201.21.180.171])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 7072218B67;
	Sun, 15 Apr 2007 20:54:36 -0300 (BRT)
In-Reply-To: <7v7isd2qq0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44551>

Em Sun, 15 Apr 2007 15:54:47 -0700
Junio C Hamano <junkio@cox.net> escreveu:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
| writes:
| 
| > Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
| > ---
| >  entry.c |   11 ++++++-----
| >  1 files changed, 6 insertions(+), 5 deletions(-)
| >
| > diff --git a/entry.c b/entry.c
| > index d72f811..c36c09d 100644
| > --- a/entry.c
| > +++ b/entry.c
| > @@ -19,7 +19,8 @@ static void create_directories(const char *path, struct checkout *state)
| >  				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
| >  					continue; /* ok */
| >  			}
| > -			die("cannot create directory at %s", buf);
| > +			die("cannot create directory at %s (%s)", buf,
| > +			    strerror(errno));
| >  		}
| >  	}
| >  	free(buf);
| 
| This hunk is wrong; stat() you see in the context could have
| been what failed the last before this die().

 You right, will try to read the code more carefully before
patching.

| I do not think other places you patched do not share the issue.

 Other places seems ok, I'll review and re-send along with other
patches I'm working on.

 Thanks a lot for the feedback.
