From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [RFC] Design for http-pull on repo with packs
Date: Mon, 11 Jul 2005 10:08:15 -0700
Message-ID: <12c511ca050711100840946891@mail.gmail.com>
References: <Pine.LNX.4.21.0507101226011.30848-100000@iabervon.org>
	 <42D17D89.9080808@innehallsbolaget.se>
	 <7v4qb2ni73.fsf@assigned-by-dhcp.cox.net> <42D2960E.3050008@gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 19:20:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds1wy-0004Ri-Cp
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 19:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVGKRTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGKRSS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 13:18:18 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:31891 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262252AbVGKRIP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 13:08:15 -0400
Received: by zproxy.gmail.com with SMTP id s18so413390nze
        for <git@vger.kernel.org>; Mon, 11 Jul 2005 10:08:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pEPyiGdDUKTkNO7CmX+WVOx8ZXv7gQajt/KEo8jPgWxMXJatO/hr06UcQhs9mBh/wUv/cFRZ8lvsVz5T+uTuJxSb9m7oxBv1UOPLmmq6ErLthfKmV8m6kcbGmKF5m+8OcGyx3yMA0tX1COtAQttUBEEv6gHrp2YmeAjRUUxUuEU=
Received: by 10.36.3.7 with SMTP id 7mr1204950nzc;
        Mon, 11 Jul 2005 10:08:15 -0700 (PDT)
Received: by 10.36.59.4 with HTTP; Mon, 11 Jul 2005 10:08:15 -0700 (PDT)
To: Dan Holmsand <holmsand@gmail.com>
In-Reply-To: <42D2960E.3050008@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> The big problem, however, comes when Jeff (or anyone else) decides to
> repack. Then, if you fetch both his repo and Linus', you might end up
> with several really big pack files, that mostly overlap. That could
> easily mean storing most objects many times, if you don't do some smart
> selective un/repacking when fetching.

So although it is possible to pack and re-pack at any time, perhaps we
need some guidelines?  Maybe Linus should just do a re-pack as each
2.6.x release is made (or perhaps just every 2.6.even release if that is
too often).  It has already been noted offlist that repositories hosted on
kernel.org can just copy pack files from Linus (or even better hardlink them).

-Tony
