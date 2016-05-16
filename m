From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/3] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Mon, 16 May 2016 03:07:06 -0400
Message-ID: <CAPig+cQM2tyXWek7cMZkfks1SA4MHcf9yvfJ1SRZ2-mRf1Q47g@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-2-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 09:07:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Ccy-0000Zu-EW
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 09:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbcEPHHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 03:07:36 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33050 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbcEPHHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 03:07:36 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so24125087ioi.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=YlysaxQy3ZY9ce98LligjxfurK1/QLaicF6HfTkQHDQ=;
        b=bbKLurRt53CheIEXAz9y5V1J+oKeXfjvok32fz0fue9eTPO8xhbtnZ5vJnojgiOV7g
         bAQPQRLiSrl4CiIA39CcP7DdpNKFDg2I63TQiw69KhNbVNDrQlRx4nCxj2ct6lJDFc7x
         G5puG3iE3zQYyp5x2jJWq7/57zliib5hevQR6l0G3wzI/fGbZZnT1Z2cZR1z0aTzD03r
         HdqjfcLxBCW1GVv4TsYstwrnYKdv//7rbm6LJAgXA8I60p/cWibrEXMRRLTCXq2mgB/9
         EubdjLVPc0y0ZsxOnTpOnT4rCpRSXaQ+/NdpYjljr+DazpCCxfkZAPGXU3CZ8T2Cb4tk
         hxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YlysaxQy3ZY9ce98LligjxfurK1/QLaicF6HfTkQHDQ=;
        b=IORH0+haMWHUa7SiKNPs/cne7c677ZW00iZ4AGjw73UcCzKIBoTaLPl4WEUmGrlngy
         yuzVo8hp/VizzjojNO6WbutGEK3mSqYb+MgYaHokbZbeFPMTeNVTncYruNJitBJbJleg
         3ko8sZ/SpgeMcVfvIOCY0zijE2LtnrK8QeLQ/GfbacZtyqfwhgAZc4d5GdEwLznCFJKq
         cGFXh81AbOAl63xjijBDOGBErRIoxlGZYo4CYPRBynNyl3ZizQTmMhcmdi7yIRIo0gwk
         /UwM/+F0Z2de5Vj1JSyp9fHmcv0uT6Pjjkni8ru3PmRK0oNyzKt4nQ3bzkmIH8hTLWd+
         ykQQ==
X-Gm-Message-State: AOPr4FV70UvNHK/mxsKPsWeqhuy4/QFB0rdWNyqeqK5dZFygjQcOON65gRZg5oz5t6OgUoF7qW4o7S288i41gQ==
X-Received: by 10.107.47.37 with SMTP id j37mr17806690ioo.168.1463382426439;
 Mon, 16 May 2016 00:07:06 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 16 May 2016 00:07:06 -0700 (PDT)
In-Reply-To: <1463031127-17718-2-git-send-email-pranit.bauva@gmail.com>
X-Google-Sender-Auth: -NNnvXIIMFmWDd5zbNvx3NrEE9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294727>

On Thu, May 12, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> `--next-all` is meant to be used as a subcommand to support multiple
> "operation mode" though the current implementation does not contain any
> other subcommand along side with `--next-all` but further commits will
> include some more subcommands.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
> -       if (!next_all)
> +       if (!cmdmode)
>                 usage_with_options(git_bisect_helper_usage, options);
>
> -       /* next-all */
> -       return bisect_next_all(prefix, no_checkout);
> +       switch (cmdmode) {
> +       case NEXT_ALL:
> +               return bisect_next_all(prefix, no_checkout);
> +       default:
> +               die("BUG: unknown subcommand '%d'", cmdmode);
> +       }
> +       return 0;

What happens if you remove this useless 'return 0'? Does the (or some)
compiler incorrectly complain about it falling off the end of the
function without returning a value?

>  }
