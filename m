From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: bug with refresh and -p
Date: Thu, 17 Jul 2008 21:29:01 -0400
Message-ID: <9e4733910807171829q6abdcfc2m90c40a70dbc8fef5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJenM-0002Vv-G3
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbYGRB3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbYGRB3E
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:29:04 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:36794 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbYGRB3C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:29:02 -0400
Received: by yx-out-2324.google.com with SMTP id 8so55239yxm.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 18:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Z3fWth2AZxYZzc5n064ohxnSbOHn7FoUWkITty9kWtU=;
        b=xznrYJFGOESdB7T+sp5ndANw78o/kUo+hp0fFIQVRwz72rveo7n8khZ0pm4K3/B2GU
         s9m+Hw7LHQxPp5SDsJRAb9fxG0n18hdL8uN1eu/7LIeAQzJZxzN3VJChKBFuEXtBulR/
         1AzsAfL9vuMBxmIfaL8udza3NJd0ed/j2jSZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=coQ2qykHNid7DyYyLKsjtn3i8RwebgCgtDPn92F7mBGKf0Rmr9Gau+RXW3y5+VX/B8
         lVTuuFFmfhIl4Pic4hVqGtPnPGO3l748uU/wBaXZkroM5NHP3QP4Kel0hyN17TH0hmVz
         eaENax8i3Eo5VX3JRuzz+gs0dQNuLAwu2A1FY=
Received: by 10.151.111.1 with SMTP id o1mr1345750ybm.194.1216344541227;
        Thu, 17 Jul 2008 18:29:01 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Thu, 17 Jul 2008 18:29:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88948>

A refresh with -p is not picking up newly added files.

jonsmirl@terra:~/fs$ stg status
? include/linux/i2c/max9485.h
jonsmirl@terra:~/fs$ git add include/linux/i2c/max9485.h
jonsmirl@terra:~/fs$ stg refresh -p max9485
Checking for changes in the working directory ... done
Popping patches "jds-audio" - "jds-psc" ... done
Refreshing patch "max9485" ... done
Fast-forwarded patches "jds-psc" - "jds-audio"
jonsmirl@terra:~/fs$ stg status
? include/linux/i2c/max9485.h
jonsmirl@terra:~/fs$ stg --version
Stacked GIT 0.14.3.163.g06f9
git version 1.5.6.1
Python version 2.5.2 (r252:60911, Apr 21 2008, 11:17:30)
[GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
jonsmirl@terra:~/fs$

-- 
Jon Smirl
jonsmirl@gmail.com
