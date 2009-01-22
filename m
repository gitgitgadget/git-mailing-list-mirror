From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2009, #05; Wed, 21)
Date: Thu, 22 Jan 2009 06:13:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901220606040.3586@pacific.mpi-cbg.de>
References: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 06:14:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPrtR-00059q-VV
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 06:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbZAVFMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 00:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbZAVFMy
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 00:12:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:35945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182AbZAVFMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 00:12:53 -0500
Received: (qmail invoked by alias); 22 Jan 2009 05:12:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 22 Jan 2009 06:12:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eup1SQxMe4grsq/XxksMEY2lqbvI9RNY8v49GRe
	FpTpMGriq6NK0M
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106721>

Hi,

On Wed, 21 Jan 2009, Junio C Hamano wrote:

> * js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
>  + git-notes: fix printing of multi-line notes
>  + notes: fix core.notesRef documentation
>  + Add an expensive test for git-notes
>  + Speed up git notes lookup
>  + Add a script to edit/inspect notes
>  + Introduce commit notes
> 
> It would be nice to hear a real world success story using the notes
> mechanism before casting this design in stone.

I'd like to have some profiling done before that.  For example, I am still 
a bit unsure how the things would perform with a 50-deep delta chain for 
a notes tree having 50,000+ notes in it (which I think will not be all 
that unreasonable for a medium-sized project that stores bug-tracking 
information in the notes).

I have a gut feeling that the performance dip I saw is a direct result of 
doing away with the fan-out "subdirectories": remember, originally, I had 
a tree structure much like the loose objects in .git/objects/??/, while 
Peff convinced me that a flat tree object should be enough.

I could be wrong on that, though.

> * js/patience-diff (Thu Jan 1 17:39:37 2009 +0100) 3 commits
>  + bash completions: Add the --patience option
>  + Introduce the diff option '--patience'
>  + Implement the patience diff algorithm

There is this one issue that my patience's output differs from bzr's.  
Since the patience diff algorithm is so lousily documented, I do not know 
if it is due to my misunderstanding the algorithm, or due to bzr doing 
something clever in addition.

I'd be thankful if somebody could clarify that issue.

Ciao,
Dscho
