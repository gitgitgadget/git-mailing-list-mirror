From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fread does not return negative on error
Date: Wed, 24 Jun 2009 12:03:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906241201040.4773@pacific.mpi-cbg.de>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu> <25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com> <4A3FB479.2090902@lsrfire.ath.cx> <7vhby64i8f.fsf@alter.siamese.dyndns.org> <20090624081819.GA10436@elte.hu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1678002513-1245837811=:4773"
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	roel kluin <roel.kluin@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jun 24 12:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJPJ6-0004zt-OI
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 12:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZFXKCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 06:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbZFXKCG
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 06:02:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:50326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751602AbZFXKCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 06:02:05 -0400
Received: (qmail invoked by alias); 24 Jun 2009 10:02:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 24 Jun 2009 12:02:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+htDFJ4O+h/JpKDnyg+E8ltONQMsj6BR+TJnGAtK
	Uo/uFZmtfeHD/B
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090624081819.GA10436@elte.hu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122134>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1678002513-1245837811=:4773
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 24 Jun 2009, Ingo Molnar wrote:

> One bookeeping issue: i found few explicit credits in those files - 
> so i noted in the changelog that i took them from Git and i noted 
> the specific upstream Git sha1 when i copied them. Would be nice to 
> update each file with names to make credit more explicit:
> 
> -rw-rw-r-- 1 mingo mingo  2808 2009-06-23 10:49 abspath.c
> -rw-rw-r-- 1 mingo mingo  1447 2009-06-23 10:49 alias.c
> -rw-rw-r-- 1 mingo mingo  4660 2009-06-23 10:49 cache.h
> -rw-rw-r-- 1 mingo mingo  4817 2009-06-23 10:49 color.c
> -rw-rw-r-- 1 mingo mingo  1187 2009-06-23 10:49 color.h
> -rw-rw-r-- 1 mingo mingo 19149 2009-06-23 10:49 config.c
> -rw-rw-r-- 1 mingo mingo  1041 2009-06-23 10:52 ctype.c
> -rw-rw-r-- 1 mingo mingo   256 2009-06-23 10:49 environment.c
> -rw-rw-r-- 1 mingo mingo  3262 2009-06-23 10:49 exec_cmd.c
> -rw-rw-r-- 1 mingo mingo   496 2009-06-23 10:49 exec_cmd.h
> -rw-rw-r-- 1 mingo mingo  8515 2009-06-23 10:49 help.c
> -rw-rw-r-- 1 mingo mingo   751 2009-06-23 10:49 help.h
> -rw-rw-r-- 1 mingo mingo  2592 2009-06-23 10:49 levenshtein.c
> -rw-rw-r-- 1 mingo mingo   201 2009-06-23 10:49 levenshtein.h
> -rw-rw-r-- 1 mingo mingo  1909 2009-06-23 10:49 pager.c
> -rw-rw-r-- 1 mingo mingo 12454 2009-06-23 10:49 parse-options.c
> -rw-rw-r-- 1 mingo mingo  5693 2009-06-23 10:49 parse-options.h
> -rw-rw-r-- 1 mingo mingo  7986 2009-06-23 10:49 path.c
> -rw-rw-r-- 1 mingo mingo 10442 2009-06-23 10:49 quote.c
> -rw-rw-r-- 1 mingo mingo  2667 2009-06-23 10:49 quote.h
> -rw-rw-r-- 1 mingo mingo  7966 2009-06-23 10:49 run-command.c
> -rw-rw-r-- 1 mingo mingo  2838 2009-06-23 10:49 run-command.h
> -rw-rw-r-- 1 mingo mingo   969 2009-06-23 10:49 sigchain.c
> -rw-rw-r-- 1 mingo mingo   215 2009-06-23 10:49 sigchain.h
> -rw-rw-r-- 1 mingo mingo  7270 2009-06-23 10:49 strbuf.c
> -rw-rw-r-- 1 mingo mingo  4995 2009-06-23 10:49 strbuf.h
> -rw-rw-r-- 1 mingo mingo   556 2009-06-23 10:52 string.c
> -rw-rw-r-- 1 mingo mingo   120 2009-06-23 10:52 string.h
> -rw-rw-r-- 1 mingo mingo 13859 2009-06-24 10:01 symbol.c
> -rw-rw-r-- 1 mingo mingo  1112 2009-06-23 10:52 symbol.h
> -rw-rw-r-- 1 mingo mingo  1690 2009-06-23 10:49 usage.c
> -rw-rw-r-- 1 mingo mingo  9878 2009-06-23 10:52 util.h
> -rw-rw-r-- 1 mingo mingo  4249 2009-06-23 10:49 wrapper.c

This here script:

-- snip --
for file in abspath.c alias.c cache.h color.c color.h config.c ctype.c \
	environment.c exec_cmd.c exec_cmd.h help.c help.h levenshtein.c \
	levenshtein.h pager.c parse-options.c parse-options.h path.c \
	quote.c quote.h run-command.c run-command.h sigchain.c sigchain.h \
	strbuf.c strbuf.h string.c string.h symbol.c symbol.h usage.c \
	util.h wrapper.c
do
	echo $file
	git shortlog -n -s $file | head -n 2
done
-- snap --

outputs this (note that a few files you mentioned are not in git.git):

abspath.c
     2	Junio C Hamano
     1	Dmitry Potapov
alias.c
     2	Jeff King
     1	Felipe Contreras
cache.h
   295	Junio C Hamano
    98	Linus Torvalds
color.c
     4	Junio C Hamano
     3	Jeff King
color.h
     2	Jeff King
     2	Johannes Schindelin
config.c
    65	Junio C Hamano
    20	Johannes Schindelin
ctype.c
     4	René Scharfe
     2	Junio C Hamano
environment.c
    29	Junio C Hamano
    11	Johannes Schindelin
exec_cmd.c
     8	Johannes Sixt
     7	Junio C Hamano
exec_cmd.h
     2	Junio C Hamano
     2	Scott R Parish
help.c
    18	Junio C Hamano
    14	Christian Couder
help.h
     2	Miklos Vajna
     1	Alex Riesen
levenshtein.c
     2	Johannes Schindelin
     1	Mike Ralphson
levenshtein.h
     1	Johannes Schindelin
pager.c
     9	Junio C Hamano
     4	Johannes Schindelin
parse-options.c
    18	Pierre Habouzit
     8	Junio C Hamano
parse-options.h
    15	Pierre Habouzit
     6	Stephen Boyd
path.c
    20	Junio C Hamano
     5	Johannes Sixt
quote.c
    12	Junio C Hamano
     5	Christian Couder
quote.h
     6	Junio C Hamano
     5	Christian Couder
run-command.c
    11	Shawn O. Pearce
     7	Johannes Sixt
run-command.h
    10	Shawn O. Pearce
     5	Johannes Sixt
sigchain.c
     2	Jeff King
sigchain.h
     2	Jeff King
strbuf.c
     9	Pierre Habouzit
     8	Junio C Hamano
strbuf.h
     9	Pierre Habouzit
     4	Junio C Hamano
string.c
string.h
symbol.c
symbol.h
usage.c
     3	Linus Torvalds
     2	Junio C Hamano
util.h
wrapper.c
     4	Junio C Hamano
     2	Linus Torvalds

Ciao,
Dscho

--8323328-1678002513-1245837811=:4773--
