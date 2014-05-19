From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: bug: autostash is lost after aborted rebase
Date: Sun, 18 May 2014 20:38:45 -0500
Message-ID: <537960a5f0d95_10da88d308b6@nysa.notmuch>
References: <20140519005719.GB38299@tequila>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Karen Etheridge <ether@cpan.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 03:49:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmCiC-0007kq-CI
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 03:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbaESBtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 21:49:52 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:52212 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbaESBtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 21:49:52 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so5386174obc.38
        for <git@vger.kernel.org>; Sun, 18 May 2014 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=Z5SgwZsp4ueGJmCCy01VOTu7a8NFe/pEqdpOh38Oy/Y=;
        b=l80sEyz8qOePxeYY9vqv2Q4rw+axCXiiPem3U9XEEP1WuLp70nRQeoKon8Azs168eN
         /pbltwZxSn6Na86EXzNJxC1cpn6Q1otoflLkyJ2uPbsupAmVvtT8LjHFcWq7bFGV6WbM
         GOTNR7NOcNQgr2TcHDzcatZgtd+qt0P+xqeUf8Qh9xGyIkGPMuxsqotevDZ27JxQ3Tbe
         HasZcSE/kIdsYyZztCfH+4p4hSI3PXqf781vJfVTdXRkPIQy4pftRzb7eRH7n86uldlw
         fe5xNW17yOsDgrjuQgTdmNlLydQyKPYxOBfILVGvWDyAG2TMmkqQEpRQWCo42ZG1dN81
         P3aw==
X-Received: by 10.182.115.232 with SMTP id jr8mr32852437obb.35.1400464191740;
        Sun, 18 May 2014 18:49:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jy6sm29268008obc.25.2014.05.18.18.49.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 May 2014 18:49:51 -0700 (PDT)
In-Reply-To: <20140519005719.GB38299@tequila>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249560>

Karen Etheridge wrote:
> 
> scenario: 
> - edit some tracked files; do not add them to the index
> - "git config rebase.autostash true"
> - "git rebase -i HEAD~3" (an autostash will be created)
> - delete the entire buffer and save/exit the editor - this will abort the
>   rebase
> 
> poof, the autostash is gone (it is not reapplied) -- it must be explicitly
> applied again via the SHA that was printed earlier.

Yeah, I noticed this issue while rewriting `git rebase` in Ruby. I also
noticed many other issues and inconsistencies that happen depending on what
arguments you pass to `git rebase`.

I'm in the process of writing a much more improved and consistent
`git rebase` in Ruby with a different interface. Sadly it's still not ready.

> (please cc me; I am not subscribed to the list.)

No need to say that, only on mailing lists that do Reply-To munging, and
Git is not one of them.

Cheers.

-- 
Felipe Contreras
