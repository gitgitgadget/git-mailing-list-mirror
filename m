From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] rebase -i: Remember merge options beyond continue actions
Date: Fri, 18 Jul 2014 19:03:37 +0200
Message-ID: <1405703017-15934-1-git-send-email-ralf.thielow@gmail.com>
References: <53965334.3030206@gmail.com>
Cc: bafain@gmail.com, gitster@pobox.com, mhagger@alum.mit.edu,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 19:04:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8BZi-00066p-Ii
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 19:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030690AbaGRRD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 13:03:58 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:58941 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030643AbaGRRD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 13:03:57 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so3715560wgh.20
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=refCD2USPs0VLFFQ5MriF12eouSptecLYVoQC5gr/Yc=;
        b=cdHRQqteA5xIfALzAjCbl1FKR+xwkAF0xHxQGQzVd38A3v/Hfa1U9XV62CZOs65lC8
         VXRxun8vME3Ekdn/wSmFCkCzxjEkrydyj9nfm4mrT+Kk+Cg17gbbqgL7Rvr9ibqIJw3x
         BXbW2+9dJbKHAQXUJU04NUM3vwI//8D0ra1Swp2CfrixRwmbDwFv+FkdbbeELPdQPxgB
         lNgl3DzVdQbdfR3wNmU3Ea6PDxAumeWh6PGC2UKWtYe30jiG74cpWd8LH/pfygZY8Hcx
         qA0hg7f5N5gYvO/A8jkj9+a4Xakh4PNQAHwr5fxB4TXV5Z9fQ716Zct5maHFo4tE8azh
         6HRw==
X-Received: by 10.194.122.73 with SMTP id lq9mr8318262wjb.133.1405703035610;
        Fri, 18 Jul 2014 10:03:55 -0700 (PDT)
Received: from localhost (dslb-088-073-244-207.pools.arcor-ip.net. [88.73.244.207])
        by mx.google.com with ESMTPSA id gd13sm8641728wic.6.2014.07.18.10.03.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 10:03:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.2.845.gc8a305d
In-Reply-To: <53965334.3030206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253828>

Hi,

Thanks for the patch. I've had this issue today
and the patch has fixed it. I hope the patch makes
its way to Git.

Ralf

> Hi Eric,
> 
> thanks a lot for the reference.
> 
> I added the Reported-by: and Signed-off-by: lines to the commit message.
> 
>    Fabian
> 
> -- >8 --
> Subject: rebase -i: Remember merge options beyond continue actions
> 
> If the user explicitly specified a merge strategy or strategy options,
> "rebase --interactive" started using the default merge strategy again
> after "rebase --continue".
> 
> This problem gets fixed by this commit. Add test.
> 
> Since the "rebase" options "-s" and "-X" imply "--merge", we can simply
> remove the "do_merge" guard in the interactive mode and always compile
> the "cherry-pick" arguments from the "rebase" state variables "strategy"
> and "strategy_opts".
...
