From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Make git-fmt-merge-msg a builtin
Date: Mon, 3 Jul 2006 19:16:35 +0300
Message-ID: <20060703191635.21ba0af3.tihirvon@gmail.com>
References: <Pine.LNX.4.63.0607031530380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060703171751.2ed33220.tihirvon@gmail.com>
	<Pine.LNX.4.63.0607031632290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060703182621.dbed5b5f.tihirvon@gmail.com>
	<Pine.LNX.4.63.0607031731550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 03 18:16:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxR6H-0002Ts-Uk
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 18:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWGCQQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 12:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWGCQQf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 12:16:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:28679 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932085AbWGCQQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 12:16:34 -0400
Received: by nf-out-0910.google.com with SMTP id k26so457078nfc
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 09:16:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Y3Hrja8DF3ynwG4yPFoT0NxB5PqbHjvQbgHBZM+UCWg5ZdXRSrqWEvjRuabU8ARHb9INgHh7J1fQd0rz2pHWuo9IzRsMn+Bi/S7vZDenVJSzSYUXrK1h98SOhOMUWGbUQjW1W/yFIxztZB07XBlmXl9+4jqbmx7DA3u6dcEjTkc=
Received: by 10.48.243.16 with SMTP id q16mr2552639nfh;
        Mon, 03 Jul 2006 09:16:33 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id a24sm4702521nfc.2006.07.03.09.16.32;
        Mon, 03 Jul 2006 09:16:33 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607031731550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23188>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > > > free(NULL) is safe.
> > > 
> > > Is it? I vaguely remember that I had problems with this on some obscure 
> > > platform.
> > 
> > I don't think so.
> 
> Well, after a little Googling, I am more convinced than ever that it is a 
> BAD thing to rely on free(NULL) being a NOP.

I did some research too.  Seems that C89 requires free(NULL) to be a
no-op but on some old systems (SunOS) it may crash.  IMNSHO these
systems were designed to crash valid programs and torture developers.
There are probably many free(NULL) and realloc(NULL, ...) uses in the
git source code and are not worth fixing.

-- 
http://onion.dynserv.net/~timo/
