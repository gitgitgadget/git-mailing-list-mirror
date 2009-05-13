From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 20:26:26 +0200
Message-ID: <46a038f90905131126s79e5b8e1qd0c6c100ec836127@mail.gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	 <20090512151403.GS30527@spearce.org>
	 <20090512161638.GB29566@coredump.intra.peff.net>
	 <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>
	 <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
	 <alpine.LFD.2.01.0905131036040.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 13 20:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4JAW-0001PX-Ak
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759695AbZEMS02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758947AbZEMS02
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:26:28 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:62457 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbZEMS01 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:26:27 -0400
Received: by bwz22 with SMTP id 22so818745bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O3QKlEBa6i8VLGTdOYsWBClhQJr0BnnpchGSGesJRgw=;
        b=eR93I15wosm6ERNpKqwGGFg/5kwdcm1ccbRxJLis3i8avtN7Vs/J2CRn64G15tSvc7
         nE1FK53m8rNK7/ohD7HdiZpvKvxnNPzdTxRmoqninDcvpIJ4c/MiLquiVtuWLFaplpwM
         7XpZQwbKRBf7JZoUeAMEONXi6l9DLwbl9x3i0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oCkhd5N41uIbH5jJFmXLncS32ZeGjdPPleFMn/eL4jFIOsHFuDvjeRakpBUd9TMSoI
         k3DU+B2lGuUacCesgMXCKrL4tzgawBLqyJ7hVGoaV6qP9BNu1WbTgyBp5fBH/Y9vdjdM
         0BLfRzmFcnQsGPiYrXr3dCocuE+XGppICpvXE=
Received: by 10.223.122.15 with SMTP id j15mr1096015far.74.1242239186806; Wed, 
	13 May 2009 11:26:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0905131036040.3343@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119082>

On Wed, May 13, 2009 at 7:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So I take it back. A readdir() wrapper is not a good idea. It gets us a
> tiny bit of the way, but it would actually take us a step back from the
> "real" solution.

Do we need to take the real solution to the core of git?

What I am wondering is whether we can keep this simple in git
internals and catch problem filenames at git-add time. This would
allow git to keep treating filenames as a bag of bytes, and it does a
better thing for users.

In cross platform projects, most users don't even know that there are
problems, and even if they do, they don't know what the problems are.

If git add can be told to warn & refuse to add a path with portability
problems, then we educate our users, prevent them from committing
filenames that will later cause trouble to others in their projects,
etc.

from-the-keep-it-simple-and-informative-dept,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
