From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Use explicit pointers for execl...() sentinels.
Date: Sun, 12 Mar 2006 17:13:16 +0200
Message-ID: <20060312171316.39d138f8.tihirvon@gmail.com>
References: <20060311192954.GQ16135@artsapartment.org>
	<slrne17urp.fr9.mdw@metalzone.distorted.org.uk>
	<7v7j6zgaxx.fsf@assigned-by-dhcp.cox.net>
	<slrne18aae.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 16:11:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FISEF-0004Tz-VZ
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 16:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWCLPLZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 10:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWCLPLZ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 10:11:25 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:55563 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751050AbWCLPLY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 10:11:24 -0500
Received: by nproxy.gmail.com with SMTP id x29so782184nfb
        for <git@vger.kernel.org>; Sun, 12 Mar 2006 07:11:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=g2vorlxKgc3I5+au4a0z2SW8sXzCgCIcmxFg/PqS0o4SpEseDOJnfzpppjK0p5fEV2c2gVSBwN5R1pPthIb1jHzAt/WZgsLoJBFUfa7S1AFdKc08lzWsnEiF4tiXQy1NTPkkboLieSJTmJcftBoslWNCkErd24QTqA/e9tjJ7DA=
Received: by 10.48.226.12 with SMTP id y12mr2373952nfg;
        Sun, 12 Mar 2006 07:11:20 -0800 (PST)
Received: from garlic.home.net ( [82.128.201.244])
        by mx.gmail.com with ESMTP id m15sm2536042nfc.2006.03.12.07.11.17;
        Sun, 12 Mar 2006 07:11:18 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <slrne18aae.fr9.mdw@metalzone.distorted.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.14; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17517>

On Sun, 12 Mar 2006 13:59:42 +0000 (UTC)
Mark Wooding <mdw@distorted.org.uk> wrote:

> A terminator of `0' (or `NULL', which might well expand to `0') gets
> passed as type `int' in the absence of argument type declarations (which
> is the case for execl...(), since it uses varargs).  Argument passing
> conventions may differ between `int' and `char *' if, say, `int' is 32
> bits and pointers a 64; and there's no particular guarantee that a null
> pointer has all-bits-zero anyway.

NULL should always be ((void *)0).  What 64-bit systems declare NULL as
plain 0 (not 0L)?  How about fixing those systems instead of making the
git source code unreadable.

-- 
http://onion.dynserv.net/~timo/
