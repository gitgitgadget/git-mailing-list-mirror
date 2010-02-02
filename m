From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
 with no changes written
Date: Wed, 3 Feb 2010 00:00:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>  <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>  <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>  <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
  <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>  <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>  <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com> <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcRdT-0002Y9-Qw
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab0BBWyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 17:54:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:33807 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932213Ab0BBWyO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 17:54:14 -0500
Received: (qmail invoked by alias); 02 Feb 2010 22:54:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 02 Feb 2010 23:54:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lRVIcAzflWfE3oojpcBjY7ZtANE/oGJF/NZAItt
	20sAi4DM5FTTUH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138776>

Hi,

On Tue, 2 Feb 2010, Eugene Sajine wrote:

[somebody wrote this, I suspect it was Wincent]
>
> > Why should Git care about how you exited from your EDITOR? All it 
> > should care about is the contents of the commit message, and the exit 
> > code of the editor.
> 
> It doesn't matter which editor is used. The only thing that matters is 
> that you saving or not saving on exit from editor. If not saving - abort 
> the action.

No. If not saving, then it means that the user was fine with the message 
as-is.

Remember, --amend is usually for amending the _content_ of the patch, not 
so much the message.

Of course, you could come up with wonderfully complicated strategies such 
as "if nothing was added, then an unmodified commit message means 'abort', 
else it means 'go ahead'", but I hope that you agree that this would be 
very bad from the users' POV: it would be utterly confusing.

Ciao,
Dscho
