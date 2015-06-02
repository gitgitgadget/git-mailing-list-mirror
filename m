From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 2/4] git-am.txt: add configuration section in git am documentation
Date: Tue, 02 Jun 2015 13:16:13 -0700
Message-ID: <xmqq38293lyq.fsf@gitster.dls.corp.google.com>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:16:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzsbm-0006Ss-2I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 22:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbbFBUQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 16:16:18 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34296 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbFBUQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 16:16:16 -0400
Received: by igbhj9 with SMTP id hj9so95606945igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TEgVwsUOWqeO/UtUD/AxQ08W80MA/RhW4v2JEWFcjYY=;
        b=wky+PuKnwkerMCHuRdvEYUvhyQR3e7td8Lo/HoBCsvnIa3dSY6bk0+p58TgjGEfISg
         9xF9SSOkKelEQ+hBRsDlTEeQUV/VNqkvwFMW5lVuMZeqnpVkcCPE2H6cL5gYB58gNSNw
         AQNzcq/8MNdKRVB6nZHgZgp1p5nuzq/KB7m5WyEQWoDMrqtTeRMHK4h1G47Gncrxq82F
         ko8xqnK8rbHLzbnc/KAVrHh0TAlyM3ne0t5Mw4QlDkJ1WAQiUnaBkH9mXQ8nVMgOAvsA
         ft2IBzs0TFF75bfh5mlo34na9LlU2mszB44Px1hf3MLUF3K7PB+UliP84FfQx8vFmrL6
         6F8Q==
X-Received: by 10.107.17.161 with SMTP id 33mr36301644ior.48.1433276175534;
        Tue, 02 Jun 2015 13:16:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id qs10sm10658285igb.14.2015.06.02.13.16.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 13:16:14 -0700 (PDT)
In-Reply-To: <1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 2 Jun 2015 19:34:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270592>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Prepare a configuration section for the git am documentation.
> Remove the part related to the am.keepcr configuration variable in the
> description of the --keepcr option and place the description of the
> am.keepcr configuration variable in the newly created configuration
> section.
>
> This section will be used in the next commit.
>
> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> ---
>  Documentation/git-am.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 0d8ba48..d412f6b 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -24,6 +24,16 @@ Splits mail messages in a mailbox into commit log message,
>  authorship information and patches, and applies them to the
>  current branch.
>  
> +CONFIGURATION
> +-------------
> +
> +am.keepcr::
> +	If true, git-am will call git-mailsplit for patches in mbox format
> +	with parameter '--keep-cr'. In this case git-mailsplit will
> +	not remove `\r` from lines ending with `\r\n`. Can be overridden
> +	by giving '--no-keep-cr' from the command line.
> +	See linkgit:git-am[1], linkgit:git-mailsplit[1].

As this is git-am.txt, the first reference smells a bit odd.

Other than that, looks OK to me.

Thanks.

>  OPTIONS
>  -------
>  (<mbox>|<Maildir>)...::
> @@ -43,11 +53,11 @@ OPTIONS
>  --keep-non-patch::
>  	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
>  
> ---[no-]keep-cr::
> +--keep-cr::
> +--no-keep-cr::
>  	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
>  	with the same option, to prevent it from stripping CR at the end of
> -	lines. `am.keepcr` configuration variable can be used to specify the
> -	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
> +	lines.
>  
>  -c::
>  --scissors::
