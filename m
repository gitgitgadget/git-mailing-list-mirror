From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Reset by checkout?
Date: Sat, 31 May 2014 18:39:24 -0500
Message-ID: <538a682c9540f_140996b2fc71@nysa.notmuch>
References: <20140531144610.754B.B013761@chejz.com>
 <5389b57138645_68b153b2f8a5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Atsushi Nakagawa <atnak@chejz.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 01:39:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wqss7-0003CV-JZ
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 01:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845AbaEaXj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 19:39:27 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59643 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbaEaXj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 19:39:27 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so3206405obc.5
        for <git@vger.kernel.org>; Sat, 31 May 2014 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=uRc2HWXiq90OY8qWiV5MukU3MVwNMaYAfhYCogWfZj4=;
        b=JxbTUPakw64ZhsXxJAKwLyZn9yZefMLMunZIVUMAQDSE4Lplp8XWSOCTr9rBd/ZH9S
         8s4s4Cm7Y7pH8TxSaC4gwyZNfA/rUrDjXJn1JFcIxOBtRvoz45TNn2USGzVXe7GKM2wO
         lQC8dz6bMT4luUjpah7gXaYPGYW/V/B9Jz3S6Wu5F79Ws6Sdqc140Dbr0qgQY1JRKetR
         qfq1aGhfiax4PXxfudLiCDLxUPPeCiK5cJn3GFk+XVnl2WFo5+B+pjYjcRNOF//mMgwV
         N8zZ1mogV+4uNuSaDGX6r39ngOEL5mmw9UPSXK0cC9TYPu34QTrFVKyGJCBlMuIrblWs
         WcNw==
X-Received: by 10.60.65.136 with SMTP id x8mr28428117oes.30.1401579566587;
        Sat, 31 May 2014 16:39:26 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b9sm29802463oel.4.2014.05.31.16.39.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 May 2014 16:39:26 -0700 (PDT)
In-Reply-To: <5389b57138645_68b153b2f8a5@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250515>

Felipe Contreras wrote:
> Atsushi Nakagawa wrote:
> > Ok, the typical use case is: I'm on 'master' and I make a few test
> > commits.  Afterwards, I want to discard the commits and move back to
> > 'origin/master'.  I could type 'reset --hard origin/master' and risk
> > blowing away dirty files if I'm not careful.  Or, I could use "reset by
> > checkout" and be carefree.
> 
> Doesn't 'git reset orign/master' do that?

Unless you want to keep the staged files, in which case adding the
--stage and --work options I originally suggested[1] would help.

So you could do `git reset --no-stage --no-work origin/master`

Which is essentially the same as `git update-ref refs/heads/master
origin/master`.

[1] http://article.gmane.org/gmane.comp.version-control.git/247086

-- 
Felipe Contreras
