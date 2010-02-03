From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: aborting rebase -i right at the start, was Re: [BUG] - "git commit
 --amend" commits, when exiting the editor with no changes written
Date: Wed, 3 Feb 2010 10:08:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002031006570.3099@intel-tinevez-2-302>
References: <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com> <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com> <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com> <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de> <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com> <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com> <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
 <40aa078e1002021616s3098bf53la6af93ab0949e7e@mail.gmail.com> <76c5b8581002021655k5f63b81h1c55ae87625fbfc5@mail.gmail.com> <20100203015947.GA4280@neumann> <vpqaavqkc1s.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Eugene Sajine <euguess@gmail.com>, kusmabite@gmail.com,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 03 10:09:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcbEJ-00051Z-2o
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 10:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777Ab0BCJIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 04:08:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:60009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755212Ab0BCJIw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 04:08:52 -0500
Received: (qmail invoked by alias); 03 Feb 2010 09:08:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp043) with SMTP; 03 Feb 2010 10:08:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rQrFr6VjrGoDxNfrkB821ASfedTwnwQbcJS3fA9
	AXESGafL6IHlMM
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <vpqaavqkc1s.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.70999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138817>

Hi,

On Wed, 3 Feb 2010, Matthieu Moy wrote:

> Strictly speaking, an empty [rebase -i] todolist should mean to drop all 
> the patches (like a todolist with just one line would mean to drop all 
> the others). But a user never wants to do that (otherwise, "git reset" 
> would be the right command), so "git rebase -i" considers it as a 
> special case.

Actually, it is a design bug, but it was the only sane way I could think 
of aborting the rebase.

Note that there _are_ users who want to do that ("let me see what commits 
I have, ah, oh, okay, I want none of them"). I am one of those. That's 
where the underadvertised "noop" command comes in.

Ciao,
Dscho
