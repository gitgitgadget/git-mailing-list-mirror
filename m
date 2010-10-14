From: Alexander Gladysh <agladysh@gmail.com>
Subject: false positives from git diff-index when used with --git-dir
Date: Thu, 14 Oct 2010 18:40:51 +0400
Message-ID: <AANLkTimyeE=OLdC0Zzdnidr_dssFfkMzS+r_39dYUVxz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 16:41:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Ozl-0003hy-Th
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 16:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab0JNOlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 10:41:17 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48378 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab0JNOlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 10:41:14 -0400
Received: by qyk5 with SMTP id 5so93076qyk.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=EcR+F7NXHGqUploYG9SKXl1w3C4CR8el82EhKELgXKY=;
        b=braqPXFg/KqNQY/PaLD5zeWNNSS/Pus7UoR6xDPJKlkVlvrrBcbiosHpiIDVz04Zwj
         vOSaF14dOjFWXR43c/R2jcangIzxciuuWrc0ovkoO6tPBvRYkpZGy6ohQHzHMSxx7VcI
         4Zbpl3j0S0Quub1dpKxFHP4Z0DR+ZZYVcri5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=dVunm3hwfIt0m3C6AnKeLsJZ9MJq1c14WrafDNP65BGY1z5qczifM59iIXcMl/LGzP
         EYOIpKmhU46xFj46BquRLFoyglAn6chx5jU6at/HRKQ0PfyGgAxy//eHRYin3eWU+nC5
         5JeeCpPX1ynvjwLHUy3ZFRQCZHHkbTvKACZpA=
Received: by 10.229.223.193 with SMTP id il1mr8374580qcb.250.1287067273886;
 Thu, 14 Oct 2010 07:41:13 -0700 (PDT)
Received: by 10.229.51.138 with HTTP; Thu, 14 Oct 2010 07:40:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159051>

Hi, list!

$ git --version
git version 1.7.3.1

$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 10.10
Release:	10.10
Codename:	maverick

I'm *sometimes* (once in about ten times I use it -- repository
changes between invocations of course) getting false positives from
git diff-index when I invoke git from another directory:

git --git-dir=path/to/.git --work-tree=path/to update-index -q --refresh
git --git-dir=path/to/.git --work-tree=path/to diff-index --exit-code
--quiet HEAD

This is *really* annoying and really kills the benifits from my
workflow automation scripts.

Unfortunately I can't find a reproducible use case for this bug.

Is there anything I can do to help catch it?

Thanks,
Alexander.
