From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 23:18:56 -0500
Message-ID: <76718490812182018x37e3d6fob8d817c0e0b0e293@mail.gmail.com>
References: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
	 <1229642734.5770.25.camel@rotwang.fnordora.org>
	 <20081219124452.6117@nanako3.lavabit.com>
	 <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>,
	Alan <alan@clueserver.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 05:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDWqW-00071O-1Y
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 05:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbYLSES6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 23:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYLSES6
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 23:18:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:24207 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbYLSES5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 23:18:57 -0500
Received: by rv-out-0506.google.com with SMTP id k40so730987rvb.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 20:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=peFY78ica3cqmGOwy/It6JzZZl6kZ805uZttX/zH0NY=;
        b=J5gf2WrLdE5o/7A25/CNYb9L7ZVbTc7FXo+Xafvg04oNyHsTURoff0eGwd+ayfgjgN
         iUm1JvXaUayeMjeC8PpcRwWwGx0M77F6YRdqznK7rZLCHM/3nAlznxorMktFiR5fbqws
         0g6yHUeRNCYTxhcqHpWS+1KcVNtYOMLCzWmvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qFY0XIFvAYpOP0PGLDTxQbnUnQ5FqbRYsZF5XQ3RDAbASjILvsel7aLRCyNol4JTGd
         lATVKvtArBX1qer72pfyOhYTKJnlDjadrhJYjsVY5LTF4U2wdEQP11cneIkq2ZtUd4y2
         paTLaPTRaXUy8U72EThqwY7dnJ6SJQF3tPi4I=
Received: by 10.141.50.11 with SMTP id c11mr1369790rvk.28.1229660336901;
        Thu, 18 Dec 2008 20:18:56 -0800 (PST)
Received: by 10.141.33.20 with HTTP; Thu, 18 Dec 2008 20:18:56 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103542>

On Thu, Dec 18, 2008 at 11:01 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Yes, it's more complex, and no, it's not always going to work (sometimes
> the answer is: "oops, I really shouldn't have merged it, because it wasn't
> ready yet, and I really need to undo _all_ of the merge"). So then you
> really should revert the merge, but when you want to re-do the merge, you
> now need to do it by reverting the revert.

Instead of reverting the revert, why not rebase the branch which was
merged to the point after the revert was done?

j.
