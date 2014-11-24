From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 09:59:47 -0800
Message-ID: <20141124175947.GN6527@google.com>
References: <5471EC26.3040705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 24 18:59:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsxvN-0002lK-LF
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 18:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbaKXR7m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 12:59:42 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63092 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbaKXR7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 12:59:41 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so9298531iec.22
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ygO37/AsQw65+GD6I5ldfsI6eG6C2H4r04cMj5uQWPc=;
        b=IfadLIlXHd7HbwN0vaQ/2IPzeEqPGat8qnSqoGgnra/w9lm8yNfPlNDIJ8AHy6RUgW
         HWrwjfpWbO9nGkp7iASCndYgIpJLpVhwzBn0YoqtguhzPTZlbP8cpxE/wcaE3rZUoMxC
         Q2hMO6nLveHf6solKn/wg/xi6gGNJMfBuVXiry1IbBLpeYqyaV3Wh1nMHFxnxm13F1bW
         GfWgk4rZ3YQh5viqIYwP3zLspbB6O2+IgxVx1PfB7MT5V7R+QC1O5YTnu1VEXtJZnp2t
         Y+osRHCg70YcfBrVZgkchu6psTMOCduFwsQgGjOmMr48YY16+1H/ZT5+PPXRedJgjLb9
         Kefw==
X-Received: by 10.50.56.15 with SMTP id w15mr12901670igp.39.1416851980712;
        Mon, 24 Nov 2014 09:59:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:98f9:2c53:2892:25d0])
        by mx.google.com with ESMTPSA id h199sm7900471ioh.0.2014.11.24.09.59.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 09:59:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5471EC26.3040705@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260133>

Torsten B=F6gershausen wrote:

> gcc under cygwin reports several warnings like this:
>
>  warning: implicit declaration of function 'memmem'
>   [-Wimplicit-function-declaration]
>
> This has been observed under CYGWIN-32 with GCC 4.7.3 as well
> as CYGWIN-64 with gcc v4.8.3-5 x86-64
>
> Do not #define _XOPEN_SOURCE 600 for CYGWIN.
>
> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> ---
> This may be a start for a patch, tested under CYGWIN-32,
> both Windows7 and XP

The "tested under" part would also be a good addition to the commit
message.

>  git-compat-util.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch looks good to me.  Do you know if this has been reported to the
Cygwin maintainers?  The behavior seems counterintuitive --- I would
expect _GNU_SOURCE to override everything else (since I thought that
was the point of _GNU_SOURCE).

Thanks,
Jonathan
