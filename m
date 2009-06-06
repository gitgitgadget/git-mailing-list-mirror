From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Sat, 06 Jun 2009 10:24:05 -0700
Message-ID: <7viqj9e0ne.fsf@alter.siamese.dyndns.org>
References: <200905122329.15379.jnareb@gmail.com>
	<200906031121.38616.jnareb@gmail.com>
	<20090603144837.GE3355@spearce.org>
	<200906031851.12160.jnareb@gmail.com>
	<20090603165613.GJ3355@spearce.org>
	<d411cc4a0906060933m4f27c40eoaa2b81f983adc177@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 19:24:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCzcs-00025m-FT
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 19:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbZFFRYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 13:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbZFFRYF
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 13:24:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52190 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbZFFRYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 13:24:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090606172407.WNJG17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jun 2009 13:24:07 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 0hQ61c00B4aMwMQ04hQ6oy; Sat, 06 Jun 2009 13:24:06 -0400
X-VR-Score: -80.00
X-Authority-Analysis: v=1.0 c=1 a=1cH15jnNZHcA:10 a=8-WIN01VSTQA:10
 a=pGLkceISAAAA:8 a=TSbVqHtbAAAA:8 a=Vn_Guy3Z3dukeN0l8-EA:9
 a=AbYH55Jvry29xUgBZlbiX4FKePMA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <d411cc4a0906060933m4f27c40eoaa2b81f983adc177@mail.gmail.com> (Scott Chacon's message of "Sat\, 6 Jun 2009 09\:33\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120926>

Scott Chacon <schacon@gmail.com> writes:

> I'm trying to take this whole thread and actually write an RFC style
> document for all of this stuff, but I'm still unclear on the .have
> portion of the conversation.  Pointing me to an earlier relevant
> thread in the Git mailing list would be fine, too - it's difficult to
> search for '.have' usefully.

The actual patch series is this.

    http://thread.gmane.org/gmane.comp.version-control.git/95351

The thread the patch series's cover letter refers as "the topic discussed
earlier" is this.

    http://thread.gmane.org/gmane.comp.version-control.git/95072/focus=95256

Here is how people can dig this, for people's reference.

 (1) Where in the code is this feature implemented?

     $ git grep -n -e '\.have' -- '*.c'
     builtin-receive-pack.c:647:             add_extra_ref(".have",...
     connect.c:87:               name_len == 5 && !memcmp(".have", ...

 (2) When was it added?

     $ git blame -L 645,650 builtin-receive-pack.c
     d79796bc (Junio C Hamano 2008-09-09 01:27:10 -0700 645)              ex
     d79796bc (Junio C Hamano 2008-09-09 01:27:10 -0700 646)              ex
     d79796bc (Junio C Hamano 2008-09-09 01:27:10 -0700 647)                
     d79796bc (Junio C Hamano 2008-09-09 01:27:10 -0700 648)         }
     d79796bc (Junio C Hamano 2008-09-09 01:27:10 -0700 649)         transpo
     d79796bc (Junio C Hamano 2008-09-09 01:27:10 -0700 650)         free(ot
  
 (3) Go to http://news.gmane.org/gmane.comp.version-control.git/ and page
     back to the timeframe:
