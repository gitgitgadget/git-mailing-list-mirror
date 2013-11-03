From: Greg Jacobson <coder5000@gmail.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Sun, 3 Nov 2013 08:35:51 -0500
Message-ID: <CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 03 14:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcxqQ-0003Nl-Hx
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 14:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab3KCNfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 08:35:54 -0500
Received: from mail-qe0-f52.google.com ([209.85.128.52]:53477 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3KCNfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 08:35:53 -0500
Received: by mail-qe0-f52.google.com with SMTP id w7so3573369qeb.39
        for <git@vger.kernel.org>; Sun, 03 Nov 2013 05:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=5MV7BIjlpiQSfcKHJhnEhIFcr/73hMiRDE2tr4TRxiE=;
        b=gqYX8E66k1+mgFo6GwqGpzZZ3BLBQQp77Ki7JfU0CCk+J59NEOXOghmTpSmHUm4mkb
         HyI3D/NBKhq+6vl5A3PExPiLZ614+07h9czM3vAyGm6aFjE6zc8rJ6hzUZ+hymDJS/pc
         A+ZWZ5H2+wTwEEZVhAiwAboW07lbADapP9YYvTuB2aKyE9/gOz9qnIocDsOiYI7ntNQC
         sg2W6hciPXQ+9LQkCeFhuNYjiLMETjbn61dRgqOdknCujTcR6++i2b/ds7ClOLf+1aVf
         kTSwJ199gHUIuPY9Z7+B+ns7kYBSnP/DQbgptdDL7es786msoOhHtug9w4R9pBPJTZuD
         rOsw==
X-Received: by 10.224.44.1 with SMTP id y1mr16182714qae.35.1383485751192; Sun,
 03 Nov 2013 05:35:51 -0800 (PST)
Received: by 10.224.65.136 with HTTP; Sun, 3 Nov 2013 05:35:51 -0800 (PST)
In-Reply-To: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237260>

Is there anything I could do to improve this patch?  Thank you.

On Fri, Oct 4, 2013 at 10:20 AM, Greg Jacobson <coder5000@gmail.com> wrote:
> When the unset push.default warning message is displayed
> this may be the first time many users encounter push.default.
> Modified the warning message to explain in a compact
> manner what push.default is and why it is being changed in
> Git 2.0.  Also provided additional information to help users
> decide if this change will affect their workflow.
>
> Signed-off-by: Greg Jacobson <coder5000@gmail.com>
> ---
>  builtin/push.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 7b1b66c..5393e28 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -174,6 +174,15 @@ N_("push.default is unset; its implicit value is
> changing in\n"
>     "\n"
>     "  git config --global push.default simple\n"
>     "\n"
> +   "When push.default is set to 'matching', git will push all local branches\n"
> +   "to the remote branches with the same (matching) name.  This will no\n"
> +   "longer be the default in Git 2.0 because a branch could be\n"
> +   "unintentionally pushed to a remote.\n"
> +   "\n"
> +   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
> +   "branch to the same remote branch used by git pull.   A push will\n"
> +   "only succeed if the remote and local branches have the same name.\n"
> +   "\n"
>     "See 'git help config' and search for 'push.default' for further
> information.\n"
>     "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
>     "'current' instead of 'simple' if you sometimes use older versions
> of Git)");
> --
> 1.8.4.474.g128a96c.dirty
