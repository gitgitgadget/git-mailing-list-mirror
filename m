From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Fri, 10 Jun 2011 17:29:32 +0200
Message-ID: <201106101729.34270.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <20110609004347.GC19715@sigill.intra.peff.net> <BANLkTikamzsiSJqkRjA7nDjRoyEbd32rvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Fri Jun 10 17:29:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV3eg-0005ac-Ua
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 17:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206Ab1FJP3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 11:29:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38974 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199Ab1FJP3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 11:29:44 -0400
Received: by fxm17 with SMTP id 17so1680580fxm.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=dJC0GRwWKycHTnqyfaRF4Z1RcdUK1sz/RA86NxSCl9U=;
        b=nlpC3sYOR2/wVwid+s4XOCLWlrXF6fYbUatvwWWszVbjXZl0/QO3A99khz6wa9XtPd
         p2RNTN6L4YM9HlUQ2Foz9uECklKVhWBFJb1ixItbhwV1rtt9DpTqMY0+NOmDuXmFdPZp
         yA+Hh6YHehvvajjxCK5haibTEUEbU4pSqEgUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EConWUUlWmxCTenTyd3jdccW8ttCcwv0ySQQlU9NwYV6Vw+xbVfJl36vDUmcs3le+0
         OqGseKx+m21doaPx11VHWeEt5a7340I2GuMC/d9kP+v7lDEKQPXhBsnjeEjeyBC8Qvcb
         qkwu3002S7+fU77IxoTr36o+xyVJ2ApHumbYk=
Received: by 10.223.149.70 with SMTP id s6mr2166429fav.66.1307719783587;
        Fri, 10 Jun 2011 08:29:43 -0700 (PDT)
Received: from [192.168.1.15] (abvz126.neoplus.adsl.tpnet.pl [83.8.223.126])
        by mx.google.com with ESMTPS id q21sm1106186fan.40.2011.06.10.08.29.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 08:29:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTikamzsiSJqkRjA7nDjRoyEbd32rvw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175610>

On Thu, 9 Jun 2011, Michael Nahas wrote:

> Hi Peff,
> 
> First, thanks for correcting my diff-without-NEXT-and-WTREE to
> diff-with-NEXT-and-WTREE pairing.
> 
> Second, I agree that the index is more than just NEXT.  There were
> good reasons behind calling it "NEXT" and not "INDEX".

NEXT has to be _well defined_ (is it tree-ish or a multi-tree in some 
cases), and definition examined if it is _useful_ (e.g. if you can get
results of "git diff" with "git diff NEXT <sth>..." both for conflicted 
and resolved cleanly entries).
 
This thread served to specify original handwavy definition of NEXT...

> Third, I didn't know for sure that "git diff" during a merge conflict
> would produce a three-way-diff result, but I suspected it would.  (You
> really didn't have to produce all that code - I would have accepted
> your word as an expert.  But thanks!)  So, yes, the two-way merge
> result of "git diff NEXT WTREE" would be different.
> 
> I could argue that git should allow a 4-way diff where "git diff NEXT
> WTREE OURS THEIR" prints all the unresolved changes as coming from
> OURS or THEIR or neither.  But I think that's silly.

It would be "git diff NEXT OURS THEIRS WTREE" or "git diff BASE OURS 
THEIRS WTREE" -- the putative merge results should be last; the 
convention of combined diff format is like for ordinary diff: first 
source(s), then destination.

> 
> I will say that "git diff NEXT WTREE" will tell you what's left
> unresolved and most of it is in <<<<====>>>>> blocks that tell you
> whether it came from OURS or THEIRS.  If the user has any discipline,
> they won't introduce unnecessary changes that were not necessary for
> the merge.  If they don't have discipline, we really can't help them.

What if he/she removed conflict markers, test compiled... and realized
that it was mismerge, then fixed?  Then to examine current fixed 
contents he/she doesn't have help of <<<< ==== >>>> blocks...

> 
> I'm not saying there is no use for a 3-way merge.  In fact, I'd guess
> it's a requirement so that Alice can check Bob's merge before Bob
> commits.  But I'm fine with making it "git diff --3-way" or the silly
> "git diff NEXT WTREE OURS THEIRS" because I think its "git diff NEXT
> WTREE" will be good enough 99% of the time.

"git diff --cc".  But I think with having to say explicitly 
"git diff --3way" / "git diff --cc" Alice wouldn't know that it has such 
useful tool...


P.S. Could you not quote text in bulk, if you are not answering to it 
block by block?  It is unnecessary download, and burden of scrolling 
down to check if there is anything added at bottom.
-- 
Jakub Narebski
Poland
