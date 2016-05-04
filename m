From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Portability of git shell scripts?
Date: Wed, 4 May 2016 20:17:38 +0200
Message-ID: <CALR6jEh5dAcnqiyo4kXkj+8imfQQd0nT=baPOW_qbJpJwmFsyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 20:17:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1Mo-0003MK-CE
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbcEDSRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 14:17:40 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34332 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbcEDSRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:17:39 -0400
Received: by mail-yw0-f175.google.com with SMTP id j74so97987173ywg.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=REXnOozYUjmSz9tnv6vKVi2FmcOT+TdEKl6P4HhkKlU=;
        b=b9c8bc6HJeH2Urd7Xx0Ztfgw0incz5Ar1yeukpSQepjv8IRT2wuvVNEdMjcQAWw6bX
         SwLbSHIhXlCUnEEW/C2OA5QASL0pEZUHBcpUpbROpehPCuC+aMGxPgN5uZWp5H7yj/pm
         SuCwlh4KqhqIiW5dxaHag1A8YgzVWjQGi7EoqBn8bRqbIK9k2JJBmGVaUQFqEinXFq3E
         V+glSmT+ga7xWnoM6UQq3AuOnnTJYth1gMqdLaUvdNke5jTL9kBkNJLBeIwtZC05g/zy
         YXCGi/sXOFFRn3AqFZl9RfxEKe2i8my4RKZqmC/U+/aNoCTvZvuVNcaoEDmqKlxhlpSX
         64pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=REXnOozYUjmSz9tnv6vKVi2FmcOT+TdEKl6P4HhkKlU=;
        b=LvL6nGltZzSabbSATocDn8eXuWWFgu0ZnZbCXEJAnKHSflvN8GfS7prZZWhEw0mqmJ
         RYbc7vUInYxHHGu9AuOBXAWPuofGdEPEzcEPOAr1Dp01u2cToPMhTMro0zjCAVyA2/Kq
         1BE6s9MO2w1TjrlD4oiDtxVvtYrfl8mBVsnCfnAYyMq88Nz1yXKMyoJusch2laEJmc7W
         PTTDTVZ8ks/wBD1wb4sJOkPllUKrTsjlPIYuyrMmzh9bsn5rhQMQf+FRaVR4flQ2Le0x
         h+JgumXgnzvzG525J4g2/pQBvZrzfkAbQwU/uP4NPT4wHuwc9JZnqZ+cyq5YHHYKlwfs
         5Jug==
X-Gm-Message-State: AOPr4FVfaoACtOf/tN391gmpmY6wBlp/8sbvJwe0neiS/qoWuzvjUGW6AbJ5wpkoQ3hIjcGU+SM+xMuhyKDCDA==
X-Received: by 10.129.117.70 with SMTP id q67mr6891862ywc.63.1462385858323;
 Wed, 04 May 2016 11:17:38 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Wed, 4 May 2016 11:17:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293559>

Hi list,

I'm trying to compile/test/use git 2.8.2 on AIX 6.1 with no bash available.
/bin/sh is a hard link to /bin/ksh which is a ksh88, a posix shell.
Is this supposed to work?

As an example: make test fails on nearly every t34* test and on tests
which contain rebase.
The installation of bash (and manually changing the shebang to
/bin/bash) "fixes" all rebase test failures. So obviously git-rebase
is not portable at some point.

Does it make any sense to put work into making these scripts portable,
that is, work with posix shells?
And, as last resort, is it possible to configure git use bash in some
or all shell scripts?

Regards,
Armin
