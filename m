From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Tue, 13 Mar 2012 12:51:58 -0500
Message-ID: <20120313175158.GA6653@burratino>
References: <20120312152453.GB12405@1wt.eu>
 <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
 <20120312165703.GB18791@burratino>
 <7vvcm9snko.fsf@alter.siamese.dyndns.org>
 <87399dpk48.fsf@thomas.inf.ethz.ch>
 <20120312215607.GB11362@burratino>
 <874ntto4t8.fsf@thomas.inf.ethz.ch>
 <20120312222227.GC11362@burratino>
 <87fwdcldqj.fsf@thomas.inf.ethz.ch>
 <7v62e8la9y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Willy Tarreau <w@1wt.eu>,
	Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 13 18:52:24 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7VtR-0004bV-B4
	for glk-linux-kernel-3@plane.gmane.org; Tue, 13 Mar 2012 18:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759188Ab2CMRwJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 13 Mar 2012 13:52:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62819 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759138Ab2CMRwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Mar 2012 13:52:06 -0400
Received: by ghrr11 with SMTP id r11so829023ghr.19
        for <multiple recipients>; Tue, 13 Mar 2012 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Wl2bjbIfgkngu6dL3vZq9hYSr0y7f4K6GfmuxtFpcuU=;
        b=TMEH9U28R7FS5nMNhZyCnfijHDKhQGG7h5d+rD++SyPXRZUNeayJ9zIbxi+4RrrA5p
         1DMDqqz+PQ2nVd24ta6WM/6/bWXIcFiEbfKwnpz1ULHqEVgrQuIsxTR78dL78bOK4YO4
         ZmqY75DSx4ATXqjNTc+72p1rSIwBuygDEBUVZ8XWAXBr4eTSFiTu04oeV3rTBeDFYI1I
         CeLdhJe5zlMbNsx367GXFqRYLrkrP7PuYa0AMjO5cj1iQKQeJf+ModJZuTfc4nNWmHJQ
         wcqZHVumfavvz+Y85hnpqBoHPlN0wHl1LwB25dRgUIEYTPssDzy603DUuP1fqvgOZjHA
         HCwg==
Received: by 10.60.14.4 with SMTP id l4mr9792139oec.39.1331661125733;
        Tue, 13 Mar 2012 10:52:05 -0700 (PDT)
Received: from burratino (remote.soliantconsulting.com. [67.109.75.130])
        by mx.google.com with ESMTPS id v7sm1842083obh.1.2012.03.13.10.52.04
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 10:52:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v62e8la9y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193047>

Junio C Hamano wrote:

> I really don't think it is a good idea to avoid mentioning 1.6.0, at
> which we *removed* description of the option in our manual pages and
> from the "git am -h" help message. How much more active deprecation
> would a user want?

A warning when the option is used or a mention in the release notes.

> To put it another way, think what your answer would be when somebody
> sees the message and says "eh? all of a sudden it was removed?".
> Wouldn't you tell him "At 1.6.0 we deprecated it and stopped
> advertising it"?  Why not give that answer upfront?

I would tell her "Since 1.4.3 it has been a compatibility no-op and
our documentation made that clear, and by now based on a search nobody
seems to be using it".

What happened in 1.6.0, then?  Well, before 1.6.0, the git-am(1)
manual said

 -b, --binary
	Pass --allow-binary-replacement flag to git-apply (see
	git-apply(1)).

and the git-apply(1) manual said

 --allow-binary-replacement, --binary
	Historically we did not allow binary patch applied
	without an explicit permission from the user, and this
	flag was the way to do so.  Currently we always allow binary
	patch application, so this is a no-op.

Afterwards, the entry in the git-am(1) manual was removed, saving the
reader a little time.

Jonathan
