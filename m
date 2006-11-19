X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 13:14:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611191310430.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net> <20061118184345.GO7201@pasky.or.cz>
 <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net> <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
 <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
 <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
 <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
 <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org> <7vbqn38831.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 21:14:50 +0000 (UTC)
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqn38831.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31864>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gltzx-00005M-OM for gcvg-git@gmane.org; Sun, 19 Nov
 2006 22:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933301AbWKSVOm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 16:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933316AbWKSVOm
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 16:14:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37087 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S933301AbWKSVOl (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 16:14:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJLEZix009100
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 19
 Nov 2006 13:14:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJLEYpN018179; Sun, 19 Nov
 2006 13:14:34 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Junio C Hamano wrote:
> 
> Did you do this "if (isspace(*line)) return NULL" to have
> extensibility later, I wonder...

No, but I try to have a policy of not accepting anything that is even 
slightly questionable, so it was unintentional in the details but a result 
of a higher-level principle..

Of course, even when I wrote it I _also_ knew that I should check 
everything else too (not just the first character), but I was lazy. That 
would have been even better - then we could have made the thing be 
something like

	<sha1><space><name>[<space><sha1-of-deref>]*

instead.

