From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to
 and --bcc
Date: Tue, 18 Jun 2013 16:17:44 +0530
Message-ID: <CALkWK0=vytkxM3yzVaed+i3Q+RpvH=tSLndf=vUmiYC=sn=nFg@mail.gmail.com>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 18 12:48:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UotSg-000364-F1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab3FRKs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 06:48:26 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:59765 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3FRKsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:48:25 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so9635591iec.21
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U/2zAhNXKqLvfhO3an+r8H1n4gR9+tlnWgxgd31f6+A=;
        b=oQM2CX3KIwu+4IL0II6qsKK3QGeNnFoQMMB558qoRRrnYcH81Uw54wIJZPlM2dID5c
         ZhQQP/BrSFUyA3F9m+OJ1xMe18QignhqWPjheCRthXXBNCrEBrI/hnzc8bpZz+Hg9lFE
         d5sA0dx3Xd77y2o1WnJEL8Jst+sHmBKv8vS4tJ20hapjfzdjK4l74NqYB9y2dj/hd9ko
         Af84qBphjVLvR7gL/LZrg+YIwFtfeSJMIiAoOVwI42PEy6InOID1Np5DpWv6ndEMXrVl
         qzxPtkzecfcl6xIE1g1b02cGuaVfi/UJdfI4K7eJyj/paRh/BB8Kg5CZlQbZyfSKs9a0
         KOcA==
X-Received: by 10.50.98.104 with SMTP id eh8mr7177960igb.111.1371552504565;
 Tue, 18 Jun 2013 03:48:24 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 03:47:44 -0700 (PDT)
In-Reply-To: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228191>

Jorge-Juan.Garcia-Garcia@ensimag.imag.fr wrote:
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 9f46f22..87641bc 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1349,4 +1349,39 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
>         grep "^!someone@example\.org!$" commandline1
>  '
>
> -test_done
> +test_expect_success $PREREQ 'setup expected-list' '
> [...]
> +test_expect_success $PREREQ 'use email list in --cc --to and --bcc' '

What is the meaning of this test?  It looks like you've run git
send-email twice in exactly the same way, and compared their outputs
(after smudging the unstable headers).
