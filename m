From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 02/12] MINGW: compat/bswap.h: include stdint.h
Date: Mon, 28 Apr 2014 16:45:43 +0200
Message-ID: <CABPQNSaE9ua_JM0bY8QNSThqSKHG3d7N_PV5hmnKRt93sZkVBQ@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-3-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WempC-0000hc-Db
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 16:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbaD1OqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 10:46:25 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35215 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbaD1OqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 10:46:24 -0400
Received: by mail-ie0-f169.google.com with SMTP id rl12so516999iec.28
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Vgql9mOT1D/E61/QXFgTX1XXihxtqBE6Xcge6ODo4tE=;
        b=KiQeuHAV44MUuzwFM1mIuEDfLMd5RluCYiK5aoZKKhzYxEJi3DgpgvSccXlGZLlyPc
         QWTK7IvuQ025xYTlbV8OhqSd2WjGcJqohWLPQVmDgWh0v7sf0qaBRV6A+S9d1VcBpN8K
         9acUKf1mnd0mohDLsw60JZViSqu2WD84CT5HzJOVIRDBLKhsjXeVJAy+FT0Ed+sL4bB+
         c+MQcuuYUDWw++S14u1zhJc7Ik4RHpDq1Z+j48cVarL55y0+CeQJSTTtA1p1sJ1PeY5v
         W9wDrIulzchYs7pk5T/1vaXQ9CMGXO2KrOY30dD3x9qWVottsa0eaDOGydkTiay5Z6n5
         Z4cA==
X-Received: by 10.42.204.197 with SMTP id fn5mr1137226icb.95.1398696383965;
 Mon, 28 Apr 2014 07:46:23 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 07:45:43 -0700 (PDT)
In-Reply-To: <1398693097-24651-3-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247344>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> bswap.h uses uint32_t type which might not be defined.
> This patch adds direct include so bswap.h can be safely included.
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  compat/bswap.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index 120c6c1..d170447 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -5,6 +5,8 @@
>   * operation.
>   */
>
> +#include <stdint.h>
> +
>  /*
>   * Default version that the compiler ought to optimize properly with
>   * constant values.

Hmm, what's the symptom this fixes? From what I can tell, bswap.h is
included after stdint.h from git-compat-util.h anyway...
