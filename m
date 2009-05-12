From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create a new commit with the content of some commit?
Date: Tue, 12 May 2009 08:59:33 -0700
Message-ID: <7vhbzq8g7u.fsf@alter.siamese.dyndns.org>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 17:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uOJ-0006sP-CJ
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbZELP7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 11:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbZELP7e
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:59:34 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58019 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZELP7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 11:59:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512155932.RVDT17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 May 2009 11:59:32 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id qfzZ1b00U4aMwMQ03fzZJu; Tue, 12 May 2009 11:59:33 -0400
X-Authority-Analysis: v=1.0 c=1 a=POAuTgP4eycA:10 a=lHWr0x0w13sA:10
 a=pGLkceISAAAA:8 a=Bpy3ZvKqB2FE07jN2KwA:9 a=9anlp8Rd5iDR9J9cbT7BX1_epugA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com> (Ping Yin's message of "Tue\, 12 May 2009 22\:35\:30 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118908>

Ping Yin <pkufranky@gmail.com> writes:

> a----b
>  \----c
>
> Given the graph above, I want to create a commit b1 on top of c, where
> b1 and b have the same content. i.e.
>
> a----b
>  \----c----b1    ( content(b) == content(b1) )

On "c", you can:

    git read-tree -m -u b
    git commit

I think with newer git you can say

    git reset --merge b
    git commit

instead, to save some typing.
