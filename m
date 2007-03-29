From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] mergetool: Replace use of "echo -n" with printf(3) to be more portable
Date: Thu, 29 Mar 2007 17:57:41 +0200
Message-ID: <20070329155741.GA18413@moooo.ath.cx>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:57:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWx0Z-0001lr-FY
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbXC2P5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbXC2P5p
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:57:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:35014 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030293AbXC2P5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:57:45 -0400
Received: (qmail invoked by alias); 29 Mar 2007 15:57:43 -0000
Received: from pd9ebbcca.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.188.202]
  by mail.gmx.net (mp023) with SMTP; 29 Mar 2007 17:57:43 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/34CNfgk/3vPklxv8W5qHjxst94ZwmxCz9j7sR9I
	B6I0kDy3PDugiE
Content-Disposition: inline
In-Reply-To: <11751830651770-git-send-email-tytso@mit.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43453>

The subject should probably refer to printf(1) instead of printf(3).

Theodore Ts'o <tytso@mit.edu> wrote:
> -	echo -n "'$path' was deleted"
> +	printf  "'$path' was deleted"
Here is one space too much after printf.

> -	echo -n "'$path' is a symlink containing '"
> +	printf "'$path' is a symlink containing '"
You should use printf "'%s' [..]" "$path" as you do in some other
places (in case $path contains conversion specifiers).

> -    echo -n "Hit return to start merge resolution tool ($merge_tool): "
> +    printf "Hit return to start merge resolution tool ($merge_tool): "
Here it is much more unlikely that $merge_tool contains a conversion
specifier but anyway I'd prefer to use %s.
