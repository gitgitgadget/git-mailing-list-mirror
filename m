From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: avoid atoi, when possible; int overflow -> heap corruption
Date: Mon, 22 May 2006 09:16:50 -0400
Message-ID: <118833cc0605220616t75a182b1oa404d5efe8a1f5d9@mail.gmail.com>
References: <87mzdcjqey.fsf@rho.meyering.net>
	 <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
	 <871wumim28.fsf_-_@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 15:17:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiAHH-0001qg-Gv
	for gcvg-git@gmane.org; Mon, 22 May 2006 15:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWEVNQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 09:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWEVNQw
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 09:16:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:26206 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750816AbWEVNQv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 09:16:51 -0400
Received: by nf-out-0910.google.com with SMTP id c31so424297nfb
        for <git@vger.kernel.org>; Mon, 22 May 2006 06:16:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WLJJx7MXY9J8XiSYQY1juD/9/p5d8ts2t0crYPolf5PkFt1nns5yJlNad7zVLc1LzGOltaWrUs3SKLr5YGlEFWYxIB1WNgo00tMzig+zVjUSGTQUD5/zXNFB95R1ohSzEDihRraQIZSScEdIeLNT1jDZGgpTFgEuDf0EU9ca08A=
Received: by 10.48.205.7 with SMTP id c7mr3775744nfg;
        Mon, 22 May 2006 06:16:50 -0700 (PDT)
Received: by 10.49.12.11 with HTTP; Mon, 22 May 2006 06:16:50 -0700 (PDT)
To: "Jim Meyering" <jim@meyering.net>
In-Reply-To: <871wumim28.fsf_-_@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20503>

> There are about 20 uses of atoi, and most calls can return
> a usable result in spite of an invalid input -- just because
> atoi returns the same thing for "99" as "99-and-any-suffix".
> It would be better not to ignore invalid inputs.

atoi has undefined behaviour for "99-and-any-suffix".  You might
get lucky and get back 99, but you might also get a random value
or a core dump.

Morten
