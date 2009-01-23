From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Short "git commit $file" syntax fails in the face of a resolved conflict
Date: Fri, 23 Jan 2009 09:45:09 +0900
Message-ID: <20090123094509.6117@nanako3.lavabit.com>
References: <4978202C.3090703@viscovery.net>
 <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
 <49779521.9040208@drmicha.warpmail.net>
 <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 01:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQACl-0003w4-4i
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbZAWAqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbZAWAqB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:46:01 -0500
Received: from karen.lavabit.com ([72.249.41.33]:43047 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbZAWAqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 19:46:01 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 3231EC7B38;
	Thu, 22 Jan 2009 18:46:00 -0600 (CST)
Received: from 9837.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id WG99QQTXA6QY; Thu, 22 Jan 2009 18:46:00 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=vNZeNdNQuNdlol0jdnBgxeu12IFSwG/MNCqMbJOCDPB8TzjpNNKcAt76YgdGyvWXXvaPpvGF90/Osj/bXDidS6kS2RuZvXb2/Zp61jcUqiRflcCf6xH4h9ZxmeuEtKJeOT9Xyms2zp8fZ/Ds/MOI8U9Xewfd9pv8LvWr5j/Cbcs=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4978202C.3090703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106811>

Quoting Johannes Sixt <j.sixt@viscovery.net>:

> Please don't top-post.
>
> Nathan Yergler schrieb:
>> Can you elaborate on why doing -i automatically is a bad idea in this
>> case?  [It may really be, I don't pretend to have enough knowledge
>> about git's internals to make a reasoned argument.]  This was
>> unexpected behavior for me as I'd always experienced "git add path &&
>> git commit" and "git commit path" as being equivalent and so I assumed
>> they would work equivalently in this situation.
>
> They are not equivalent. 'git add path && git commit' commits changes to
> path *in addition* to what is already staged before you run this command
> sequence. But 'git commit path' commits *only* changes to path, leaving
> other changes that might be staged uncommitted.
>
> It may become obvious why the latter behavior is unwanted if a merge is in
> progress: The merge left changes (and conflicts) in the index; but with
> 'git commit path' you say that you are not interested in what the index has.

Your explanation is a good answer to Nathan's misunderstanding; "git add path && git commit" and "git commit path" are different.

But Nathan's first sentence is a different matter. I do not think it is coming from the same confusion, and I think the question is a valid one. Your answer does not explain why it is a bad idea to change the behavior of "git commit path" to what "git commit -i path" does during a merge.

The answer of course can be "because it changes the behavior people are very much used to."

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
