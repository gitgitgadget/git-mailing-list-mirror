From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: git history in a file
Date: Fri, 24 Jul 2015 08:16:19 -0400
Message-ID: <CA+5PVA6S69ZU5Q432PK3DiPGkT=00tAtgSzJaYHyXLkHkg9FHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 24 14:16:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIbtp-0002td-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 14:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbGXMQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 08:16:21 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35428 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbGXMQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 08:16:20 -0400
Received: by igr7 with SMTP id 7so15000115igr.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=h94uT9O3PtpKRZWZ8hlY/T3AMaSn1dsDAVWQxH6GVH8=;
        b=TDa1Vn68bp50i3Fy9GON0TCbimUN0YWNJVHVcoGvZoNAvjBn2laVhL/MFfZNLvA2uz
         ssFWhw0j76h34w1Ib3ci9HQU5dvGu4vcHhqk/Ouvhsz2YtxNpWbgc8QbGM7SWBvgZXSO
         9BxhbdWTQaujvanoBuQOLAC0ll8N90xqwqbLQn2XJ5TVRuK55yXwl09GpRfmCcMB3wyL
         i00CXcVwICMgAJohcaGUApPagHnC4XjzAOCGrrskojX8CaFW3WbZk6Oo3I8zIeYQbf1l
         3KWpad5MPyohFsyMtZoHVO0aCRbYjseNDq7ZdAEE2SWDpMtknFnW4j3QipBCrlXwd1QT
         fnaw==
X-Received: by 10.50.39.17 with SMTP id l17mr5352874igk.75.1437740179870; Fri,
 24 Jul 2015 05:16:19 -0700 (PDT)
Received: by 10.64.211.162 with HTTP; Fri, 24 Jul 2015 05:16:19 -0700 (PDT)
X-Google-Sender-Auth: OjwiTppPCpdoK7yXHUG8VV8Ghxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274565>

Hello,

I'm trying to figure out how to generate a file that contains the git
history and changes from one revision to another, such that when the
file is applied to a different tree starting at the same ancestor, the
resulting tree is identical.

E.g. git <whatever> v4.2-rc3..master

would produce this file, and then:

git <apply whatever> <file>

run on a tree which is currently at 4.2-rc3 would result in an identical HEAD.

Originally I thought git-format-patch would be sufficient, however it
does not contain merge commits and the resulting commit shas seem like
they would be inaccurate.  Is there a way to do this?

I realize one could just git fetch/pull from tree A to tree B, but the
usecase here is more complicated.  Please CC me on replies as I am not
subscribed.

josh
