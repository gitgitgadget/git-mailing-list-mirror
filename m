From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: What's in git.git
Date: Sun, 25 Jun 2006 21:07:24 +0300
Message-ID: <20060625210724.934617c4.tihirvon@gmail.com>
References: <7v7j35wp84.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606251033030.3747@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 20:09:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuZ1E-0002AE-RY
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 20:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWFYSHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWFYSH3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 14:07:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:49968 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965157AbWFYSH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 14:07:27 -0400
Received: by nf-out-0910.google.com with SMTP id m19so490824nfc
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 11:07:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ZYtV3ExOyS3RJMaT7k+iwS4f7fNh/98shKVxiXQLfADQP1W6dgaD63rS3zlZXIzg67yFDFTHj/i1Ljf9ifltH1O29XD1TPe1L8QSBGJulhyso/4aKku5A1/4/Iv2srTS5PUXPhiOJSLXqONYMxt+pprrBaMBqskt6hHRuJfOZ3E=
Received: by 10.49.19.11 with SMTP id w11mr4232676nfi;
        Sun, 25 Jun 2006 11:07:25 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id l22sm4940409nfc.2006.06.25.11.07.24;
        Sun, 25 Jun 2006 11:07:25 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606251033030.3747@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22643>

Linus Torvalds <torvalds@osdl.org> wrote:

> On Sun, 25 Jun 2006, Junio C Hamano wrote:
> > 
> >    Timo Hirvonen:
> >       Clean up diff.c
> 
> THIS IS CRAP!
> 
> Dammit, anybody who claims that casting a constant string to "(char *)" is 
> a _cleanup_ is doing something seriously wrong.
> 
> That's crap, crap, crap, CRAP!

Sorry.  It got really annoying to skip over the same compiler warnings
in vim's quickfix window many times.  At that time I just wanted to
focus on the code I was writing.

> but THESE are total and utter CRAP:
> 
> -               mf->ptr = ""; /* does not matter */
> +               mf->ptr = (char *)""; /* does not matter */
> -                               s->data = "";
> +                               s->data = (char *)"";
> 
> and we're better off with the warning than with the new code.
> 
> I suspect that both could have been made to use NULL instead to indicate 
> that no pointer exists.

I'll look into this.

-- 
http://onion.dynserv.net/~timo/
