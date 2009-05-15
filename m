From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git svn rebase problem
Date: Fri, 15 May 2009 19:53:31 -0400
Message-ID: <32541b130905151653u436f3c5cwcf1d896c96148efa@mail.gmail.com>
References: <4A0DDCC5.4010001@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David H. Lynch J.r" <ml@dlasys.net>
X-From: git-owner@vger.kernel.org Sat May 16 01:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M57E0-0003fn-K2
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 01:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbZEOXxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 19:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbZEOXxv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 19:53:51 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:59185 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZEOXxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 19:53:50 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1266702ywb.1
        for <git@vger.kernel.org>; Fri, 15 May 2009 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Nh+e9QF1JwSmWm/dx2YBjkKWD6uDLzAES2qESB9Ql/8=;
        b=ZNXduBTtD5jikq1AKV+VAR+SVYlJ3u2GQqmF8+/CwEvz8jqRlLegKQbyfF0vSFo6Xo
         OKdaQKDcpgDu9uhB9mnhLQtMIFxpxjxXm3JvoFHMWp5Qdl3UlxY2ugSjUTQEi1lCC/in
         Kmnj8u6J1UnoHSGHotuyvpSAyiRSaWtE/RpnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nCYSTuv9JUJ9CMllTb95r70YwOZ0ELTXhmpR5kdNWMHqJdNB+VJtKXuMr2kHXwpyQH
         WnnvIQq2kZn5qok2ztduXythLqNY/v8QrrGPDM2DS8Z/OwN57QFWQr/8bx6byO9BDK81
         Axs6g6J0lLsFN9QVtR3xcWkpvFcqebssswo0E=
Received: by 10.151.138.7 with SMTP id q7mr7223600ybn.166.1242431631081; Fri, 
	15 May 2009 16:53:51 -0700 (PDT)
In-Reply-To: <4A0DDCC5.4010001@dlasys.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119307>

On Fri, May 15, 2009 at 5:21 PM, David H. Lynch J.r <ml@dlasys.net> wrote:
> A few days ago I did an
> git svn rebase
>
> The rebase took a while and after it completed reported
> fatal: bad object HEAD
>
> git status reports
> root@hp-dhlii:/usr/src/pico/git# git status
> # Not currently on any branch.
> fatal: bad object HEAD
>
> and git fsck reports
> root@hp-dhlii:/usr/src/pico/git# git fsck
> dangling blob eb3afb4aa3aaf0003bac601a5db4fd76aafa2a87
> dangling commit 5c496db25007c17c325f294bb8324097c9bc407d
>
> How can I recover without downloading the entire repository again which
> could take days?

I don't know how this would happen; it would be great if you could
find reproduction steps and send them in, or if you had the complete
git rebase log, some of which probably explains the problem.

You can probably recover your pre-rebased repository using 'git
reflog'.  Look through the reflog to find the commit you want, then do
something like

    git checkout whatever-the-commit-id-was-that-you-got-from-git-reflog

and then optionally

    git checkout -b master

Good luck.

Avery
