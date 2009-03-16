From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: (unknown)
Date: Tue, 17 Mar 2009 06:45:19 +0900
Message-ID: <20090317064519.6117@nanako3.lavabit.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEFA4@EXCHANGE.trad.tradestation.com>
 <7veiwxwa9z.fsf@gitster.siamese.dyndns.org>
 <450196A1AAAE4B42A00A8B27A59278E70A2AEFD7@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 22:49:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjKfw-0008Km-Ho
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 22:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761711AbZCPVqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 17:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761856AbZCPVqL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 17:46:11 -0400
Received: from karen.lavabit.com ([72.249.41.33]:47995 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762106AbZCPVqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 17:46:10 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 091BB11B803;
	Mon, 16 Mar 2009 16:46:08 -0500 (CDT)
Received: from 6540.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id CDXW1CJV395B; Mon, 16 Mar 2009 16:46:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Q+KLlmmjm52UP/paPwQcqrGALEOzTzXLTt/HZ850BtJWeF29+zYu6U7rCp9xXbvi5j8fxAVGkOZxBWxcW2vPH5yWUXiKr8z2+J6hbKYIoulQodVqNEZoXUyzNFPqn/Nr4/hKmuzdwDUwFucSx4pm5rg2OXwMdfjBSBet1yWOHi0=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Subject: 
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AEFD7@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113389>

Quoting John Dlugosz <JDlugosz@TradeStation.com>:

> === Re: ===
>  (2) if you are not, you can obviously check out topic and do the above,
>      or "git branch -f topic topic^".
> === end ===
>
> As documented, this destroys the existing branch and makes a new one.
> That would, by design, blow away the reflog for that branch.

Does it?  If so I think you have an incorrect documentation.

$ rm -fr /tmp/gomi && mkdir /tmp/gomi
$ cd /tmp/gomi
$ git init
$ echo hello >world
$ git add world
$ git commit -m initial
$ seq 1 100 | while read num; do echo $num >world; git commit -a -m $num; done
$ git checkout -b side master~60
$ git branch -f master master@{20}
$ git log --oneline -g master | head -n 10
0acf8c1 master@{0}: branch: Reset from master@{20}
945c3ee master@{1}: commit: 100
54fcb36 master@{2}: commit: 99
b314a1e master@{3}: commit: 98
e91d999 master@{4}: commit: 97
0d88853 master@{5}: commit: 96
0124315 master@{6}: commit: 95
5df2cc5 master@{7}: commit: 94
14bb58e master@{8}: commit: 93
0813a46 master@{9}: commit: 92

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
