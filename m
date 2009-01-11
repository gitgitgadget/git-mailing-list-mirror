From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 20:32:18 +0100
Organization: private
Message-ID: <86iqol8wql.fsf@broadpark.no>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
 <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 20:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM649-0005VQ-4M
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 20:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbZAKTcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbZAKTcV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:32:21 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:45611 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbZAKTcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 14:32:20 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00H7ENLVW1C0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 20:32:19 +0100 (CET)
Received: from localhost ([80.203.78.153]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00BF2NLUQE10@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 20:32:19 +0100 (CET)
In-reply-to: <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105200>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 11 Jan 2009, Kjetil Barvik wrote:
>
>> ---
>> :100644 100644 ae96c64... e6d1d2b... M	diff-lib.c
>
> I wonder what that line is all about, since ...
>
>>  diff-lib.c |   40 +++++++++++-----------------------------
>>  1 files changed, 11 insertions(+), 29 deletions(-)
>> 
>> diff --git a/diff-lib.c b/diff-lib.c
>> index ae96c64ca209f4df9008198e8a04b160bed618c7..e6d1d2b34147a13aadb5019e0c8336ef5f56ee39 100644
>
> ... we have the information right there already.
>
> Ciao,
> Dscho

  hmmm, I tried the following commands

jetil@localhost ~/git/git $ git pull   
Already up-to-date.
kjetil@localhost ~/git/git $ git checkout -q my_origin_maint && grep symcache *.c
diff-lib.c:	char symcache[PATH_MAX];
diff-lib.c:	symcache[0] = '\0';
diff-lib.c:	char symcache[PATH_MAX];
diff-lib.c:	unpack_cb.symcache[0] = '\0';
diff-lib.c:	unpack_cb.symcache[0] = '\0';
kjetil@localhost ~/git/git $ git checkout -q my_origin_master && grep symcache *.c
diff-lib.c:	char symcache[PATH_MAX];
diff-lib.c:	symcache[0] = '\0';
diff-lib.c:	char symcache[PATH_MAX];
diff-lib.c:	unpack_cb.symcache[0] = '\0';
diff-lib.c:	unpack_cb.symcache[0] = '\0';
kjetil@localhost ~/git/git $ git checkout -q my_origin_next && grep symcache *.c
diff-lib.c:	char symcache[PATH_MAX];
diff-lib.c:	symcache[0] = '\0';
diff-lib.c:	char symcache[PATH_MAX];
diff-lib.c:	unpack_cb.symcache[0] = '\0';
diff-lib.c:	unpack_cb.symcache[0] = '\0';
kjetil@localhost ~/git/git $ git checkout -q my_origin_pu && grep symcache *.c
diff-lib.c:	char symcache[PATH_MAX];
diff-lib.c:	symcache[0] = '\0';
diff-lib.c:	char symcache[PATH_MAX];
diff-lib.c:	unpack_cb.symcache[0] = '\0';
diff-lib.c:	unpack_cb.symcache[0] = '\0';
kjetil@localhost ~/git/git $ cd 
kjetil@localhost ~ $ mkdir git2
kjetil@localhost ~ $ cd git2                                          
kjetil@localhost ~/git2 $ git clone -q git://git.kernel.org/pub/scm/git/git.git
kjetil@localhost ~/git2 $ cd git/
kjetil@localhost ~/git2/git $ git show e6d1d2b34147a13aadb5019e0c8336ef5f56ee39
     outputs => 
            fatal: bad object e6d1d2b34147a13aadb5019e0c8336ef5f56ee39
kjetil@localhost ~/git2/git $ git show e6d1d2b
     outputs => 
            fatal: ambiguous argument 'e6d1d2b': unknown revision or path not in the working tree.
            Use '--' to separate paths from revisions
kjetil@localhost ~/git2/git $ git show -- e6d1d2b
     outputs => (nothing)

  Can you explain to a new git user?  As far as I can tell, I do not see
  that this patch is included in the public awailable git tree.  Where
  should the patch be?  I can not see it...  help!  

  -- kjetil
