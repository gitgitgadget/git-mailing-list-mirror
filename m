From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Wed, 18 Jan 2006 12:35:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
 <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 12:35:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzBaw-0002Ri-FB
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 12:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWARLfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 06:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWARLfN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 06:35:13 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3797 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030230AbWARLfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 06:35:11 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BD8A91464FA; Wed, 18 Jan 2006 12:35:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id B0258988;
	Wed, 18 Jan 2006 12:35:08 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 94957555;
	Wed, 18 Jan 2006 12:35:08 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 677951464FA; Wed, 18 Jan 2006 12:35:08 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14817>

Hi,

On Wed, 18 Jan 2006, Junio C Hamano wrote:

> @@ -48,7 +48,7 @@ EOF
>  
>  test_expect_success \
>      'diff removed symlink' \
> -    'rm frotz &&
> +    'mv frotz nitfol &&
>      git-diff-index -M -p $tree > current &&
>      compare_diff_patch current expected'
>  
> @@ -58,8 +58,7 @@ EOF
>  
>  test_expect_success \
>      'diff identical, but newly created symlink' \
> -    'sleep 1 &&
> -    ln -s xyzzy frotz &&
> +    'ln -s xyzzy frotz &&

And where does the time lag (required for the test) come from now?

Ciao,
Dscho
