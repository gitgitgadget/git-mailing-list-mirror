From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 5/11] git-applypatch: Usage string clean-up,
 emit usage string at incorrect invocation
Date: Wed, 14 Dec 2005 14:45:42 +0200
Message-ID: <20051214144542.0a509e3e.tihirvon@gmail.com>
References: <11345130302438-git-send-email-freku045@student.liu.se>
 <11345130311492-git-send-email-freku045@student.liu.se>
 <7vfyow45l2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: freku045@student.liu.se, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 13:46:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmW1A-0001N8-ST
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 13:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVLNMpx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 07:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLNMpx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 07:45:53 -0500
Received: from marski.suomi.net ([212.50.131.142]:57234 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S932283AbVLNMpx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 07:45:53 -0500
Received: from spartak.suomi.net (spartak.suomi.net [212.50.140.227])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IRH00MQENG9XD30@marski.suomi.net> for git@vger.kernel.org;
 Wed, 14 Dec 2005 14:45:49 +0200 (EET)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IRH004ZANM3QN50@mailstore.suomi.net>; Wed,
 14 Dec 2005 14:49:16 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam2.suomi.net (Postfix) with SMTP id ED68911B6FA; Wed,
 14 Dec 2005 14:45:42 +0200 (EET)
In-reply-to: <7vfyow45l2.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.354,	required 5,
 autolearn=not spam, AWL 0.24, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13629>

On Tue, 13 Dec 2005 21:20:57 -0800
Junio C Hamano <junkio@cox.net> wrote:

> freku045@student.liu.se writes:
> 
> >  . git-sh-setup
> >  
> > +[[ "$#" = "3" || "$#" = "4" ]] || usage
> > +
> 
> I do not see much advantage to use [[...]] construct here.

[[ ]] is bashishm. Does not work with ash.


test $# -ge 3 && test $# -le 4 || usage

You don't need to quote $# because it is always defined (and always
non-negative integer).  You can't unset or set it.

-- 
http://onion.dynserv.net/~timo/
