From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase -i: respect to core.abbrev
Date: Sat, 28 Sep 2013 22:49:02 -0400
Message-ID: <CAPig+cTpSTrcPBa+Xs5Lw6bQ5TvSHqEh1tnEoZS6eX8Z9GTm4w@mail.gmail.com>
References: <1380384435-20846-1-git-send-email-kirill.shutemov@linux.intel.com>
	<20130928211013.54361E0090@blue.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 04:49:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ74X-00084o-Tx
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 04:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674Ab3I2CtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 22:49:06 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:46469 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab3I2CtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 22:49:05 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so3343890lab.33
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 19:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HhI4KPBDQAmuRDBlEHLzeIM4qtTOxPx3fulurpsWDNk=;
        b=ZAdcE08Qwqqr6SywiMBOPH2gvTyCucBT5HrPilDb7Stw46bJMi1hARpTG8Fo/XS1wG
         3lOZgIGIwEt9/rDOWcWjDvIsBRn+OJUKpWBJ7VH/Yn31w4GsQzPM9DZ/KnaTH1zmTU+6
         hYiOkBnSQxhw+FCNFXT4TYZBOUpt5/1DISp4sKjvCk/VzAUutPsjZX9lJb1TYr77rfpo
         WFkgND8XsfxXtczT4PcQcY6ETfi7WTVOw7Z3dDH5/co399ERs0hK8k0WAiSiiMeQ5xMe
         w14tQ6JL/4TecVYF8Vx/nzd+WuSKS1TkTmc0abLEKUwaSZxG4Qu+o/gIb4MgwalvpKSH
         gsTw==
X-Received: by 10.152.120.73 with SMTP id la9mr12962747lab.3.1380422942722;
 Sat, 28 Sep 2013 19:49:02 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sat, 28 Sep 2013 19:49:02 -0700 (PDT)
In-Reply-To: <20130928211013.54361E0090@blue.fi.intel.com>
X-Google-Sender-Auth: t2o6mKi3MEkkYFhlipprZwV0mOY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235573>

On Sat, Sep 28, 2013 at 5:10 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> collapse_todo_ids() uses `git rev-parse --short=7' to abbrev commit ids.
> Let's drop argument from --short to use default (7) or config value
> instead.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 10bf318d0d..3c6bed9a28 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -713,7 +713,7 @@ expand_todo_ids() {
>  }
>
>  collapse_todo_ids() {
> -       transform_todo_ids --short=7
> +       transform_todo_ids --short

Thanks, I was going to suggest this exact simplification upon reading v1.

Acked-by: Eric Sunshine <sunshine@sunshineco.com>

>  }
>
>  # Rearrange the todo list that has both "pick sha1 msg" and
> --
>  Kirill A. Shutemov
