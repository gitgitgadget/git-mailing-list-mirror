From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] completion: remove credential helpers from porcelain commands
Date: Tue, 5 May 2015 16:28:04 +0200
Message-ID: <CABPQNSZAbhzQKoYS=QNOyqUEm0yA9nbFpx8NZdgQ-CiC-rQXVw@mail.gmail.com>
References: <1430831972-6788-1-git-send-email-szeder@ira.uka.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 05 19:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpgpP-0006ND-29
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993841AbbEEQGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2015 12:06:34 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35902 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993202AbbEEOgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 10:36:39 -0400
Received: by iebrs15 with SMTP id rs15so146625133ieb.3
        for <git@vger.kernel.org>; Tue, 05 May 2015 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=xgjF1w9dWLrAQi0rEOMHt2RB2uySDDDmPJntKSnElZk=;
        b=pJJSH6jDsOmSSY+smqPjsRFD9RzugrWdzLF69+oEJLOUfBSe1l5y7WTsTBsZqdr9Sm
         OoBMDMcRHcYLLRjWvUQUjxYk2V5tywKye85MrtW3ikA77TJc03Z6NHyM0OeUjCYGWiIh
         0KC7UTC538bDGXzYewW9hiAkfZJnNe4L9nqNx5EvqK8dQXnHkOID07j7D9SrU+IMuThg
         xqTlo5woBVoGtjTqDZCJwwf7/qwVP26pojSPLhBpB3Ue4u+gEoSnEU9sKOnyCJHdaAEI
         g1HigQQV8r+Qwzmxr1ouJUpSWMQp7xAw5BbFQkh4xpZPO6lFzb42oqVAn9utwVNjJf31
         ukTg==
X-Received: by 10.42.213.136 with SMTP id gw8mr32932334icb.95.1430836124642;
 Tue, 05 May 2015 07:28:44 -0700 (PDT)
Received: by 10.64.88.165 with HTTP; Tue, 5 May 2015 07:28:04 -0700 (PDT)
In-Reply-To: <1430831972-6788-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268404>

On Tue, May 5, 2015 at 3:19 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> w=
rote:
> Don't offer the "main" 'git credential' command or any of the credent=
ial
> helpers from contrib/credential/ when completing git commands.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>
> I was tempted to simply filter out 'credential-*', so we don't have t=
o
> update this list when new credential helpers arrive.  However, the
> 'git-credential-*' "namespace" is not explicitly reserved for credent=
ial
> helpers, users have to set the 'credential.helper' config variable to=
 tell
> explicitly that 'git-credential-foo' should be used as credential hel=
per,
> and who knows, someone might have his own 'git-credential-bar' comman=
d that
> does something completely unrelated to git's credential system, so in=
 the
> end decided against it.  And credential helpers don't pop up too freq=
uently
> anyway.
>
> However, if you think filtering out 'credential-*' is the way to go, =
I'm
> happy to reroll.
>
>  contrib/completion/git-completion.bash | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index e0eb6ae..527bb00 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -665,8 +665,13 @@ __git_list_porcelain_commands ()
>                 checkout-index)   : plumbing;;
>                 commit-tree)      : plumbing;;
>                 count-objects)    : infrequent;;
> +               credential        : credentials;;
>                 credential-cache) : credentials helper;;
> +               credential-gnome-keyring) : credentials helpe;;

Typo? Should be "helper;;", no?
