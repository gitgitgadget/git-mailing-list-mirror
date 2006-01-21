From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] DT_UNKNOWN: do not fully trust existence of DT_UNKNOWN
Date: Sat, 21 Jan 2006 00:09:10 -0800
Message-ID: <7vpsmmt32x.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	<7voe277lbe.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0601200701n76f1d912y4671c6800735cd0d@mail.gmail.com>
	<7vzmlqaf5o.fsf@assigned-by-dhcp.cox.net>
	<20060120215314.GA4203@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 09:09:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0DoG-0005fJ-2X
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 09:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWAUIJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 03:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAUIJN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 03:09:13 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:24230 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751126AbWAUIJM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 03:09:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121080632.LBYV17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 03:06:32 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14987>

Alex Riesen <raa.lkml@gmail.com> writes:

>> +#undef DT_UNKNOWN
>> +#undef DT_DIR
>> +#undef DT_REG
>> +#undef DT_LNK
>
> yes, of course

That is technically correct but I suspect it would not matter in
practice.  The only thing you are avoiding is four compiler
warnings when compiling for Cygwin of this week (I heard this is
already fixed in Cygwin CVS).  On older Cygwin you simply would
not use NO_D_TYPE_IN_DIRENT, since d_type worked before.  No?
