From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] zlib: fix compilation failures with Sun C Compilaer
Date: Mon, 22 Apr 2013 17:41:25 -0400
Message-ID: <CAPig+cQQiwumaswnKf1A-e5Rk4BHpRQqhqbL0p8zkmDnZ=Cbtg@mail.gmail.com>
References: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 23:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOUQ-0002tr-TP
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab3DVVl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:41:28 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:50393 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3DVVl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:41:27 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so5910094lab.37
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=4cg1Uq9BtTbiQ4XogSwJUJlvYupS7LfNDp59R7bnW3U=;
        b=n8fXYWUXH6HCxuGB7xmtVcWkJyNHqVewbLcE1jYFPpTusY6NarlcVEnt+j5AjKFH/u
         mWJgf6WXFoL9/1BJXkIeIuMmgPb5/pRe3oRbis0HhRQEM+/+fofk8/g1T98G0F7YdrGZ
         0EBvKeZSJs+I6SCFiNOvMD4vfR7JsSmO0hG2IjIq5ZUXxbSB7nowYhhyzzmPeytniqM9
         bdRfpw9BNXqa7VrZdBkPXTuy8fBq+LQXIFCzrYdhjnMC3+tnUaduaY7AqB0ddYj7QorU
         wfhgUh2BRfaxBkAHUL+qjZp+Q5pgFMuapgAwdAZ3Y1nkE5V0hkVTCZE6lMMVqvqIV7nN
         Ta4Q==
X-Received: by 10.112.59.68 with SMTP id x4mr13647104lbq.121.1366666885574;
 Mon, 22 Apr 2013 14:41:25 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Mon, 22 Apr 2013 14:41:25 -0700 (PDT)
In-Reply-To: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com>
X-Google-Sender-Auth: -2peWgNi9AqnEv0bsDgEAKb89us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222096>

On Mon, Apr 22, 2013 at 12:18 PM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:
> zlib: fix compilation failures with Sun C Compilaer

s/Compilaer/compiler/

> Do this by removing a couple of useless return statements.  Without this
> change, compilation with Sun C Compiler 5.9 (SunOS_i386 Patch 124868-15
> 2010/08/11) fails with the following message:
>
>   "zlib.c", line 192: void function cannot return value
>   "zlib.c", line 201: void function cannot return value
>   cc: acomp failed for zlib.c
>
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
