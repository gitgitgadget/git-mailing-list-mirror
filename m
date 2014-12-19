From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 5/6] push.c: add an --atomic argument
Date: Thu, 18 Dec 2014 20:29:17 -0500
Message-ID: <CAPig+cSHKsrJPF8eA-iHb+=CziaDcjwE58DhKYNG53Y8EhPZug@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418841177-12152-1-git-send-email-sbeller@google.com>
	<1418841177-12152-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 02:29:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1mNe-0005JG-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 02:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbaLSB3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 20:29:18 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:36872 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaLSB3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 20:29:18 -0500
Received: by mail-yh0-f43.google.com with SMTP id z6so10229yhz.30
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 17:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mE/0ihze1bLUuJx9XXSRmRRlfxSn47b9a1JORl9GyAc=;
        b=lBsXuN2a9ogmu1cCjqaDhUL4w5Ci08u+BhJCqknxBIOnvgh8MqmwkCa8XN4fJIJzP5
         ZnNkC4gbFuhDR2uBdhRtjRNcAOfzvOCE/xsLLZDzjsiCedRraIFjU9zJ6+ejsYxLmv1l
         zjhEK+WAXEniXA9fc2ALb0Z4ET7aCf9hDpNY75IMFQufH1IPOdkRS6gF47DijWx6V7rC
         zRZtVgf5RaDMyO6GEAU+wiLMiLRJ8+rMQbWqSIQ9o8BqkC/rNS4HiGZO5VsKEFD+5uHy
         bmhfb/xVAICYSNETyFU0kHO9U+kYHPoJsE/QPqg8kgNJMIq9qTcjgM5F0SrKvULmVuOW
         DzRg==
X-Received: by 10.170.130.21 with SMTP id w21mr5106010ykb.22.1418952557488;
 Thu, 18 Dec 2014 17:29:17 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Thu, 18 Dec 2014 17:29:17 -0800 (PST)
In-Reply-To: <1418841177-12152-6-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: dgwOPdnNaeccfHM-KR6Mkil1VJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261546>

On Wed, Dec 17, 2014 at 1:32 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> Add a command line argument to the git push command to request atomic
> pushes.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/push.c b/builtin/push.c
> index a076b19..5731a0d 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -518,6 +518,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>                 OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
>                         TRANSPORT_PUSH_FOLLOW_TAGS),
>                 OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
> +               OPT_BIT(0, "atomic", &flags, N_("use an atomic transaction remote"),

Unable to parse. Perhaps:

    "use an atomic transaction on remote side"

or

    "use an atomic transaction on the remote"

or

    "request atomic transaction on remote side"

> +                       TRANSPORT_PUSH_ATOMIC),
>                 OPT_END()
>         };
>
