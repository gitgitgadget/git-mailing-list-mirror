From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bisect.sh: don't accidentally override existing
 branch "bisect"
Date: Sat, 3 May 2008 13:48:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805031347460.30431@racer>
References: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org> <20080502082232.GA20020@diana.vm.bytemark.co.uk> <7v8wysy5bz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1493839463-1209818933=:30431"
Cc: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 14:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsHBQ-0002D0-JF
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 14:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114AbYECMs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 08:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbYECMs4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 08:48:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:46302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751794AbYECMsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 08:48:54 -0400
Received: (qmail invoked by alias); 03 May 2008 12:48:52 -0000
Received: from dslb-088-067-214-063.pools.arcor-ip.net (EHLO dslb-088-067-214-063.pools.arcor-ip.net) [88.67.214.63]
  by mail.gmx.net (mp026) with SMTP; 03 May 2008 14:48:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hse50o6dh9c0GOIp5w520BBr/WbxSb8r1sqjEcn
	HvlRkaOdXt7ilT
X-X-Sender: gene099@racer
In-Reply-To: <7v8wysy5bz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81076>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1493839463-1209818933=:30431
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 2 May 2008, Junio C Hamano wrote:

> Karl Hasselström <kha@treskal.com> writes:
> 
> > On 2008-04-30 16:46:13 +0000, Gerrit Pape wrote:
> >
> >> If a branch named "bisect" or "new-bisect" already was created in the 
> >> repo by other means than git bisect, doing a git bisect used to 
> >> override the branch without a warning. Now if the branch "bisect" or 
> >> "new-bisect" already exists, and it was not created by git bisect 
> >> itself, git bisect start fails with an appropriate error message. 
> >> Additionally, if checking out a new bisect state fails due to a merge 
> >> problem, git bisect cleans up the temporary branch "new-bisect".
> >
> > Makes me wonder why bisect has to use a branch at all, and not just a 
> > detached HEAD ... I seem to recall this having been discussed before, 
> > but I can't find it now.
> 
> Only because the mechanism predates detached HEAD and no other reason. 
> Whoever wants to update it to use detached HEAD needs to design what 
> should happen when the bisection was started while the HEAD is detached 
> (should we come back to the same HEAD?  how? ...), but other than that I 
> do not offhand see fundamental difficulties.

IMO it should behave as the rebase machinery does: record $(git rev-parse 
HEAD) in the case of a detached HEAD, and go back to that.  It is dead 
easy.

Ciao,
Dscho

--8323329-1493839463-1209818933=:30431--
