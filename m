From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] contrib/difftool: remove distracting 'echo' in the SIGINT 
	handler
Date: Mon, 19 Jan 2009 19:04:53 -0800
Message-ID: <402731c90901191904l217d6bdenf33f02033519c731@mail.gmail.com>
References: <200901200041.18793.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Tue Jan 20 04:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP6wV-0003z2-Vc
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 04:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbZATDEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 22:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZATDEz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 22:04:55 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:10506 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbZATDEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 22:04:54 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3543818wfd.4
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 19:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VeicW2KroMh4LKBg6fZZ25jMnaV/vf1ajKrlbmfwVII=;
        b=Xy1pOSMhORyB8tr5viEHNyTgoZnapeP412Yxp+qLyrA24I73BiwBa64AbKJuH52s/H
         T0hwyt5T7/mI2EHED2P01HJ29b4SrXseVhvR8Xm+eafD/SWsI91hbpvbyWa86pCvGjVF
         SkesrbIWjZRqxjfEArxM/pj4SqIFOvOnpvMyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u6lDc5zMTPBaOXaZRPNYaV2kOlUUQxFelP+FRUTg3tCiQYBs+ohFGims7IJ1E9TJWB
         c/U0YdxM6LwjX4zAZqKpHT72dOSqtB1Qf4jCCvu+q+Ey5GwJBVMztGnQZiIkwY3P/Ym2
         WxOSZBgNYeibwjFQobWbXdNDd4QkBLw9kiB54=
Received: by 10.142.221.11 with SMTP id t11mr174905wfg.86.1232420693906; Mon, 
	19 Jan 2009 19:04:53 -0800 (PST)
In-Reply-To: <200901200041.18793.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106428>

On Mon, Jan 19, 2009 at 3:41 PM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> When interrupting git-difftool with Ctrl-C, the output of this echo
> command led to having the cursor at the beginning of the line below the
> shell prompt.
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
>
>        David, have you intentionally added this 'echo', did it fix
>        anything for you?


I think you're right in that we're better off without the echo.  There
wasn't really any reason for it to be there.




>
>  contrib/difftool/git-difftool-helper |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
> index a2eb59b..0c48506 100755
> --- a/contrib/difftool/git-difftool-helper
> +++ b/contrib/difftool/git-difftool-helper
> @@ -32,7 +32,6 @@ cleanup_temp_files () {
>
>  # This is called when users Ctrl-C out of git-difftool-helper
>  sigint_handler () {
> -       echo
>        cleanup_temp_files
>        exit 1
>  }
> --
> 1.6.1.216.g3acd
>
>



-- 
    David
