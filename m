From: Alex Neronskiy <zakmagnus@google.com>
Subject: Re: [PATCH] Document the underlying protocol used by shallow repositories and --depth commands.
Date: Mon, 6 Jun 2011 19:56:00 +0000 (UTC)
Message-ID: <loom.20110606T213817-376@post.gmane.org>
References: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com> <7vvcwi95yi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:00:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfyA-0004tZ-Rx
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab1FFUAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:00:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:51133 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1FFUAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 16:00:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QTfy2-0004qZ-3i
	for git@vger.kernel.org; Mon, 06 Jun 2011 22:00:06 +0200
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 22:00:06 +0200
Received: from zakmagnus by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 22:00:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 216.239.45.4 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110422 Ubuntu/10.04 (lucid) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175158>

Junio C Hamano <gitster <at> pobox.com> writes:

> > +Once all the 'want's and 'shallow's (and optional 'deepen') are
> > +transferred, clients MUST send a flush-pkt. If the client has all
> > +the references on the server, and as much of their commit history
> > +as it is interested in, client flushes and disconnects.
> 
> Hmmmmm, are you describing "everything-local then flush and all-done" in
> do_fetch_pack() with the second sentence? If so, placing the description
> here is misleading. In that case, I do not think any of the find-common
> exchange starting from the "upload-request" phase happens.

No, this refers to the same event which was already described in that document,
which I believe happens from inside find_common. It may just be some confusion
on the meaning of "having a reference" on my part, but the idea was to point out
that the client could flush at this stage even if it doesn't have every commit.

I tried to amend the existing wording but I suppose it was just misleading, so
it's better to write something else entirely.
