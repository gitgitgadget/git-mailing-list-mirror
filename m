From: Luke Madhanga <lmadhanga@gmail.com>
Subject: Re: Why is my git-http-backend solution using WebDAV on push?
Date: Wed, 25 May 2016 22:54:26 +0100
Message-ID: <CABwKKP-rKSGzdk6E78BMRCVdumtVnj7tysv90c7RL8=059PxoA@mail.gmail.com>
References: <CABwKKP958cW3a5Cjxox+1FCtNLetdufJj0rrYBouAUhJSXKKWA@mail.gmail.com>
	<20160525213850.GB13776@sigill.intra.peff.net>
	<CABwKKP89Ncht0MfB7X1x15a6PB-Nm68SDGEDvX1AnQdDucXQkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 23:54:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gl7-0005nA-1E
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 23:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbcEYVy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 17:54:29 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36791 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbcEYVy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 17:54:28 -0400
Received: by mail-lb0-f173.google.com with SMTP id h1so19411675lbj.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kiNXPDuizypk6wDAmgX98RKu6vJxOD7ttgAyIrvmxCc=;
        b=P0R2KTKcJ9oa1kK9R5Us7J8g71tKstvHdhkZbsJ5FeXy6M4etspBnw4kA5HbNTpg1n
         ONbgSt0s68sI6ptA0g2VuhbDkQjV+TC/OnneAFOYs+mPp2Qhocbft58Wt7JngRZX+ISZ
         6TdDoj0JjHRgssFEfg6ghXA+eSOmrabx/+agewZKOwsUhBERljCPQhr9ttf3MtQsNen8
         N/dAhWzWT5o6UcixsdYbYKsdOU96zQMuWvCTp+uD0GapDCl2i9D0dBnL/HF5ywm6UcCn
         rTbRBKD7kFqe+a3v0v3xuzGqN7oWwc/CFu9J8WKZ50i/W88xX4KISHs3ZzYSBFv6MMJI
         1i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kiNXPDuizypk6wDAmgX98RKu6vJxOD7ttgAyIrvmxCc=;
        b=BBNWzisHPqdVRAgku0q1Wt6eOmd1dYLHpCoxKq90PdzQPoHkgKSViyJIJ/I6dDZJ/n
         jZDIWCU2+fUT1GnZDjNYl15PBQh8otqaZRUQwRfGBKdNcc/7BzD2aqI3PDLNT8zAj/Ut
         hg4UEX/O00E4PLaUv543pO21UCx0gTmfVz+EQL70vEwUqx5WxpAqbwbXpZ5/lWxb766v
         JzG/lnru8L1Jobj2VWSAQRLsfMrB1SoRH+ZAH/QxJ6ecLvY/25d1poHjsDBRucq7g4bB
         fABhSKVCZHNJEXVFhozCbei8t3wzryT+Jw/hLI9zqpHcc6vK8taUHnpWLnmyOZd2Q/65
         G5Sw==
X-Gm-Message-State: ALyK8tLd4uzae2Mw87j7R2b76vLPAJAOhILVnem5TLNf+eZmgW5hXqiKKw662Pd5+Yuiw9jIKFCDiUeC9pqDIg==
X-Received: by 10.176.3.201 with SMTP id 67mr3575421uau.78.1464213266551; Wed,
 25 May 2016 14:54:26 -0700 (PDT)
Received: by 10.176.4.76 with HTTP; Wed, 25 May 2016 14:54:26 -0700 (PDT)
In-Reply-To: <CABwKKP89Ncht0MfB7X1x15a6PB-Nm68SDGEDvX1AnQdDucXQkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295591>

Thanks for the response btw

On 25 May 2016 at 22:54, Luke Madhanga <lmadhanga@gmail.com> wrote:
> Hmmmm. Interesting.
>
> When you look at the PHP code, you'll see the following
>
>     $res = self::proc_open("{$gitcoredir}/git-http-backend", [],
> $gitdir, true, [...]);
>     ...
>     $resbits = explode("\n", $res);
>     foreach ($resbits as $index => $header) {
>         if ($header && strpos($header, ':') !== false) {
>             // Headers
>             header($header);
>             unset($resbits[$index]);
>         } else {
>             // First blank line is the space between the headers and
> the start of the response from Git
>             break;
>         }
>     }
>     echo ltrim(implode("\n", $resbits));
>     exit;
>
>
> Everything being returned is from a direct call to the git-http-backend.
>
> A manual CLI call to git-http-backend doesn't include
> 'application/x-git-receive-pack-advertisement'
>
> REQUEST_METHOD=GET GIT_PROJECT_ROOT=/path/to/core/
> PATH_INFO=/repo.git/info/refs /usr/lib/git-core/git-http-backend
>
> The above command outputs
>
> Expires: Fri, 01 Jan 1980 00:00:00 GMT
> Pragma: no-cache
> Cache-Control: no-cache, max-age=0, must-revalidate
> Content-Length: 118
> Content-Type: text/plain
>
> f4648182f5f8eee082c37a83a0072cfc4210e5c5 refs/heads/master
> 8c4efcd77809bc9b94a59cf94653add8007c6b7d refs/heads/zztest



-- 
Yours,
Luke Madhanga
