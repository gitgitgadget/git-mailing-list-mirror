From: Derek Moore <derek.p.moore@gmail.com>
Subject: git-archive doesn't support --date= option for %ad & %cd format:<string>'s
Date: Thu, 9 Oct 2014 11:19:36 -0500
Message-ID: <CAMsgyKaHoZtAidWKD_YTggt_Xo0J7krFKHr2eFeg3XJ6H0bBXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 18:19:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcGRJ-0005Hm-SW
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 18:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaJIQTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 12:19:38 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:38705 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaJIQTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 12:19:37 -0400
Received: by mail-oi0-f53.google.com with SMTP id v63so3579612oia.40
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=aqDHVjpk19i87ACWd3TUq6Vt8mqdwrER5QSoAs6EYvA=;
        b=dSawF6MguMIXakTg4GU2CyFhu0VOWYC+o2yfpzRP1CcyAp0FE8sxELkRbZEU+6TbXi
         gP7FaLasTgFkTds8mD1KzeZa3+FwvlrubFaD1sUj376KhE8gIrj797owp4VJiIJBXfLz
         psGe+fczJW9B/oTO3ztNKS/Uc0+Es5xQR+f2h6LlRkgsPc6s/4pcGSVQ28K7mybhTIgT
         738yHdlXxiIEHqMJOKrAhRUR8fRT0AjcsuK8d8ZT2Pdgy2oIwIvF3ARbGgSWm6SJbIPj
         Y9uhqzubfcz8mBwdoG/llcAxgnYEypq0sRirp8Y3ezd0KiMLTK1AAHOxblw/luBdPV6S
         V/Xw==
X-Received: by 10.202.175.193 with SMTP id y184mr2801484oie.75.1412871576939;
 Thu, 09 Oct 2014 09:19:36 -0700 (PDT)
Received: by 10.76.33.68 with HTTP; Thu, 9 Oct 2014 09:19:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PRETTY FORMATS' format:<string> documentation says, "%ad: author date
(format respects --date= option)", and similarly for %cd.

But git-archive does not support the --date= option for changing the
date format in $Format:%ad$ or $Format:%cd$ substitution strings.


Relatedly, I want a short RFC date, not a short ISO date, but there is
only --date=short, which is ISO.

Would introducing --date=shortrfc and --date=shortiso be feasable,
with --date=short aliasing to --date=shortiso. With a shortrfc, I
could recreate SVN $Date$'s, which would be equivalent to $Format:%ai
(%ad)$ when used with "git archive --date=shortrfc".

Thanks,

Derek
