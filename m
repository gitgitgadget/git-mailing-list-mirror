From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sat, 24 Mar 2007 15:48:10 +0000
Message-ID: <200703241548.13775.andyparkins@gmail.com>
References: <200703231022.00189.andyparkins@gmail.com> <38b2ab8a0703240743t3ca2b091w12072046ee03dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Francis Moreau" <francis.moro@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 16:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV8WM-0004b3-QY
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 16:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbXCXPvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 11:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbXCXPvH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 11:51:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:3311 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbXCXPvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 11:51:04 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1259925uga
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 08:51:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dZDgevxQT5cRYim4KOtIC3tuZadQB8dCWyzj+ddiEq9YQpLuv3AR2O0TqkYyefR3VXMoQs7Zwd0sKuG3USjPfqHiTdrhpNX1VXrqAraqz76FlshW9SiVt+M95FNoUwaOjc2SFpRoRsGYXMlBuaOr0nsJhAy9tFMbnuA/ZhqFu84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qgR23Nh/Ma8JlDyRzo+CVrPYxBZo8f6fE3LS4SSshSd7oMcscGYCxK37z8J082gI2qRC+PkBC19IqiFnC+1yZr6X4PxsArO1drJjE2fs9m5vriGQRWGiYEMA9/ztPiGBrFz2hfrz0k6ALcAN55pGrkcfGJdfTkkBtelBKnMyP/4=
Received: by 10.67.21.11 with SMTP id y11mr8743818ugi.1174751463556;
        Sat, 24 Mar 2007 08:51:03 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id j1sm5975009ugf.2007.03.24.08.51.02;
        Sat, 24 Mar 2007 08:51:02 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <38b2ab8a0703240743t3ca2b091w12072046ee03dd5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43005>

On Saturday 2007, March 24, Francis Moreau wrote:

> Are there any simple ways to enable this behaviour from your hooks ?

Yes; have a look near the bottom of the post receive hook (update to 
come today, so don't use it yet), but you'll see:

 while read oldrev newrev refname
 do
  generate_email $oldrev $newrev $refname | /usr/sbin/sendmail -t
 done

That pipe to send mail could be anything you want, say

 generate_email >> /var/www/update-announcements.txt

Would that suit you?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
