From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Tue, 9 May 2006 12:08:09 +0300
Message-ID: <20060509120809.4d9494b9.tihirvon@gmail.com>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
	<11471512103526-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 11:06:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdOB6-0004Km-Ii
	for gcvg-git@gmane.org; Tue, 09 May 2006 11:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWEIJGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 05:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWEIJGp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 05:06:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:63045 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751609AbWEIJGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 05:06:44 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1144510nfe
        for <git@vger.kernel.org>; Tue, 09 May 2006 02:06:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=cCQ/w3HoSLsnC/Mt5SHyBRz75Zv/zGF5OtVU4f8Q8fN9vScubCDYdE1EG+UMaWMC+sdiLfIutDvno2KD39sHL4rASJ0euLI+xSxtzIZ8McyWYIZ6C8GBOdOjsY203YYQTxR/D/4KX05ERLumoDXsiM0wyDC1stXvUiTR6uxLVTs=
Received: by 10.49.93.15 with SMTP id v15mr368149nfl;
        Tue, 09 May 2006 02:06:43 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id l21sm3173592nfc.2006.05.09.02.06.42;
        Tue, 09 May 2006 02:06:42 -0700 (PDT)
To: normalperson@yhbt.net
In-Reply-To: <11471512103526-git-send-email-normalperson@yhbt.net>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19830>

Eric Wong <normalperson@yhbt.net> wrote:

>  * unbundling of short options: -uC20n20z => -u -C20 -n20 -z

Does anyone ever use this?  I think this makes sense only for flags that
don't have parameters but that would create an ugly special case. Is it
too hard to type "-u -C=20 -n=20 -z"?

>  * optional argument handling (-C<num>, -M<num>)
>    -C <num> (with a space between them) has not changed,
>    however, <num> can be a sha1, or a path

IMO optional arguments are usually bad idea.

    -C 2 (is "2" argument?)
    -C2  (-C=2 or -C -2?)

Better to make it obvious there's an argument

    -C=2

or not support optional arguments at all and "-C 2" becomes unambiguous.

-- 
http://onion.dynserv.net/~timo/
