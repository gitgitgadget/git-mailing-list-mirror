From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Sun, 1 Nov 2015 14:37:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511011436550.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de> <5631AB75.5030800@gmail.com>,<alpine.DEB.1.00.1510301941170.31610@s15462909.onlinehome-server.info>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA0B@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Victor Leschuk <vleschuk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 14:37:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsspU-0003OO-Sz
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbbKANhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 08:37:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:58626 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbbKANhr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:37:47 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MN748-1ZqfuK3kEK-006bjP;
 Sun, 01 Nov 2015 14:37:36 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA0B@mail.accesssoftek.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:PtH5U3o8TD+CutMlnW2CpDEO2aqmuGC4kzU+N9ewp7+FBaF0sap
 J7LpA0MJZ3+jiismNuAXG1+5VydEjlg+UcNQN9y/fR694ihiD2b3Q5xWpC01R/DYt7q04tV
 zZjXnt+s4a4wivpij0PAtOIdQ5Qo2BRyt0vWpOfGwcA2l6keyTth/HPUy+yg7mk8p8YWcP6
 ygMpa6pGFPKFS1ZRmh+Ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R4tjHceES0I=:6CDFBTfXdxE7mf2W5Z1fsY
 1vDjnVnnuHahZVVI0flzv+iLZ7UAavE5ihZI7nZKa9HfdoX3K3aElOpQkhG6DQ2c09S9dUp6j
 j0TnMlLXHdHSyLpmu0/eb8KmbdSq8BXzUdvR+5Hl52EYjox3bZnKvLv5WL3g2elK9dLnlCCYa
 Zvd7gHdwRRm/FfrD1ted+V0+4zHW+5FP5REjaq1VU3whIG+dVRGttDoN3x2p3IQQXXqjEAmPm
 Fy+gvnu2JBb7BLvb6ATIhWpnsXQvUaQrSZ7Y/eXrxWbXocVEoSa1fk3jMxmTDEZ8/nnqx9Yem
 ZzCRiNqsx4C0/61RziGTCjQfELMscHEzi+f+SKA1yB8pjNFxMcy6H2HgTW5fzcDsrXPqEyfAX
 /h1eGwWs/pGiZDgR5+d8R7jJ+z5gNP8AthY1Cs+lWlwIDW2fp5a5bZDezvZ1ab16UjQSy40JW
 P9plXquVmu+53IuAAP4zhSsMpHjMBumcBDnkn6wl9VXyw2I03qQdZh7TkPHG/UoDxBF2Ni/yV
 H+4aqcGY+9FhQVNG8eXTkdWtfJDkDeU64+SQEm+GHxrDQl1XdBiOUEu3rEDEspeDjpcd/WP0D
 swlA2hFOKCS/LmG7O9VhKFkOb65zbfhYSXQk5ERtNrGlWmOsuG1c6zazPamIvauQrQPKOKdhd
 nkuZ+CMm/WTWOSEMz3G2HGxT9PXsjsW+NixvlQUN9LyrRSaKS8yzpWx94x6DLmkW7skmjQcus
 CIupvYdOn0/DKaHuiVpoJs4xJKpP1x9QPqeR/cbJx5GS6j6dY23W6ijs9bsd4AXrE/z/yAhB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280617>

Hi Victor,

On Sat, 31 Oct 2015, Victor Leschuk wrote:

> > >   +if test -n "$TEST_GDB_GIT"
> > > +then
> > > +   exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> > Maybe we could make $TEST_GDB_GIT not just a boolean flag? It would be useful
> > to contain "gdb" executable name. It would allow to set path to GDB when it
> > is not in $PATH, set different debuggers (for example, I usually use cgdb),
> > or even set it to /path/to/gdb_wrapper.sh which could contain different gdb
> > options and tunings.
> 
> > Sure, as long as TEST_GDB_GIT=1 still works. Why don't you make an add-on
> > patch and submit it?
> 
> Sure, I will prepare the patch as soon as this one is included in master.

Excuse my asking: why do you want to wait?

Ciao,
Johannes
