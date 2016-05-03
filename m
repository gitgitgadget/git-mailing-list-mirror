From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 09/11] connect: use "-l user" instead of "user@" on ssh
 command line
Date: Tue, 3 May 2016 13:33:24 -0400
Message-ID: <CAPig+cTTeJf+ACfJ8yDj3tbiwUEhcjgn=MiDkzgDk7sYu4FA+w@mail.gmail.com>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
	<1462265452-32360-1-git-send-email-mh@glandium.org>
	<1462265452-32360-10-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 03 19:33:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axeCP-0003sp-Py
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 19:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934351AbcECRd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 13:33:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36572 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934134AbcECRdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 13:33:25 -0400
Received: by mail-io0-f193.google.com with SMTP id k129so2982461iof.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=xQXkTp5qTbCxAuD3mE8xQqKTq6EeeEFwxExDJaUZeVY=;
        b=AZmEZ+E9DHeTG3FLyf2IGVhxAaFnh1LJ43hChFOMQ3jVKeITJ9ISohKT5MLjooaPGl
         08oibds2H2+IiKSBl4Xw3+ZLmZ/na4a9u4SEg0AkpSO73+NqTPwrIQXuL3G+hFnw+c/L
         1qTKqMMEKpZYZm9eTAjwnuNnnnuVnvRG35WarPI4tboEZvNTWLQRCTkVbNqPV2csuBLW
         P53WTF0BytDlZ8W/yV6Tw7IMWbtmnZQCFtzqYh9636HlbTvBBd+ieVXmTLsOgUbGCldM
         uSqRxMnfPN31NXps0ucuzX0qI+HTQwuS99lYI4m0zfiWhRwXfNj43TkEM0T74h7MOXuE
         XZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xQXkTp5qTbCxAuD3mE8xQqKTq6EeeEFwxExDJaUZeVY=;
        b=nN7TcYgHjORo1MB4zluF1POdsEKh0h9P+7e+FhKhwr+CtkcYc7m3KIHhF5hlLv/PC0
         BjTFsKUYTWWH7no3NB4GJYDPndPlxDKC7GcxbNEQcJGhOMjLs6RqGdMHYr9yDklCqjR7
         TzL1kS3x9qiWdftOjmmmwqyfzccaih5/vp6Ui841pZLNK3IWYQUauX5WW/AMMP8MTNvc
         KUKlvWRDSQ5USCx/zpy4dsZ7zyG+4/JiYyLMjWVcUqXgn1dLlIEDHW/1GS4mLK/QHfUZ
         pGSr9plB0JeG7CYb09OVFzT1hltIXM5BvUojtS3rjcGep2TnjBtWemfJyCe81SR1p709
         eWXg==
X-Gm-Message-State: AOPr4FXSIH5skxQu66Wa3lMgqZpLR451sufJZdX+mbokF2efHRLtZsWKCTS8jhPASWlXFtKfW+gjU8HHKEeABw==
X-Received: by 10.107.132.66 with SMTP id g63mr5226279iod.34.1462296804616;
 Tue, 03 May 2016 10:33:24 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 3 May 2016 10:33:24 -0700 (PDT)
In-Reply-To: <1462265452-32360-10-git-send-email-mh@glandium.org>
X-Google-Sender-Auth: lnAXzwJL2UuyHQVkkHKHADNAV8Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293421>

On Tue, May 3, 2016 at 4:50 AM, Mike Hommey <mh@glandium.org> wrote:
> While it is not strictly necessary, it makes the connect code simpler
> when there is user.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
> diff --git a/connect.c b/connect.c
> @@ -812,14 +812,10 @@ struct child_process *git_connect(int fd[2], const char *url,
>                         if (user) {
> -                               struct strbuf userandhost = STRBUF_INIT;
> -                               strbuf_addstr(&userandhost, user);
> -                               strbuf_addch(&userandhost, '@');
> -                               strbuf_addstr(&userandhost, host);
> -                               argv_array_push(&conn->args, userandhost.buf);
> -                               strbuf_release(&userandhost);
> -                       } else
> -                               argv_array_push(&conn->args, host);
> +                               argv_array_push(&conn->args, "-l");
> +                               argv_array_push(&conn->args, user);
> +                       }
> +                       argv_array_push(&conn->args, host);

Even simpler would be a one-liner for the user case:

    if (user)
        argv_array_pushf(&conn->args, "%s@%s"", user, host);
    else
        argv_array_push(&conn->args, host);

>                 } else {
>                         transport_check_allowed("file");
>                 }
