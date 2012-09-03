From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: checkout extra files
Date: Mon, 3 Sep 2012 20:59:21 +0700
Message-ID: <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 16:00:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8XC4-0006Ku-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 16:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab2ICN7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 09:59:53 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44911 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab2ICN7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 09:59:52 -0400
Received: by ieje11 with SMTP id e11so3587765iej.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+/AD2PXO2biChlR4N0zWAw2sONAAEKkiRjnqJbLaxQU=;
        b=MnSj6C+SJmYXajRr8EpkXnok5/RHJ8Umqz5lemXBKzDoJAxBuJmSDJjQDD8c4Z8Kr7
         fJ/oz4N08l9XduQwXDlQt2SPTmYV49Q7CQapp6XJFMURxCktgkZA4oj8jP4DTad5+ZD1
         iaIZwwnjz0A4SZf7geFcFRsrONlVuY+9ruhK064DaPvJqHnt/Fx77yeaHq51HMLrBz6c
         mVQkPPbQnn9zg9eOpYfe3WxoUauW+17TCIwqqv98vH4xp3wJYBz3mcO21iPPdR2xk+ju
         jlvhQw09kebYekIPV2HVWONpUfGrYIGjqJGS8Zp9LVupo9m+bF3xQmI38g8jn569QGP1
         seEw==
Received: by 10.50.184.135 with SMTP id eu7mr10885705igc.15.1346680791729;
 Mon, 03 Sep 2012 06:59:51 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Mon, 3 Sep 2012 06:59:21 -0700 (PDT)
In-Reply-To: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204695>

On Mon, Sep 3, 2012 at 8:42 PM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> $ git checkout 94d8 -- *
> $ ls
> f1
>
> Note that the work directory is empty when the checkout is done, and
> that the checkout restores f1
> in it, a file that is not denoted by the * pathspec.

I think in this case '*' remains unexpanded by the shell. Which means
it is still a pathspec to checkout (iow equivalent to "git checkout
94d8 -- '*'"). Checkout in turns matches the pathspec '*' against the
tree and decides to restore 'fl'.

It's confusing but I don't think there's much we can do about it.

> I guess that this is the intended behaviour, and that the man page
> should be updated to tell exactly
> what files git restores.
-- 
Duy
