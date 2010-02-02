From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How can I create a commit without a parent?
Date: Tue, 02 Feb 2010 07:02:33 -0800 (PST)
Message-ID: <m3zl3radgl.fsf@localhost.localdomain>
References: <ron1-5383E3.00002602022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 16:02:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcKH3-00026K-Ti
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 16:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab0BBPCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 10:02:37 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:42115 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab0BBPCg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 10:02:36 -0500
Received: by bwz23 with SMTP id 23so83200bwz.21
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=VgX5ilTrREZxNwQGGB2jesCbgEdQ9etPfqYjhg8Vtm0=;
        b=eFuz0fSPWMrwSEpsu+F7FnDID3n8MaSYQ8I9goTs/xf2Zqwe0gE71cB++mHkdZI5ZT
         fcG1JKvk+4Rp1IfGGrl3Li8NN4cYABaKPOoUCDus/m+pL55w2/mfPMpBcD00yRlxkoqU
         AzHcbUevJhQVd8u1iwJpS8G5Iab623aZGewAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=gUL1l1/z+6rjfCq8IyGv11VP4Sxz5xsFBhP6FHg5aTE/gMRne0F6bVBKVbmufY/ZM5
         Gky2s3kWJ/sDYY2CbVvxZY48aL68f601p80N/LIfOvtktmPNrY+YbXXUf51fvV0SNLtP
         MQ6k/F/97KsYPzhtdIAPM+7873f/KRiDhIoqc=
Received: by 10.204.5.75 with SMTP id 11mr781785bku.20.1265122954701;
        Tue, 02 Feb 2010 07:02:34 -0800 (PST)
Received: from localhost.localdomain (abvl217.neoplus.adsl.tpnet.pl [83.8.209.217])
        by mx.google.com with ESMTPS id 15sm2693340bwz.12.2010.02.02.07.02.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 07:02:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o12F22ce012792;
	Tue, 2 Feb 2010 16:02:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o12F1luU012788;
	Tue, 2 Feb 2010 16:01:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ron1-5383E3.00002602022010@news.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138722>

Ron Garret <ron1@flownet.com> writes:

> SLSIA.  git commit-tree insists on having at least one parent commit at 
> the command line.  From reverse-engineering it seems like I could do it 
> by setting .git/HEAD to 'ref: refs/heads/some-nonexistent-branch' but 
> mucking with HEAD directly like that feels kinda scary.

You have git-symbolic-ref to set HEAD directly (don't forget to remove
index).  

Or you can set up / initialize separate (new) repository, create
commit there and then pull this new repository into current one.


P.S. Creating new root (parentless) commit isn't something that you do
on purpose, usually.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
