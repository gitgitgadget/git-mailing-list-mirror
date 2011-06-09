From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 00:55:59 +0200
Message-ID: <201106100056.00256.jnareb@gmail.com>
References: <201106051311.00951.jnareb@gmail.com> <BANLkTinAxWfAgBOOF0gkYDWmXDCRH+6zYg@mail.gmail.com> <20110609223825.GA7771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mike@nahas.com, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:57:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUoAL-0008Az-M9
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab1FIW5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 18:57:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54055 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098Ab1FIW5R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 18:57:17 -0400
Received: by fxm17 with SMTP id 17so1297336fxm.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=SOZpbTmonHz6WHA1zKUxNHtTCqPrtD9N9ictuEjPy7c=;
        b=kwAniwMUTUeMfKdebR2o8Tqo+PAEk0cnI48kycdHKusZAFZ/I0RAkiHyNl2Jg4hEmH
         peHcARWBtb8roMoxF5QRZGwegUe1UkDtg/HskKsBtBfGtaxwuOmWcgxeZNxOpwytuQyD
         dOqcJ7mdKGJguiUrTQzpHyfzIzPLDDQK8BHIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QP+wXWocmjLFk/HEY2KFHiS16Y/jiZqNhnTdwq7Clvv2W/fmObKzpuemiLz0hWZofr
         Snqn05EYAE0IHjfaH036IRPJ/vt2dk08UMEF72jq0DaVMKzjMj9rfcp/Y8sy3lyLeuEJ
         Qutr2U3zgKBvhkc6eowp02jts47iGgart2CBQ=
Received: by 10.223.62.146 with SMTP id x18mr224fah.54.1307660166095;
        Thu, 09 Jun 2011 15:56:06 -0700 (PDT)
Received: from [192.168.1.15] (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id e16sm827518fak.17.2011.06.09.15.56.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 15:56:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110609223825.GA7771@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175587>

On Fri, 10 Jun 2011, Jeff King wrote:
> On Thu, Jun 09, 2011 at 06:27:11PM -0400, Michael Nahas wrote:

> > Jakub: "it is unnecessary power"
> > Yeah, like that an argument that anyone here will listen to.  "I can't
> > let you have diff3.  It's too much power for you.  You might trash the
> > repository with ... uh... diff3."
> 
> It's also wrong. Diff already does combined diff on arbitrary trees. So
> unnecessary, perhaps, but already there.

BTW. I should have written "too much flexibility", not "too much power".
What I had in mind is _convention_-based branching model in Subversion,
and its svn:mergeinfo property... which allow things like recording
cherry-picking, partial merges (of subtree), comitting on a tag or
commits over more than one branch... but which things are usually user's
error, not prevented by a tool.
 
> > Peff: "... use tokens to describe non-treeish sources and destinations"
> > What defines "tree-ish"ness?
> 
> I was using tree-ish there in the sense that it is used in the git
> documentation, which is: a reference that can resolve to a git
> tree object. So a tree sha1, a commit sha1 (which would resolve to its
> tree), a tag that points to a tree or commit, a ref that points to any
> of the above, and so on.
> 
> I think it is actually dying out from git documentation, though.  I was
> writing to Junio there, who I know understands that term, but I should
> have been more mindful that other readers of the thread wouldn't.

Historical note: "tree-ish" (now just "tree") were once called "ents" :-)
c.f. 3f0073a (Axe the last ent, 2006-08-21)

    Axe the last ent
    
    In the name of Standardization, this cleanses the last usage string of
    mystical creatures.  But they still dwell deep within the source and in
    some debug messages, it is said.

> > Do you know of anything in the INDEX file that would not be visible
> > from NEXT/WTREE/OURS/THEIRS?
> 
> The stat information, but that is usually ignored in porcelain, anyway
> (we refresh the state information at the beginning of most porcelain
> commands, so you can just assume everything is up to date with the
> working tree and will be shown as such).

Hmmm... there is additional complication that I haven't thought about,
namely assume-unchanged bit, and partial checkouts.

-- 
Jakub Narebski
Poland
