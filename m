From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] gitweb on repo.or.cz shows buggy commitdiff
Date: Mon, 27 Aug 2007 03:12:18 +0200
Message-ID: <200708270312.18905.jnareb@gmail.com>
References: <20070729094645.GU23229@nan92-1-81-57-214-146.fbx.proxad.net> <200708270230.04537.jnareb@gmail.com> <20070827004838.GO1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>, Yann Dirson <ydirson@altern.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 27 03:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPT9X-0003Oc-G5
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 03:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbXH0BMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 21:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbXH0BMX
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 21:12:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:25617 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbXH0BMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 21:12:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1001238nfb
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 18:12:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KR1L7RrTwMXMY1ZeUncQGEk83dLBGBFpEbCf9mNcKa+G0rj43GlB8LmCx5X+YHQYg9Rc1r0dcE6u/UIejEbith1V/qUVymim5JyN+L+WzYGLLOWQj3RSmpxQql589T6NRbD4/n2fN9PDUi6JVaraFDxfy70phRQOxy9kvWeBmN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fls2fPihQGgGNUqDuuVSEYAt56qnD3FQAlqzy0b8RrzABs2JvVkFcMU7r0EU5QRp51bwnzNuGribQdKddWtbb0sW5ilaOQxNNWYwY1djtyNOJBhIPKThT8z7JNlbn8lQUqjzzxskt8Q3Lb43dkQb3+BvWe5ldPQc9MJiVPy8zzs=
Received: by 10.86.68.16 with SMTP id q16mr4450789fga.1188177141396;
        Sun, 26 Aug 2007 18:12:21 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id k29sm2679945fkk.2007.08.26.18.12.18
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2007 18:12:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070827004838.GO1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56754>

Petr Baudis wrote:
> On Mon, Aug 27, 2007 at 02:30:04AM CEST, Jakub Narebski wrote:

>> 2. Alternate solution is to note that we have split patch only in the case
>> of 'T' (type change) status, and for typechange we always split patch in
>> two, so there are two patches corresponding to single raw diff-tree line.
[...]
> 
> I'd prefer this solution, though I think split patch could also happen
> if you use -B (which I think is very good idea to use and it's a pity
> that it isn't default - or is it?).

No, 'B' status does not means split patch: it only affects how the
patchset looks like, i.e first delete all then add all, instead of
doing change chunk by chunk.

Or I think it does. "git log --raw -p --diff-filter=B -B origin"
on git.git repository returns rather strange results for the difftree
part...

-- 
Jakub Narebski
Poland
