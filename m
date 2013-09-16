From: Isaac Levy <ilevy@google.com>
Subject: Re: Bash completion doing full tree traversal?
Date: Mon, 16 Sep 2013 17:54:07 +0200
Message-ID: <CADHXV5=ZVif6xppJgOXRKmqG9bBmAF0=A-sS9TUkH1RHSX9k6g@mail.gmail.com>
References: <CADHXV5kfaMm3nAEK_uR0McoAahj6pVtm=11Ei0_Y_teDJixWTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 16 17:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLb8M-0002jp-RR
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 17:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab3IPPyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 11:54:39 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48684 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3IPPyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 11:54:38 -0400
Received: by mail-qc0-f174.google.com with SMTP id n9so2722753qcw.5
        for <git@vger.kernel.org>; Mon, 16 Sep 2013 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=yjIF09tRmagFn6UfrE4WUEDxfx0tKSB6KLfwUGvmwNw=;
        b=dl35gOoVDACRXghBaPU9sOCdq3tLP7y1D3aQORr2UMZQKxbHgO2of19DPBWaxISEh5
         Rrg7JUYbaxU8g1ZyqR554AOONOnUcAtDPaP2e/3Kz8EnSfu7ZyoJPjE1t37QTnEJ4yCO
         bx1Vu3kH/SKrofg82PGi3xh4hICF534mnzi1pzjf9f7my/YoKT5PY+Y6jvrR5iX4UAcO
         5x46b9/HZNb/BQI2Aeygq+640WJAbUszWaxfx/py4WTvReEabnI3Fg1PnoUiOSw7WZi9
         6rAX6BUKHZUGvnuJhik618pG0lGs8KOTbhVTe2H26s24NnO6UUBhEC/FxUE73kgtGJVs
         pr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=yjIF09tRmagFn6UfrE4WUEDxfx0tKSB6KLfwUGvmwNw=;
        b=L7lUbEQAUTeqp0PtAkexejv3d61l6OeUenLivOts5+ST8Gdb0iOSkRopwx7cuSterm
         fdjlNa4b4gVcHCqv69Gg2xf/fbIeR2nMgi/KNTOTVJbHWMA/OI/zBqMH0rtiD7yj0bHC
         py8Yap/T6liA9Lx2gQjhBbGGjTNVdETaLxc3XqhRZGy/xMcny3JOtU2dL/cbUies5vqA
         txXA1vNR3yWDE/pz9RRWLY7BWPgQJKIbdETKBK6r4n2VOlj2Mai1FF9LMypDlA1gtiam
         +KsDCVJRXDTh56k6HQvOAqJGluS5L7ECh1vSGEsa9hTc2c7dhcqHn2L4ou6JSVHibmIV
         mhpw==
X-Gm-Message-State: ALoCoQl+QPtHZ12Qh9BsM31PN6+Wngfb6UxaUliiEqXmd0+8sWkqpfwmAGa3SbuA9oDkOcBG/tJpASdz3K+niyus4QPP1GuepA+3Ap3YkYoj65x4x/ZH7BXy2AaSlG7cn/CWqofZqqef26PW8tX47nN1YUxLdLXMsqeBZ7JhWIR9MIkmEZHA7YCQXaHpKsjgh9JNrUtpGVtl
X-Received: by 10.49.107.135 with SMTP id hc7mr46355173qeb.43.1379346877472;
 Mon, 16 Sep 2013 08:54:37 -0700 (PDT)
Received: by 10.229.65.70 with HTTP; Mon, 16 Sep 2013 08:54:07 -0700 (PDT)
In-Reply-To: <CADHXV5kfaMm3nAEK_uR0McoAahj6pVtm=11Ei0_Y_teDJixWTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234837>

I should clarify that I had an untracked directory which contained a
significant number of files; I can fix by adding it to gitignore.
Still, the long delay & tree traversal were unexpected.

Isaac

On Sun, Sep 8, 2013 at 2:12 PM, Isaac Levy <ilevy@google.com> wrote:
> I experienced a weird stall from git bash completion:
> $ git add p<TAB>
>
> I did some investigation and found this call trace:
>
> + __git_index_files '--others --modified' ''
>    ---> git ls-files --exclude-standard --others --modified
>
> This bash function captures output of the git call and strips all but
> the base directory or base filename.  The results are limited to
> entries in the current directory.
>
> Appears to be from fea16b47b603e and first released in v1.8.2 (I have 1.8.4).
>
> Isaac
