From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 21:05:01 +1200
Message-ID: <46a038f9050815020511574e3d@mail.gmail.com>
References: <46a038f9050814235140877be7@mail.gmail.com>
	 <7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90508150037f128d6@mail.gmail.com>
	 <7vacjj3968.fsf@assigned-by-dhcp.cox.net>
	 <46a038f905081501301bd9a801@mail.gmail.com>
	 <7vr7cv1t89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 11:06:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4au7-0006wB-Gq
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVHOJFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVHOJFF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:05:05 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:46503 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932288AbVHOJFE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 05:05:04 -0400
Received: by rproxy.gmail.com with SMTP id i8so747581rne
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 02:05:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J9tSz6bVJggixI/0iv2Hx752laVdNEpwIYzhdiKe+I0CvpW8332Yv6Xjp7zzZeBwyqxyqg6XtKLk6G115JfXf1W6J4yc+43HGWwqSaOClWLeCwMhoXUeM9pVb4WH/qOyxvlcGw9AQw20cTiVNpdVX6fPmba+CgH360TbhQGdLbw=
Received: by 10.38.101.23 with SMTP id y23mr1891865rnb;
        Mon, 15 Aug 2005 02:05:01 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 02:05:01 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7cv1t89.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/15/05, Junio C Hamano <junkio@cox.net> wrote:
> I was just wondering if we are limiting options for people who
> want to convert their own CVS repositories by always using
> either -kkv or -ko and nothing else. 

I think the other modes are relevant in different scenarios. -kv is
only meaningful as file mode over the life of the file in the repo.
-kk is only meaningful when calling cvs update with -j -j parameters
or cvs diff, and is effectively a synonim of -ko.

In the position we are, getting file/revisions out of a repo, there
are 2 possible files we can get: the one that you'll get with -kkv and
the one you'll get with -ko/-kb. -kb/-ko should give us exactly the
same file, modulo bugs.

I suspect that in practice -kb is more reliable when it comes to
binary files. But to support that the _files() method will need to
handle a slightly different protocol mode on the socket, and I rather
not mess with it unless I can prove its broken. Talking with cvs
servers on the socket is not my idea of fun, and there's all sorts of
version-specific oddities.

cheers,


martin
