From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Tue, 28 Jul 2015 17:41:34 -0400
Message-ID: <CAPig+cQ4PmKc0J1_X2vxn+yJ=pVd5AjM3j7j15T8ojrTPsEY_Q@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:41:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKCd2-0001XX-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbbG1Vlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:41:37 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34298 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbG1Vlf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 17:41:35 -0400
Received: by ykax123 with SMTP id x123so107768676yka.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/pgcwvTSQVnLqXx+Cls7VeDZaikmzkS8EG0sviPchyc=;
        b=mdjCm52zm+yyIRqM/2XnnDDCxedlvSHHaeel5EZ0eThFDVQQn8Ca6KUGxlewrsbVg5
         79dMNvL76iRYql4vzt5koxn6Mzf1yHf1Do6MQT54BYv/JGc+sA4cFLf+xR46lI2xGe1n
         1b1wZIb7IKhDHyl6aHPyfr14uiXfVxexYW1pdFLEDuzDSA/oM1ev/xeF0nZyl+K+Eu3P
         o7LIP2+O8vYlxA4LHQkhuWO0IQd7thVEGKKruiRZd96TXY+QrZKIvVtjHw1Rg7eSHvgh
         vANEXKWyNesdXU904IlajE2dZEBPS8NbH79WN6bgn3XC4Za1AW3oduCAGZK92ezu7YER
         l2Iw==
X-Received: by 10.129.91.87 with SMTP id p84mr41265393ywb.95.1438119694319;
 Tue, 28 Jul 2015 14:41:34 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 28 Jul 2015 14:41:34 -0700 (PDT)
In-Reply-To: <1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 5pEaI56uuXsC1w6gAmVy9gdcalo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274854>

On Mon, Jul 27, 2015 at 3:27 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add a new atom "padright" and support %(padright:X) where X is a
> number.  This will align the succeeding atom value to the left
> followed by spaces for a total length of X characters. If X is less
> than the item size, the entire atom value is printed.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index e49d578..45dd7f8 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -127,6 +127,12 @@ color::
>         Change output color.  Followed by `:<colorname>`, where names
>         are described in `color.branch.*`.
>
> +padright::
> +       Pad succeeding atom to the right. Followed by `:<value>`,
> +       where `value` states the total length of atom including the
> +       padding. If the `value` is greater than the atom length, then
> +       no padding is performed.

Isn't this backward? Don't you mean

    ... If the atom length is greater than `value`, then
    no padding is performed.

?
