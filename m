From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: git mergetool vs stash apply
Date: Tue, 20 May 2008 12:02:44 +0400
Message-ID: <c6c947f60805200102h3fd27742vfd9310912907cfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 10:03:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyMov-00079v-46
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 10:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757018AbYETICr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 04:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbYETICr
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 04:02:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:30801 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbYETICp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 04:02:45 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2243627waf.23
        for <git@vger.kernel.org>; Tue, 20 May 2008 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=UNYWfmTG/uNZWw1sIlzzNdjLL6uOibc6b8jmCQxPUQ8=;
        b=DIMyQNLss/TJXNre1aGJ1o4r6Dm6yiejR0VEt+CH4Dui250HjMOieKR709Uz+VumREOO6C6AFm0ge78gjGcIv11P9Hgmywref7ybybI281yyn+WU89HNuFw6/lG1oTYEoW3xxWGiZbC2htOHOVEEWmlQIrq/R5hTeQU+dZAVgLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s4XpjGwFOImosXyzCUiI1+rf2+PlUkjsQD+ySCEPE9CWqim1Atye8cCN7Oja31yL4jXlAlcEhX3L9S1o73cXn+waXcrm2dKi7mxV2Tbf+0h+A/y6KTHtpDnWCz2MUFwrvZ7fKxV2CH5cvYIhZe2Sz+hbnJEj884FkfbkbAsBkIo=
Received: by 10.114.255.1 with SMTP id c1mr7665598wai.93.1211270564892;
        Tue, 20 May 2008 01:02:44 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Tue, 20 May 2008 01:02:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82471>

Hi, list!

The git mergetool ignores conflicts by git stash apply:

$ git stash apply
Auto-merged path/file.ext
CONFLICT (content): Merge conflict in path/file.ext

$ git mergetool
merge tool candidates: kdiff3 kdiff3 tkdiff xxdiff meld gvimdiff
opendiff emerge vimdiff
No files need merging

While path/file.ext do contain merge conflict.

The git mergetool works for git merge and git rebase. Maybe it should
work for git stash as well? I automatically type git mergetool when I
see CONFLICT in Git output. %-)

Alexander.
