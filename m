From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Fix Git GUI in Git for Windows 2.x
Date: Fri, 30 Oct 2015 20:09:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510302009310.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Fri Oct 30 20:09:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsF3j-00058h-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760558AbbJ3TJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:09:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:63744 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbbJ3TJu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:09:50 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MQeET-1a42rp0DPh-00U6qa;
 Fri, 30 Oct 2015 20:09:48 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:p29vPiSbyCctA6vlX7+GClYzGnKOVo/GVvTZzlWgv88LVYpxqeX
 HAuYsxljE/b248bqA7wJTiTjFgyicO0dfQOuXCmltIYKM6k8pyiZrKLR4dfaGgVq23ulwkX
 RttHQRjGq8VP/pbdPWRmrJ8Drhh/HQn9gG11+VluylGkktoSZLTz3aM9/vSmE6Z8UpbqO92
 JeW2rS0P9BxxcSAGvolgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ASugyGceiXA=:IjFgfEFYX1DeTroFF5L/NM
 FPVOvm4kTsJjwGjzUxLAP9HvmJH6Bss55EloCcsjkc1VootVMzhJSU6wywHmcJE2XwCKZW6QD
 7RFxt/N6yQ/8O0UhRReQf7rFnNZgSqwVbuYKx2DXj5FlY7z1PI7YP6mUJ3Dy474RR9NvKJeTb
 N6FNZNEcZNKOOs1FkX3rPQJjNoA8ho6Rem6xV/UpDSe+oecwyz7Mx6K/vIU3zDAJRbYIEhD4u
 ZR+Bes+ciNLHs8Pgm2sjr51wh2AQPlqPxBcaWZf9xYsI90oFzJLUGZ1ldxRIn3R5ETeaVZOEF
 n0JMpyT//cI9rbRA2GzEShwIUjvgyXzeDkWK6uOJQsHx+AqGwHZ4ZQO2lrqOgLGvA4/mc5ETE
 +gD7DhNZX7CJ26ulJKz4mj+lbvQ1r4e0H/Mvq6ayZ9gT+zpGIjpjg/6FSW8DNQLi8CX8SDBUJ
 n2d4DKHNhGQymH3K3mYkrddQLzBWyIOigL+kGdZGclbyyK5y0KhrvkLI2FaBQhn7yrriKlPA+
 nBsUDWLOCIDG9IkffOLnNm8I20GfNWjeKrDdedzqx+uuidEUeEQ8Kv/mndludj+49VslozK0t
 TDw0V88wpW/P0M2EpAtewIhAiIfWEL0LMJ+b8pSEkCrmZTYnxqVKZEwL3nKnaxt6RW8dw1aTw
 aR2XVWj3E2l0exDdChqJ82Dj4Gwj+5C1F0DYiStM65sQlWI8wIRqilUBO4GZGTUv2eNTfbOL0
 IZi7J0k1tkZBhzQuNyp+xXbb4c2NFvBUnPtR8Vm+yMjgBDeydmqvbGgzNzB5wG4yyyZ8fKM5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280523>

With the switch to 2.x, Git for Windows started relying on MSys2
instead of MSys. This also implies that we now have the `cygpath`
tool that was formerly used to determine whether we're running
Cygwin or MinGW/MSys.

Another issue: the code behind Repository>Create Desktop Icon
generated a `.lnk` file that fails to launch the Git GUI in Git
for Windows 2.x.

This topic branch fixes both bugs.


Johannes Schindelin (2):
  git-gui: fix detection of Cygwin
  git-gui (Windows): use git-gui.exe in `Create Desktop Shortcut`

 git-gui.sh       | 10 ++++------
 lib/shortcut.tcl | 14 ++++++++++----
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.5.3.windows.1.3.gc322723
