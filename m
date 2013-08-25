From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/13] Improve section "Merge multiple trees"
Date: Sat, 24 Aug 2013 22:23:27 -0700
Message-ID: <20130825052327.GK2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1473018875.1091101.1377329545934.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:23:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDSna-000406-OC
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab3HYFXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:23:33 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:52391 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702Ab3HYFXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:23:32 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so2202837pdi.41
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/u6pFFpObF8jPdy+s4foHwddLM7ECoPdZdFQpKJ4Y4E=;
        b=nnxdWtKJECbEg6v40e/Pi7Pf5lR9JjbgvrZK7n65rWm2To9/jwThjm2Io9xZFXrv5q
         1n5r65QT1hk6BC1CMrlwUVOrXv2YZScpnr7hb2h39H5VZ1DGnWXNfPehDkfanT+cV1Oq
         Fdvym4OkPc7nTz0WfMTYKeCmHSbf6Xfhm1WV9ELPBDXEfT7LWBAlcX420HHS4hBLj4Ys
         AYZLhtjeo9Z2JKLA3JRqdGF+m7RkRy0kQ2grUuF3kQrSr6KL+81tIwgPERYvim1FsS42
         fR93yUN2BypQ+MWDRBGa1ls61S6QbYWVfxm2QxeufnuejGITV3uWC552D21KCl9sH5sP
         Z0Rg==
X-Received: by 10.68.139.201 with SMTP id ra9mr8404736pbb.46.1377408212278;
        Sat, 24 Aug 2013 22:23:32 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id eq5sm9825529pbc.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 22:23:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1473018875.1091101.1377329545934.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232919>

Thomas Ackermann wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3992,16 +3992,16 @@ Merging multiple trees
>  
>  Git helps you do a three-way merge, which you can expand to n-way by
>  repeating the merge procedure arbitrary times until you finally
> -"commit" the state.
> +commit the state.

The above sentence is unclear to me both before and after this change.

Git helps me do a three-way merge, but I'm on my own if I want to
expand to n-way?  Those times I repeat it are arbitrary times, not
arbitrarily many times?  Using "git merge" I make commits, but I
do not finally commit to the result until the (n-1)st?  And what is
this state I am committing?

Maybe the intent is

	Git can help you perform a three-way merge, which can in turn be
	used for a many-way merge by repeating the merge procedure several
	times.  The usual situation is that you only do one three-way merge
	(reconciling two lines of history) and commit the result, but if
	you like to, you can merge several branches in one go.

	To perform a three-way merge, you start with the two commits you
	want to merge, find their closest common parent (a third commit),
	and compare the trees corresponding to these three commits.

	To get the "base" for the merge, look up the common parent of two
	commits:

		$ git merge-base <commit1> <commit2>

	This prints the name of a commit they are both based on.
	...

[...]
> -To get the "base" for the merge, you first look up the common parent
> +To get the base for the merge, you first look up the common parent

Merge base hasn't been defined, so this is using quotes to point out
that it is defining a new, unfamiliar term.

[...]
> -now look up the "tree" objects of those commits, which you can easily
> -do with (for example)
> +now look up the tree objects of those commits, which you can easily
> +do with

Yes.
