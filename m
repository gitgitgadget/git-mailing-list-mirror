From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: I want delete fault commit from my git repository
Date: Mon, 14 Jul 2008 09:41:26 -0700 (PDT)
Message-ID: <m3wsjos9jm.fsf@localhost.localdomain>
References: <9f01c190-73b6-48b1-88d9-ed67d0945d81@k13g2000hse.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chongyc <chongyc27@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 18:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIR88-0002Tj-Kh
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 18:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756953AbYGNQla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 12:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756356AbYGNQla
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 12:41:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:36990 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353AbYGNQl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 12:41:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2932112fkq.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=mI4FZca42ghcjhyKb7wYN9Uj2gwN18eCe+AWfD5j+Rg=;
        b=VPhEQjjjuJRbm5rRqtgYW2ncWo5CyBPGelTP1I6kTJnq5xNNFt1j59Wie0RDNHA4mk
         qpkBsza+qg+J2HG9QMMUfsrZSgaL8i4/JW0KzZYQiqEZX+rFfkRPKz4rCShEs6SDT3z7
         ygOmdz/dsv+tOYyHfpY+RO7Usex6vXgwxGP38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Oc2Y6jxNGE4U/yQqGgvqvF1ghMIdFeTeUp/VlBO9QTUC/phrtJPb8CPsWuBfw5Yq8f
         LRbR26jluTL6v1bpPBMAJR66j/oH2zZ7fEkoGa9jEIobIQ0bR4r6qfRH0kFEWXbyuShh
         0jz37A1ym1LWZIRSR/AWqpapU/Gd4Vgj6NJRg=
Received: by 10.187.191.19 with SMTP id t19mr1842518fap.87.1216053687696;
        Mon, 14 Jul 2008 09:41:27 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.66])
        by mx.google.com with ESMTPS id 3sm2071407huc.10.2008.07.14.09.41.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 09:41:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6EGfMbR008591;
	Mon, 14 Jul 2008 18:41:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6EGfHiC008588;
	Mon, 14 Jul 2008 18:41:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9f01c190-73b6-48b1-88d9-ed67d0945d81@k13g2000hse.googlegroups.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88435>

chongyc <chongyc27@gmail.com> writes:

> I have found buggy commit object which I had committed into  git
> repository  wrongly
> 
> So I am going to delete it from my git repository
> 
> How to do it ?

If it is just created commit (and not yet published), use 
"git commit --amend" to correct it, or "git reset --hard HEAD^"
to just drop it.

If you have published history (somebody is relying on history
containing broken commit) the only way is to add commit reverting
changes brought by broken commit using git-revert.

If you can rewrite history, use "git rebase --interactive" and simply
remove the commit from instructions/series file if the commit you want
to remove is not too deep in history, or use git-filter-branch if
broken commit is somewhere deeper.  See documentation for details.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
