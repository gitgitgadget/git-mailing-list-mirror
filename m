From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v2 7/9] remote-bzr: tell bazaar to be quiet
Date: Thu, 25 Apr 2013 20:59:34 -0400
Message-ID: <CAEBDL5Uaw6t=T1NOhRDutmH_V0dax3Pzger9Ti34Dy4tPT3K0A@mail.gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
	<1366934902-18704-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 02:59:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVX0n-0002Qi-OC
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396Ab3DZA7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:59:37 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:55206 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758244Ab3DZA7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:59:36 -0400
Received: by mail-we0-f169.google.com with SMTP id p43so3168760wea.14
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=6QQ3tqwnQIdpKHIzv90cuRXAKw2AMI/oz2xYoPpxDLM=;
        b=vEx0oR/3XRVo5511CAN2Ctb+DczHfTRJqbeC1hxLuBk9BTEVV2KtFHuN93XjAEzrJj
         Kv6MyydOIDCU1cEfOgeBnYCcxzvBwWdJppW0qub3iJVKJLo66ziuAb3BOpQXtFKZMme6
         Gvnet7w4FzjWf0CPHqrAaE/z0GtGbvZxixGptoxCue2PX+TksPDwqlfZjtmaQ4vZcGbd
         FkWn2ErIXraE9c2qWdcbWzlo1YKbA4xDUXIMyCL1ry7Gdz6hG2loL5f7KpAQXMQf7WFw
         VwuiMVc7Yo+FSJFckjtrGEknd9UtMOzJGfSLGNvB7IlXwnhFRl1LEVZxpdGtYICznFmw
         byrw==
X-Received: by 10.180.182.110 with SMTP id ed14mr929673wic.6.1366937975054;
 Thu, 25 Apr 2013 17:59:35 -0700 (PDT)
Received: by 10.180.187.240 with HTTP; Thu, 25 Apr 2013 17:59:34 -0700 (PDT)
In-Reply-To: <1366934902-18704-8-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: pmq9WGKOg5lIHzPVhEStVKuDA0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222481>

On Thu, Apr 25, 2013 at 8:08 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Otherwise we get notification, progress bars, and what not.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-bzr | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index dda2932..8617e25 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -26,6 +26,7 @@ bzrlib.plugin.load_plugins()
>  import bzrlib.generate_ids
>  import bzrlib.transport
>  import bzrlib.errors
> +import bzrlib.ui
>
>  import sys
>  import os
> @@ -755,6 +756,8 @@ def main(args):
>      if not os.path.exists(dirname):
>          os.makedirs(dirname)
>
> +    bzrlib.ui.ui_factory.be_quiet(True)
> +

Nice change!

-John
