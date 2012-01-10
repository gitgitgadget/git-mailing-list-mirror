From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Please support add -p with a new file, to add only part of the file
Date: Tue, 10 Jan 2012 15:07:16 +0100
Message-ID: <87ty43fy7f.fsf@thomas.inf.ethz.ch>
References: <20120109105134.1239.39047.reportbug@leaf>
	<20120109204721.GC23825@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Josh Triplett <josh@joshtriplett.org>, <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 15:07:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkcMI-0003XB-Hw
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 15:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab2AJOHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 09:07:21 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:24018 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab2AJOHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 09:07:20 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 15:07:16 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 15:07:17 +0100
In-Reply-To: <20120109204721.GC23825@burratino> (Jonathan Nieder's message of
	"Mon, 9 Jan 2012 14:47:21 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188249>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Josh Triplett wrote:
>
>> I recently found myself with a new file that I needed to check in part
>> of with several commits.  I wanted to use "git add -p newfile" and use
>> 'e' to add and commit several times (along with corresponding bits in
>> existing files).  However, "git add -p" does not work on a new file,
>> only an existing file.
>
> Yep.  A workaround is to use "git add -N newfile" before running
> "git add -p newfile".
>
> I imagine "git add -p '*.c'" should also offer to add hunks from
> source files that git doesn't know about yet, too.
> 
> Here's a quick demo (untested) that might _almost_ do the right thing.
> Unfortunately it leaves intent-to-add entries around even for files
> the operator rejects.  Anyway, maybe it can be a good starting point
> for playing around.

I think a proper solution needs a way to generate a diff that includes
all of the named files (even untracked).  AFAICS there is no such
feature in the diff-* commands right now.

A not-so-proper solution might of course start by looking at which files
are untracked, and only run the 'git add -N' immediately before patch
application.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
