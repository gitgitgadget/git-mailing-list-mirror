From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 23:25:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608212323420.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com> 
 <20060821101346.GA527@diku.dk>  <59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
  <Pine.LNX.4.63.0608212227040.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <59ad55d30608211337jabd515bra3566fbd0f7ba5a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1109977328-1156195523=:28360"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 23:26:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFHHK-0004Ik-60
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 23:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWHUVZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 17:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWHUVZ0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 17:25:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:33234 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751148AbWHUVZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 17:25:25 -0400
Received: (qmail invoked by alias); 21 Aug 2006 21:25:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 21 Aug 2006 23:25:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <krh@bitplanet.net>
In-Reply-To: <59ad55d30608211337jabd515bra3566fbd0f7ba5a0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25824>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1109977328-1156195523=:28360
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 21 Aug 2006, Kristian Høgsberg wrote:

> On 8/21/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Mon, 21 Aug 2006, Kristian Høgsberg wrote:
> > 
> > > Thanks to all who reviewed the patch, here's an updated version which
> > > should address all issues.
> > 
> > I would have preferred the use of path_list instead of rolling your own
> > thing with qsort(), but oh well.
> 
> Yeah, I saw that, but since I got flack for computing
> lookup_commit_reference(head_sha1) inside the delete_branches loop, I
> couldn't possibly risk the performance bottle neck of listing the
> branches using a O(n^2) insertion sort.

Insertion sort, as implemented in path_list, has an average O(n log(n)) 
runtime, and a worst-case O(n^2) runtime. Same as qsort...

Besides, it is not like we are dealing with millions of branches here. And 
using path_list _would_ make the code shorter.

Ciao,
Dscho

---1148973799-1109977328-1156195523=:28360--
