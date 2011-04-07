From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Tracking file metadata in git -- fix metastore or enhance git?
Date: Thu, 7 Apr 2011 21:16:19 +0200
Message-ID: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thorsten Glaser <tg@mirbsd.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:16:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uhD-00043B-CR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 21:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713Ab1DGTQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 15:16:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46734 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573Ab1DGTQk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 15:16:40 -0400
Received: by iyb14 with SMTP id 14so2763530iyb.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=CikGK3UqXnuSA2ZnWoHxmEDmrQ5tTVanT7AF3FvGpgs=;
        b=o1ellsBJFGjhMbSNti0nBlFdzbwFa+3sTvbvw3Y/70tMN42zneg974NpTbOWPWbe+/
         wtn8HmYjFQRPq1/B/wp5CGeLsOYN3hahRnpK3j05E2Sqcyx4aAmPRAnaXCi4QOSA9ibC
         wo1uA09MdLj9vDuVjMD9pUvdp+tJ6lg9W3kd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=Vv4z2MjTG1RA998YZ9bF2C8k4RBrfd7tQ4ig3DZ7W2imgxGxit63wx47aoEVccK0x5
         Q1cp3B4cE2QTdzYYrIiW+7bFvFf3s5+T/drCtmZMd+/6sQk/WM/05AVcLmaA88emuVoU
         G+6jFIJy+sK87I9p1si7K2ZwctGVt3TJPDRrI=
Received: by 10.231.61.198 with SMTP id u6mr1218483ibh.160.1302203800141; Thu,
 07 Apr 2011 12:16:40 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Thu, 7 Apr 2011 12:16:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171082>

Hi all,


as you know, it's not possible to track metadata like mtime etc via
git natively. metastore exists, but its binary storage format is
merge-unfriendly. The author knows and acknowledges this but lacks the
time to fix it.

We might try and fix up metastore to use ASCII with BASE64 for xattr
etc instead of the current binary format. metastore supports versioned
stores so it will handle this gracefully. Before going down this path,
I wanted to ask if anyone would be interested to implement this in git
directly. Obviously, an optional and native way is vastly preferable
to a third-party tool. Both for reasons of potential bit-rot and more
users. Yet, we lack the confidence to do this in git directly
ourselves.

If this is implemented in git, the type(s) of metadata to track should
be fine-grained and fully optional, of course.


Any and all feedback appreciated,
Richard
