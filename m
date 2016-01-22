From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] status: be prepared for not-yet-started interactive
 rebase
Date: Fri, 22 Jan 2016 20:02:45 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601222000040.2964@virtualbox>
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de> <vpqlh7h5zrh.fsf@anie.imag.fr> <xmqqio2lv4rg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:03:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMgzB-0001sX-KK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 20:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbcAVTCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 14:02:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:60090 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbcAVTCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 14:02:54 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LfBX6-1ZlN671WDQ-00omGM; Fri, 22 Jan 2016 20:02:47
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqio2lv4rg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Dbe6RXMIqagGOfEFThG6I/lkV0k6LFHOAmhxh5Wi/8gjUVgxgvB
 8pfamW7h6Tg3qE0GzeFhmhBQU5Z53GNpQm3seNVE+oUxFcTKvmlI5KYQWayqXZ8gbaEh7eS
 Svlm5Rr3tqUvkReePouwEacM1qRjTEjUcjbRNVFf5Q0QpGV3jzprjSNgHrfHQsATLRBBcdO
 xIN/uf9g7VYSyKqRALfRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cnBtp7pVYvA=:GPn5hYo1qyscEx1vQL78OE
 CzOB+jCDInOPN6N6Z6mcE3dxbsO3MMxfMswPg03tZ+g486wLrQohBUtImMYByZbNAZxgSdlvE
 T9E90Sfp3nIRxh51SkfqbrnbTZ68PPhfN3Ao2feYgMnks/PW8dHGLv+y25heBm8Wq3VGdfN7x
 RBoEm20tEUn/fGQJlgVK9k9eH1ZNWHTkffsc9P78wPOicaecXA1P/gYhUV8Plq4V1Lr1WPLtj
 0YUrrrk6Q/KqH6gMJZ16+thvQemXkf1ChfYTFVDb844WkV+R2CF3JpwHQ8sCpLxo1XdzFDp/W
 Wr4B7b1Vso7lzm16PtfuxtWvaLS6ScZJSkkEn/gBMCXlTslwC/7sZJqA0Fm5Qd4BpVTNgLoB7
 G27fbX2xk22omQOL/U0I76s5zmQD6v2JdGCw/pz3rAhjyposRvvSSiXWz2bMGtYq3IuPVWiz3
 eKUFWkdv5ysg0zSvAoiDrBo15roPv7FzrQeggy6FvtLGERXhC4zwUq5E7/WkEdsPHDlVYQQ0B
 wHjPYOWmTrwDrSYHMroJPmAhKgE43se9bnFlcpdphAK1bqmMnrySGG0HLmOStRbVMWX8s5UVU
 ahGdqSUCJr0ysLYYQB30ZuQF3A6p6jtqp1E5wRv8C9TRA9C83xqvckWEC8KNbmnnc+q9vR1+Z
 H7a23TJDTtKonL+HNLhMhZw/tO5evvXoObBRp3kSi78pvV5Rwwehemg6l5hTS4sAle2PD0dK2
 IC4rn3wT1GqOr+J/Yqyc8PaM/a3W09k79nIXicvjJw31my8gnbHwPRm/KMRX7sn7dZznKH9a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284582>

Hi Junio,

On Fri, 22 Jan 2016, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >>  wt-status.c | 22 +++++++++++++++-------
> >>  1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > Looks good to me. You may want to add a test by overriding $EDITOR to a
> > script doing "git status >actual" if you want to have fun with testing.
> 
> I am unhappy that the code does not read 'rebase-todo' at all when
> 'done' is missing.

At this point is virtually certain that the edit script is opened in an
editor, and very likely to change. So it makes little sense to look at the
todo.

Ciao,
Dscho
