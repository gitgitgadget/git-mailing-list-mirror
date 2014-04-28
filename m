From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 12/12] MINGW: compat/mingw.h: drop fork() definition
Date: Mon, 28 Apr 2014 17:20:55 +0200
Message-ID: <CABPQNSa6w7SM2q7wmfhq3uKN54Jxoh7r40id8RMNrYB+kbJV1g@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-13-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:21:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenNH-0000mO-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbaD1PVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:21:38 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59246 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497AbaD1PVg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:21:36 -0400
Received: by mail-ie0-f180.google.com with SMTP id at1so3294038iec.39
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jc0tWkXHwjFr+DJSNadQk96LNvy0jJfZD8g3W4LUe3I=;
        b=KJ4SEJnTdo8fH1/lT5+uJg6nygHtYDuZFxdKvlkXlze314ZVsqfZVJn8pouwoKeMvg
         vG8MZPik7Esai3ozQmOda+kgNLAAGejUG3DO0xKkdTdkThOqlnqrACpn2/QD0V6/qvr0
         pCIkWCW9WsPQAjst2CwrBMSpvm1CeGBgEJuzDMdypVCSc8DNZQmej0WYQ+oOtaGr0UsP
         Qk9pW3jgka8iFKo7rMCRH8hsX6FtNFxYfuOY/NxSBCmUdf4MefUtriYgWuYkKtlayHLW
         Qeuer2vqR2JNLTXHSAxYyRZsEdtLCuDEIzlecybomOoJ/RxU8d+OK8QZOLWaHRcMxqgR
         jRpg==
X-Received: by 10.50.36.66 with SMTP id o2mr24415205igj.24.1398698495824; Mon,
 28 Apr 2014 08:21:35 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:20:55 -0700 (PDT)
In-Reply-To: <1398693097-24651-13-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247360>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> fork() is not used in MinGW builds but causes a compiler warning
> on x86_64 MinGW-W64: conflicting types for built-in function 'fork'
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  compat/mingw.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 8850109..2fbc8ea 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -89,8 +89,6 @@ static inline int symlink(const char *oldpath, const char *newpath)
>  { errno = ENOSYS; return -1; }
>  static inline int fchmod(int fildes, mode_t mode)
>  { errno = ENOSYS; return -1; }
> -static inline pid_t fork(void)
> -{ errno = ENOSYS; return -1; }
>  static inline unsigned int alarm(unsigned int seconds)
>  { return 0; }
>  static inline int fsync(int fd)

I've been using a similar patch for a while, so:

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
