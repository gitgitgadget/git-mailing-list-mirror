From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/3] compat: add a basename() compatibility function
Date: Sat, 30 May 2009 21:53:06 -0700
Message-ID: <7vbpp9vpot.fsf@alter.siamese.dyndns.org>
References: <1243744675-24160-1-git-send-email-davvid@gmail.com>
	<1243744675-24160-2-git-send-email-davvid@gmail.com>
	<20090531044246.GA23995@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	markus.heidelberg@web.de, jnareb@gmail.com, j.sixt@viscovery.net
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 06:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAd2q-0002lR-0i
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 06:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbZEaExH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 00:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbZEaExG
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 00:53:06 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44887 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbZEaExF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 00:53:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090531045307.KVXV17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 31 May 2009 00:53:07 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id y4t61b0084aMwMQ044t6F4; Sun, 31 May 2009 00:53:06 -0400
X-Authority-Analysis: v=1.0 c=1 a=V6L6WKzXWwcA:10 a=zFzZuLfcIjMA:10
 a=pGLkceISAAAA:8 a=7T5gBokLzu-WvT_TqOgA:9 a=VQHzNcV67OygNvaznJQY4DPngTcA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090531044246.GA23995@gmail.com> (David Aguilar's message of "Sat\, 30 May 2009 21\:42\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120379>

David Aguilar <davvid@gmail.com> writes:

>> +#ifdef USE_WIN32_FS
>> +	/* Skip over the disk name in MSDOS pathnames. */
>> +	if (isalpha(path[0]) && path[1] == ':')
>> +		path += 2;
>> +#endif
>
> Thanks for bearing through this series everyone.. ;)
>
> Can someone with better win32 knowledge let me know if the
> USE_WIN32_FS stuff is needed for msysgit?
>
> I would really like it if there was a way to do without the
> #define.

Isn't this essentially the same as has_dos_drive_prefix()?
