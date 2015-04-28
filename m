From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Windows path limites, was Re: [PATCH v5 2/5] setup: sanity check
 file size in =?UTF-8?Q?read=5Fgitfile=5Fgently?=
Date: Tue, 28 Apr 2015 09:21:30 +0200
Organization: gmx
Message-ID: <e7c614c97eb4b1819cec25567a7adc97@www.dscho.org>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
 <20150428060222.GK24580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:21:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymzpr-0004P9-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 09:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbbD1HVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 03:21:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:60386 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbbD1HVf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 03:21:35 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MFuC6-1YY5qn4994-00EuES; Tue, 28 Apr 2015 09:21:32
 +0200
In-Reply-To: <20150428060222.GK24580@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:qsK07BDlePeINSJEL4DntA9ZjorJFz0I8TZM7Mt9+rqb2ruCkUg
 O/yWKmiDbY4tWFM4PJ+nWGpg6p/ub5EO83r3tEatNwazUKAianK10ROvC/LKmAGPC8nIJ9o
 qqCLttVHNXJ8N2FGzV29KUbnFwoWye0vCncPF2jrQy5q5vG5f3t+yeLrhLwzqR7sSioqrdM
 vIcoTlYPgTdNnpMgrWlCA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267908>

Hi Peff,

On 2015-04-28 08:02, Jeff King wrote:

> My understanding is that PATH_MAX is set absurdly low on Windows
> systems (and doesn't actually represent the real limit of a path!).

Well, yes and no. Yes, it is absurdly low on Windows, and yes, it is not the real limit of a path *if you know how to work around it*. Most Win32 API calls actually do have that absurdly low limit, but internally longer paths can be represented (and there is a hack where you prefix the path -- which must be an absolute one for this hack -- by `\\?\`). Keep in mind, though, that even the Windows Explorer is (at least sometimes) limited by the absurdly low path limit.

Note that we have support for `core.longpaths` in Git for Windows (to be submitted just after I get 2.x out), but it is disabled by default because of the Windows Explorer issue.

Ciao,
Dscho
