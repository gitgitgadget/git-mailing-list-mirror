From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH 3/3] git commit: pathspec without -i/-o implies -i semantics during a merge
Date: Fri, 23 Jan 2009 09:51:41 +0000
Message-ID: <53513726-CE1C-4487-B775-440C6DC93DD8@ai.rug.nl>
References: <4978202C.3090703@viscovery.net> <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net> <49779521.9040208@drmicha.warpmail.net> <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com> <20090123094509.6117@nanako3.lavabit.com> <7viqo64kfo.fsf@gitster.siamese.dyndns.org> <7vy6x235ky.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQK5b-0005pW-NM
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 12:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbZAWLTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 06:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbZAWLTN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 06:19:13 -0500
Received: from frim.nl ([87.230.85.232]:57631 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752951AbZAWLTM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2009 06:19:12 -0500
X-Greylist: delayed 5225 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jan 2009 06:19:12 EST
Received: from 82-41-227-224.cable.ubr11.sgyl.blueyonder.co.uk ([82.41.227.224] helo=[192.168.50.101])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1LQIhZ-0001WY-5r; Fri, 23 Jan 2009 10:51:49 +0100
In-Reply-To: <7vy6x235ky.fsf_-_@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106872>


On 23 jan 2009, at 06:21, Junio C Hamano wrote:

> This makes "git commit paths..." form default to "git commit -i paths"
> semantics only during a merge, restoring the pre-v1.3.0 behaviour.   
> The
> codepath to create a non-merge commit is not affected and still  
> defaults
> to the "--only" semantics.

Do you really want to do this? I think this is a pretty large change
that can bite users if they don't know about this -- for example,  
because
they forgot that they are in a merge (it happens..).

FWIW, I'd much rather see a useful error message than this change. If
this change does get in, I think it should be well-documented in the
man pages as well as in the release notes.

- Pieter
