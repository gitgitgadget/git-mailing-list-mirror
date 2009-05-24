From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/18] http*: move common variables and macros to http.[ch]
Date: Sun, 24 May 2009 13:43:47 -0700
Message-ID: <7vljomtenw.fsf@alter.siamese.dyndns.org>
References: <20090524221951.df5151bb.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 22:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8KYA-0002Ux-CN
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 22:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbZEXUnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbZEXUnq
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 16:43:46 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38333 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbZEXUnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 16:43:46 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204347.MWPK20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Sun, 24 May 2009 16:43:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vYjn1b0014aMwMQ04YjnXS; Sun, 24 May 2009 16:43:47 -0400
X-Authority-Analysis: v=1.0 c=1 a=s-inqTTq_48A:10 a=03c_yN3x3o4A:10
 a=pGLkceISAAAA:8 a=RXb5UN1cxIrG3xT4iosA:9 a=vTPqA3Zo7ZfE4nD-aOnq3XpyxkwA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119856>

Tay Ray Chuan <rctay89@gmail.com> writes:

>  *RANGE_HEADER_SIZE has been moved to http.h.
>
>  *the curl header list, no_pragma_header, containing the header
>   "Pragma:", has been created in http.[ch]. It is allocated in
>   http_init, and freed in http_cleanup. It replaces the similarly-named
>   variable in http-push.c, and the no_pragma_header member in
>   walker_data in http-walker.c.
>
>  *the variable http_is_verbose is created. It is intended for use by
>   methods in http.c, and is modified at the entry points of http.c's
>   users, namely http-push.c (when parsing options) and http-walker.c
>   (in get_http_walker).

Again, style fix.

	Move RANGE_HEADER_SIZE to http.h

	Create the curl header list, no_pragma_header, containing the
	header "Pragma:" in http.[ch].  Allocate it in http_init(), and
	free it in http_cleanup(). ...

	Add http_is_verbose variable in http.c. ...

I wonder if RANGE_HEADER_SIZE should be renamed to be more specific to
http, but in later stages you will make it an internal implementation
detail contained in http.c so it should be Ok.
