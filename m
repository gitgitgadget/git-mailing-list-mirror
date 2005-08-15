From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 19:52:42 +1200
Message-ID: <46a038f90508150052308cf7a8@mail.gmail.com>
References: <46a038f9050814235140877be7@mail.gmail.com>
	 <7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90508150037f128d6@mail.gmail.com>
	 <7vvf273aqb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 09:53:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ZmN-0006HK-3j
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 09:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVHOHwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 03:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVHOHwo
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 03:52:44 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:15164 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932177AbVHOHwn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 03:52:43 -0400
Received: by rproxy.gmail.com with SMTP id i8so742325rne
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 00:52:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XKCGlzGU6KyPnkQKHP2p6f7vOqtFmvErQ57r0Wa/v9jqe5enxT4y00FnGI/p4d0GeJ0XNsfLSIkSxmRyuLuPLkSmTmaOxCXXfH4BTcHbWv3+NKQ2kyCzHP4IckeGKROAe5bfj/cpMHoj7SzLVvO/DqEGV6iDC8bJyxpoC6izv2E=
Received: by 10.38.97.60 with SMTP id u60mr1875296rnb;
        Mon, 15 Aug 2005 00:52:42 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 00:52:42 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf273aqb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/15/05, Junio C Hamano <junkio@cox.net> wrote:
> Isn't cvs default -kkv?

You're right, default is -kkv (expand keyword/value every time) and
not -kv (expand keyword/value only if previously unexpanded).

There's something else in the -kb / -ko distinction according to the
protocol description I linked before. Using -kb changes the way the
file is sent, and this may well break our protocol handling, which is
currently quite happy to deal with the file as a series of lines.

OTOH I am not sure if it breaks when dealing with true binary stuff
like images, compressed data, etc.

cheers,


martin
