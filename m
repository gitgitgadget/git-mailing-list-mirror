From: Anastas Dancha <anapsix@random.io>
Subject: Re: [PATCH] remote: allow adding remote w same name as alias
Date: Fri, 19 Dec 2014 10:44:56 -0500
Message-ID: <CAChhagA7eZ_7=g-xhAusZ1NX085KLjPDRbgJwx00F4pgOURXnQ@mail.gmail.com>
References: <20141216021900.50095.24877@random.io> <alpine.DEB.1.00.1412160944180.13845@s15462909.onlinehome-server.info>
 <CAChhagAFTxmFVvCUiKp3a369awPJtZEuVsfFMcdiqeB9ZwYnKg@mail.gmail.com> <alpine.DEB.1.00.1412191034560.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 19 16:45:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1zk3-0003QX-6d
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 16:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbaLSPpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 10:45:18 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:52615 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbaLSPpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 10:45:17 -0500
Received: by mail-oi0-f42.google.com with SMTP id v63so2055852oia.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 07:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dqQoXa5JAGHZB/l8uohfV1aB4kqPr6SYPnFrUZdGP1Y=;
        b=Md076MoaelTIFxYcVFneSUIjEnQAOyF7qD9mHrNtA0j8gA9pKYHPf+ylup2N6uVuKc
         Ho//hl9Q3KrpHX9Zv1dcmaTAaaRaCDoHdEB5FwJdgkHrMI+xDf2lLX2uiLso/WrsWKKE
         1gFXqebRVE453YxlbnbUrNuOahDVdbeMrEpSheLqna/gIym1VioEiz0X4GwIRvk72ujw
         DXrETDB+gQ3a1Wui7CFFAh08NfBoGkgyZZFT8Xhbhq1tMhgtAFRXNsEpkRDGMHMm05pM
         wPUt0T8CGKqUuwNcMZfyntxd5DRZAO4WTD7xt/8izBWOWs7v6Zu0H46Ht6ZpkPn/xBJC
         SYuA==
X-Received: by 10.202.213.144 with SMTP id m138mr4790504oig.87.1419003917282;
 Fri, 19 Dec 2014 07:45:17 -0800 (PST)
Received: by 10.76.183.104 with HTTP; Fri, 19 Dec 2014 07:44:56 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1412191034560.13845@s15462909.onlinehome-server.info>
X-Google-Sender-Auth: dBNHt-k_sOjl_YdyNUjg1-OVecg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261565>

Hello Johannes,

On Fri, Dec 19, 2014 at 4:37 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> [...]
> There is one bit left to clarify: let me guess, you have a $HOME/.gitconfig
> like this:
>
>         [url "anastas@company.com"]
>                 insteadOf = backup
>                 pushInsteadOf = backup
>
> and then you want to add the "backup" remote in a Git working directory
> like this:
>
>         git remote add backup me@my-laptop.local
>
> but my suggested fix will still disallow this because the URL does not
> match the url.anastas@company.com.insteadOf?
>
> Ciao,
> Johannes

Precisely that. In fact, it will not work even if you do any of these:

    git remote add backup anastas@company.com
    git remote add backup anything@anyhost.com
    git remote add backup backup

The original / current code and your suggested fix - both exhibit
similar behaviour with the use cases I've described above.

Thanks,
Anastas
