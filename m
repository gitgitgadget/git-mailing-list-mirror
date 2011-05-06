From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: git-p4 and keyword substitution
Date: Fri, 6 May 2011 13:26:18 -0400
Message-ID: <BANLkTinLW3Ty4n1ODKU-N000q7qQUoSDTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 19:26:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIOnI-0004nN-Ug
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 19:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab1EFR0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 13:26:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56729 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1EFR0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 13:26:19 -0400
Received: by gwaa18 with SMTP id a18so1250470gwa.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=5yev/oDlz0vQlFPkmGR8R91umZoBxWWhzNGpF6RP7Ls=;
        b=P0WvGJNnveAEb1fTzYMyIhyNyggSy15MlzUlwO4F0J4L2IMFi8DdGdGIwRZk6+3KKk
         U9ghFaec9eJST4+OL/QSmEwhtnbgvRVBESDEU6GLSD+ZiT8sJvGOmtJw1G0HaxdAgY05
         ljdm4yR32uZ/mLjcGSrGRsPeUrJZv7uM1GOQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=QiY3yPWYcwz0m0RWnjqwKyc8ZFXwKqXbspRVQeAqJbYdhXbrQ4cqKlLTinY9qpszXU
         2MFcUOJzhfc95V7kV3YpZifSNNyELE8KW9Mw43d4lklJdcipZPh14cPKyyIOUiuj9I8o
         b8BKSZIxFh5AkkHzG0jCWmFk9vPFFZPAx6BJM=
Received: by 10.236.148.65 with SMTP id u41mr5170094yhj.225.1304702778883;
 Fri, 06 May 2011 10:26:18 -0700 (PDT)
Received: by 10.236.105.233 with HTTP; Fri, 6 May 2011 10:26:18 -0700 (PDT)
X-Google-Sender-Auth: hCAjrtkxOeI0bt-l4YU4wxQ7ZoI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172992>

All,

I was wondering if there is a way to deal with this issue...

It seems that git removes the keyword substitutions from Perforce.
This is fine, except for the fact that it does not remove them from
the p4 client shadow.  So, this causes git-p4 submit to fail whenever
it either deletes a file with keywords (since the file it is deleting
has the keywords and doesn't match) or lines close to the keywords
change, such that applying the patch doesn't work.

A Google search turned up a thread from a few years ago where someone
submitted a patch to make removing the keyword substitutions optional,
but I guess that patch never got accepted, at least not that I can
see.

Is there any other way of dealing with this?

Thanks,

Mike
