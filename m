From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/9] send-email: simplify sendmail aliases comment and
 blank line recognizer
Date: Sun, 31 May 2015 23:30:41 -0400
Message-ID: <CAPig+cR=_3Bb4NOb=4uD8sokhU_n6=5nh3WdvTH5_yL_t_uung@mail.gmail.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
	<1433111371-19573-7-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 05:31:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzGRG-0004wo-Pm
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 05:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbbFADan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 23:30:43 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:32978 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbFADam (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 23:30:42 -0400
Received: by iebgx4 with SMTP id gx4so99595185ieb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QOUDTGgAQQ3IpnX3B6ZbApvHkNWq2CwC+KJRlioe7kw=;
        b=jPp307TPpZm4Pxpch3zaPUrnqPCRGyOKn2RYAmXAhpW3ffWi6j48DMTcsOsFiqE92r
         j2qbEkLH/WtAWzAP92bqltmtN8Wi4dehoB9c+pHO0W387heQC0EqlB1+x9+MV1/+0A7N
         EQlR4rtxOgoclx4GzM9qaQON2DWAvFI9qRCxG04JDTAIbJ2uSgCmKpI+2ceBXDuk1Wq/
         d4Gea26P6OCq8HBs++a2MSEv3jnMC2m73ojJmkGyIFbLMhKRaZ2HNzeja/eLkLGz8ZWh
         d2JPapHZ2ybhYwiX6wuTl2xWd3x79bEo6Mspcp5T/rgEUNUkrQIJ14jDe+D/o8OJj0Wv
         ENuA==
X-Received: by 10.107.31.134 with SMTP id f128mr6007418iof.19.1433129441991;
 Sun, 31 May 2015 20:30:41 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 31 May 2015 20:30:41 -0700 (PDT)
In-Reply-To: <1433111371-19573-7-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: 4pbixcNIzg1p7N1xIvnI6OYiHJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270374>

On Sun, May 31, 2015 at 6:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Replace unnecessarily complex regular expression for recognizing comment
> and blanks lines in sendmail aliases with idiomatic expressions which

s/blanks/blank/

> can be easily understood at a glance.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 76bb499..e777bd3 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -505,7 +505,7 @@ sub parse_sendmail_alias {
>  sub parse_sendmail_aliases {
>         my $fh = shift;
>         while (<$fh>) {
> -               if (/^\s*(?:#.*)?$/) { next; }
> +               next if /^\s*$/ || /^\s*#/;
>                 parse_sendmail_alias($_);
>         }
>  }
> --
> 2.4.2.538.g5f4350e
