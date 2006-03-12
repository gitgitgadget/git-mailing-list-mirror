From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 11:20:27 -0800
Message-ID: <4414747B.7040700@gmail.com>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org> <slrne18of5.fr9.mdw@metalzone.distorted.org.uk>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 20:20:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIW7Q-0007sz-Nc
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 20:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWCLTUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 14:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCLTUi
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 14:20:38 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:51281 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbWCLTUi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 14:20:38 -0500
Received: by wproxy.gmail.com with SMTP id 57so469065wri
        for <git@vger.kernel.org>; Sun, 12 Mar 2006 11:20:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZZRlQPp9RpnTi3LnWfQzY3UCLQSr0nOj5bYKtqSz8AGDE+fFu6RMyEJ/rGUNPFAoue6us+bAGAi5eJRtiO8XjOc4vocFNgYZNMfqZeSL0A8E1Ir9fW4g0ONgWEVbFEj9wn+MfKlRcKLP8layexS12cJFhvZivLRoxjrgfZHo3jw=
Received: by 10.54.140.6 with SMTP id n6mr1091466wrd;
        Sun, 12 Mar 2006 11:20:37 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.67.7])
        by mx.gmail.com with ESMTP id 64sm119518wra.2006.03.12.11.20.36;
        Sun, 12 Mar 2006 11:20:37 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne18of5.fr9.mdw@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17524>

Mark Wooding wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>So in modern C, using NULL at the end of a varargs array as a pointer is 
>>perfectly sane, and the extra cast is just ugly and bowing to bad 
>>programming practices and makes no sense to anybody who never saw the 
>>horror that is K&R.
> 
> No!  You can still get bitten.  You're lucky that on common platforms
> all pointers look the same, but if you find one where `char *' (and
> hence `void *') isn't the same as `struct foo *' then, under appropriate
> circumstances you /will/ unless you put the casts in.

Please explain how malloc() can work on such a platform. My reading of 
the '89 ANSI C spec. finds that _ALL_ (non function) pointers _are_ 
cast-able to/from a void * and that NULL should be #defined as (void *). 
See 3.2.2.3 and 4.1.5 if interested.
