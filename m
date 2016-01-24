From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] convert: add a helper to determine the correct EOL
 for a given path
Date: Sun, 24 Jan 2016 11:42:10 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601241141360.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de> <xmqqegd9v4bl.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601222003360.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:42:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNI7g-0001xu-9a
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 11:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbcAXKmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 05:42:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:58409 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbcAXKmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 05:42:16 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LfTC1-1Zm0RZ1s3l-00p3Nd; Sun, 24 Jan 2016 11:42:12
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1601222003360.2964@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:HZXxpIAI3QCWmIQ/qRBVl0Bhp5R20ggsgXtGLkyK8E49+A42ayM
 dKgT45HpvW0r/gSo4BO8L7EL7BcqpDklGOHbHez8rIs8hAklOVU5MiburCUIo5EInTed6PG
 Qb9AfQjRpO/7jxRpPj9FccQlofgikZgAxIE/cPzOzJGEUblVf9+D4/Tu08RBNlLBvu4b/FJ
 dLcOjEdL8MAwnF+ERhohA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IO7nqPwUOnM=:aWsKYJiUZASclRG+JMpHYO
 Vuk5513t6Tkvv6gV41p6G0hEGJiAuuvckcABsMO0OyOHKvQGjBbXCTqWyiZiHIoyS+IZQ5jQE
 LV0nGh0X6e4ou2NMLrv9wly2gL+huU9pilQ9BYToFVFGRbFOZcAHtcU36wS/SJx2KYd4FmgXm
 6fBVPjdgm56Ert4EWkrd6sDZXHMd98LFW1glSH/BAvz1BL2FFgK9UHXy47pFECHWbwunhSDkJ
 LMSvyQLPQ19ONhn/ObC8HY0qpodLVhqOwP0upBCW7Pm9PHG4nQB6UfDJqbLQjAe3pLNhIZMcr
 0idRVx5dHzrBjCxhJOBvII2LPvSboaKv3GXA4EeLBSqJuJslhE9A5XRj9Pgn/DYMoV+ajDehI
 oL96XofCidwOHJFRZQfusKHEToSpieapbZb+QJneus8GnGqf5j2wr+U1nwN5Yd45CiBTx09qh
 mdVipgIRN/ZNpnV8VpDIAldQ5zG5pl+Sn4+C+nQmpK/nAnFblqtD6YUQVr2lqOPkPqOYLQ7wA
 dQCij/FCsEVON6fNkDFCKM/H6NGP69jcjcwdlWU7nI1XzgX2A2R/PEVaChZ3zDmn11y6WzDEs
 wMUJNo79tZqvDo/J5eHxv29W9aJTucbJNM2H/voQqFz4pvFJpD8YW/JPUtbM49zlmku49hUaq
 BAPsVfzgtTEWd0euYKzkFVToxKMy9/6eNTbe+c7jWU+gyp7EnMRnTBYsP0Tt3ru0nP/kkO20S
 HEaB5RyFoWNl+Zhhr5p2dayQUwCF8oE2NZLP4iwzLhonPLtpDpsYXGBm/zP1hEszigxBKpT/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284641>

Hi Junio,

On Fri, 22 Jan 2016, Johannes Schindelin wrote:

> On Fri, 22 Jan 2016, Junio C Hamano wrote:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > 
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > 
> > This change somehow ringed a bell and reminded me of your recent
> > ls-files stuff.  Are there things that these topics can use from
> > each other?
> 
> Quite possibly. I'll have a look tomorrow.

I did, but could not quite finish reworking the patch until today. Will
send out the result in a moment.

Ciao,
Dscho
