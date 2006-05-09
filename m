From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Wed, 10 May 2006 00:08:26 +0300
Message-ID: <20060510000826.1a708c03.tihirvon@gmail.com>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
	<11471512103526-git-send-email-normalperson@yhbt.net>
	<20060509120809.4d9494b9.tihirvon@gmail.com>
	<20060509191803.GA3676@localdomain>
	<20060509231031.b62576da.tihirvon@gmail.com>
	<7vlktb2ayy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Tue May 09 23:07:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdZQ8-00063X-RC
	for gcvg-git@gmane.org; Tue, 09 May 2006 23:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWEIVHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWEIVHA
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 17:07:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:21703 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750913AbWEIVG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 17:06:59 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1281991nfe
        for <git@vger.kernel.org>; Tue, 09 May 2006 14:06:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Om+xfGT7TTKeV6V0aSuee/GhWxJbhOT32Lous6vSowK7+gp7dCYRXuFE8cNmV4jJ8d4HWA/Rcig40P6rdyyXgLLlR8gk7zGnIIHf2RfLmCCJqBkG69fzPSWmeH+y6iQb6yxwOSpB9OuULu918VzfZrbUmVX4SeSBEO/DXt/rjT4=
Received: by 10.48.207.10 with SMTP id e10mr2427290nfg;
        Tue, 09 May 2006 14:06:58 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id x24sm2361324nfb.2006.05.09.14.06.57;
        Tue, 09 May 2006 14:06:58 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlktb2ayy.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19850>

Junio C Hamano <junkio@cox.net> wrote:

> Timo Hirvonen <tihirvon@gmail.com> writes:
> 
> > I think optional arguments are still confusing.  We could support both
> > -C (no args) and -C=20 syntax.
> 
> Actually, optional numeric arguments are the norm not exception.
> Think of "diff -u" vs "diff -u20" for example.  Also I think it
> is conventional not to use = for single-letter single-dash
> options, so -C (no args -- use the default number of the
> implementation whatever it is) and -C20 (the same behaviour in
> principle as -C, but use my number instead of the default) are
> sane, while -C=20 _is_ odd.

OK, if we don't support bundling flags at all then -x=y and -xy would do
the same thing and pickaxe's -Stext would work too.  But we could not
make option flag parsing global then (-S=value -> search "=value" or
"value"?).

Maybe we should just change -Stext to -S=text or -S text.

Better to support only -x=y or -x y, not both.

> Having said that, I think abbreviating -u20 -n -r to -u20nr
> going too far

Yes

> (-nru20 would be palatable perhaps),

No :)

-- 
http://onion.dynserv.net/~timo/
