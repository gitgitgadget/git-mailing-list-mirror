From: David Glasser <glasser@davidglasser.net>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 2 Oct 2012 08:18:04 -0700
Message-ID: <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 17:18:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ4F0-0007c1-QB
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab2JBPS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:18:27 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61989 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2JBPSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:18:25 -0400
Received: by vcbfo13 with SMTP id fo13so7053411vcb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=BzsAp/ZePMBw1QYaRfw//OCqoj3qq8bFUWvOkBo8E6o=;
        b=lZveEV2g4d7dH4kvTxtdzH1fPWNzFrF+XnX1Hs4Lu0XYuci/O6D/GgJT46TTCoI3nj
         ImqhjCf/5Uin9xsUYShvyuFa9VfDswA/D7YdAGPnlX1I7dTcYzsuVLifL4pF2LDGjL+C
         8b/qqIyFA8kCdfTfNkg/3+4sTLbFAvAi1qYkqmlSdbvUJWpSTKLj3olUXty1YShI5xjV
         x24myaVj1YwhD3TcwOvMQm4b/G5N0Z5iUm5azMnfhii/ecnHQhFffUI/5+7sdV7D8dfQ
         XFW7qhSIDgN1TM4bowYybtHKvH7Rb6rkbaLSrBoPmcmB1WUAUASFz2YYer1TKpgTkicP
         ZIZg==
Received: by 10.52.69.132 with SMTP id e4mr8449924vdu.2.1349191104486; Tue, 02
 Oct 2012 08:18:24 -0700 (PDT)
Received: by 10.58.69.100 with HTTP; Tue, 2 Oct 2012 08:18:04 -0700 (PDT)
In-Reply-To: <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
X-Google-Sender-Auth: XGxqZSGdxeT-6J2EihgV_8-YovQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206805>

Thanks Rankumar! There's also the reference in the "git push origin"
example and the "This is the default operation mode if no explicit
refspec is found".

(I would have sent my own patch but I can't figure out where the
syntax for the manpages is documented.)

--dave

On Tue, Oct 2, 2012 at 8:09 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> David Glasser wrote:
>> Is the newish push.default documented in the "git push" manpage
>> anywhere? I don't see it mentioned (and there are several references
>> to the "default" behavior), but maybe I'm missing something. Is it
>> left out on purpose (ie, config values aren't supposed to be mentioned
>> in command manpages)?
>
> You're right.  It's documented in `man git-config`, but we should
> probably mention it in the `git-push` manpage.
>
> --8<--
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Tue, 2 Oct 2012 20:37:13 +0530
> Subject: [PATCH] Documentation: mention `push.default` in git-push.txt
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-push.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index cb97cc1..8751b38 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -37,7 +37,8 @@ OPTIONS[[OPTIONS]]
>         `+`, followed by the source ref <src>, followed
>         by a colon `:`, followed by the destination ref <dst>.
>         It is used to specify with what <src> object the <dst> ref
> -       in the remote repository is to be updated.
> +       in the remote repository is to be updated.  If not specified,
> +       the configuration variable `push.default` is used.
>  +
>  The <src> is often the name of the branch you would want to push, but
>  it can be any arbitrary "SHA-1 expression", such as `master~4` or
> --
> 1.7.12.1.428.g652398a.dirty



-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
