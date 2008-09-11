From: "Eric Raible" <raible@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 14:24:51 -0700
Message-ID: <279b37b20809111424y73a3f6b9xe7f5019b9ba0da16@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
	 <279b37b20809101946k309ad113neb7d051f1c6c410e@mail.gmail.com>
	 <eafc0afe0809102305u6de85ef3ib2c08004dea8d6f9@mail.gmail.com>
	 <51419b2c0809110932r4e8c833fx740ccb0c8e46f0af@mail.gmail.com>
	 <3ab397d0809111022m24c81bd9y2520f6be478babd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Elijah Newren" <newren@gmail.com>,
	"Changsheng Jiang" <jiangzuoyan@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdtft-0004Zc-ER
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 23:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYIKVYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbYIKVYy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 17:24:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:42328 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYIKVYx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 17:24:53 -0400
Received: by wr-out-0506.google.com with SMTP id 69so356843wri.5
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IKrIjb3xC5YrqeM0vwDt1jpChnp1PNy8FD1HfmGpgnY=;
        b=slo5zmadkqS6oNBxo5FB1qDkY4WFgOcPgw3lmbeFvPtKCLl4nNG6j1TqytnfQPKiLZ
         3RxXHKEsqNaiOM8OxxxCCV4+Fr/kqctCXZ3iEyNj9QPI8taF3NsSHqBlOgST0zC0Nkg3
         n9pVsAUdq6JPTu2g4oZFOM6aUNTVvwRwt3upE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q43lC/GYqejF1DFkcordtUqlWhf/WYQVnFkQsGvr3PZJOKZ65nor1JRdQg4zyt8yay
         XL6aDtgtAZZ98ndVoDKIuNgct8lcRBk2nC6KgSnIZaSaBZgUA8UIvdTXez59NKe8mXiD
         cYqfqC1CPcmDDSoRXTqxcQOyRHRlC8UonsLPQ=
Received: by 10.142.134.20 with SMTP id h20mr1155983wfd.188.1221168291270;
        Thu, 11 Sep 2008 14:24:51 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Thu, 11 Sep 2008 14:24:51 -0700 (PDT)
In-Reply-To: <3ab397d0809111022m24c81bd9y2520f6be478babd3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95648>

On Thu, Sep 11, 2008 at 10:22 AM, Jeff Whiteside
<jeff.m.whiteside@gmail.com> wrote:
> And if you want to delete all untracked files
>      ls | sed s/`git status --index --filenamesonly`//g | rm
>      ls | sed s/`git status --commitrepo --filenamesonly`//g | rm
>            (I realize those commands don't actually work, but I'm a noob.)

"git clean" (http://www.kernel.org/pub/software/scm/git/docs/git-clean.html)
will delete untracked file.

> So that 'tracked by git' isn't just another ambiguous semantic.

While I can't find where it might be explicitly defined, it does seem
clear that a file/dir is "tracked" as soon as it's added.

My question is why "git reset --hard" can't make a special case for
_newly added_ tracked files.  After all, "git status" knows that they're
"new files", and "git reset --hard" could realize that wiping them off
the face of the earth isn't the most helpful thing possible.

- Eric
