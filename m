From: Paul Dickson <paul@permanentmail.com>
Subject: Re: Yet another base64 patch
Date: Fri, 15 Apr 2005 16:55:32 -0700
Message-ID: <20050415165532.05ed5dc4.paul@permanentmail.com>
References: <425DEF64.60108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 01:52:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMabl-0001TR-UZ
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 01:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVDOXzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 19:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVDOXzw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 19:55:52 -0400
Received: from orb.pobox.com ([207.8.226.5]:24716 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262412AbVDOXzr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 19:55:47 -0400
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP
	id 762577D7; Fri, 15 Apr 2005 19:55:44 -0400 (EDT)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 34AB387;
	Fri, 15 Apr 2005 19:55:42 -0400 (EDT)
Received: from violet.pwd.internal (violet [192.168.1.4])
	by red.pwd.internal (8.12.8/8.12.8) with SMTP id j3FNtXT3007438;
	Fri, 15 Apr 2005 16:55:43 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425DEF64.60108@zytor.com>
X-Mailer: Sylpheed version 1.9.7 (GTK+ 2.4.14; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Apr 2005 21:19:48 -0700, H. Peter Anvin wrote:

> Checking out the total kernel tree (time checkout-cache -a into an empty 
> directory):
> 
>         Cache cold      Cache hot
> stock   3:46.95         19.95
> base64  5:56.20         23.74
> flat    2:44.13         15.68
> 
> It seems that the flat format, at least on ext3 with dircache, is 
> actually a major performance win, and that the second level loses quite 
> a bit.

Since 160-bits does not go into base64 evenly anyways, what happens if
you use 2^10 instead of 2^12 for the subdir names?  That will be 1/4 the
directories of the base64 given above.

	-Paul

