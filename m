From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 4 Apr 2013 11:55:22 -0700
Message-ID: <20130404185522.GM30308@google.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpKF-00050O-R3
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763225Ab3DDSz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:55:27 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:59485 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763182Ab3DDSz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:55:26 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so1363820pdj.34
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VDkwcAuAX1EilyHu41jLEQs90l9hwPpe66MWjpSld/o=;
        b=LrbOV0GJweFw3fkHJ2IXL/fHijVKPF1xCrm4NbclERNVR9CmIVUCVwHu0kLrunDEYZ
         8y1qC8WIxtDkxTIWPqAvll1JBUnc21ajjL8kApla9Vc92RLIcNr72sGeS3mHdOHWNn+N
         XQ2a8OQ0LjQXFDSRxYMN4rfP1zDdKo/wbidjNfbYIudXRWlNLJmTcU+1G77dBYRheqSt
         oFP88wr5GwdeJfTyQxngZCP+/ERNdG9UVVd4rp3BP0+1sJVzxCAJP3JLr4A74hBr1Ny8
         vX6ewVvJGE1G7MH91YPIUkQZWzbCn/Dv7xrO6Oclxj3bIWhoqJFs2Afx3pMz6mXvHJN7
         drVQ==
X-Received: by 10.66.139.133 with SMTP id qy5mr11091611pab.152.1365101726513;
        Thu, 04 Apr 2013 11:55:26 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id 1sm11171711pbg.18.2013.04.04.11.55.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:55:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220062>

Ramkumar Ramachandra wrote:

> 1. 'git add' should not go past submodule boundaries.  I should not be
>    able to 'git add clayoven/' or 'git add clayoven/LICENSE'.  In
>    addition, the shell completion also needs to be fixed.

Yep.  This is a bug.

> 2. An empty directory containing a .git file is a perfectly valid
>    worktree, but does not show up in the superproject's 'git status'
>    output.  How can it be treated like an empty directory?

Stated like that, it doesn't sound like a bug.  Git since very early
has deliberately not tracked files or directories named .git.

Do you need this as a way of importing from a foreign VCS when someone
has accidentally checked in a .git directory along with everything
else?

Thanks,
Jonathan
