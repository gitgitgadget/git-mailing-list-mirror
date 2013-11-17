From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 5/6] for-each-ref: introduce %(color:...) for color
Date: Sat, 16 Nov 2013 19:04:44 -0500
Message-ID: <CAPig+cT2LYTRwVfkNEdH4U+eJ4STcRd3tKYMDekb239qLw=zvA@mail.gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
	<1384513148-22633-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 01:05:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhprW-0001FT-SZ
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 01:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab3KQAEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 19:04:50 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:50887 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab3KQAEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 19:04:48 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so47599lbi.29
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 16:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nRn4vXxaQ+bYZ6o7Jy4q9qKAeHiNSyKhFrZZa2Bad3g=;
        b=uulggBEYKvKubMVrYNX91o8fyuvFPPqO69S8rAp7k80md1OQt5r7rCz09C1DQjs62G
         pr/DNaueV4bFCjHl7nk1ofgOfmg6pxg8F4mZ7BWmoP7PM1zAgBrk9639nLjf7NQwQd6n
         cLB/dYK4F7XHXBduN+iDT7sprUfNCDn9u36i7q74+mDgf4QvLAJscY7Is8Z2a8739xoz
         MeTt+vtWRWZV/wzCpRoPILc7o/LLdVeA7k+ABDknCUd0tWieP6ey73mP4oSIA8BHrIli
         e5Ksn8zRfd1RSZdzRmmQc4SpX+OnxWpUlQIWNCNwcBLWDxhfj8jcNwWDVuABLzZtEttU
         tEAg==
X-Received: by 10.112.155.106 with SMTP id vv10mr403411lbb.38.1384646684460;
 Sat, 16 Nov 2013 16:04:44 -0800 (PST)
Received: by 10.114.200.180 with HTTP; Sat, 16 Nov 2013 16:04:44 -0800 (PST)
In-Reply-To: <1384513148-22633-6-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: y7Av7jmZryxlUr7COeyG1_8ECGo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237947>

On Fri, Nov 15, 2013 at 5:59 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Enhance 'git for-each-ref' with color formatting options.  You can now
> use the following format in for-each-ref:
>
>   %(color:green)%(refname:short)%(color:reset)
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  4 ++++
>  builtin/for-each-ref.c             | 11 +++++++++--
>  t/t6300-for-each-ref.sh            | 14 ++++++++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index c9b192e..2f3ac22 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -101,6 +101,10 @@ HEAD::
>         Used to indicate the currently checked out branch.  Is '*' if
>         HEAD points to the current ref, and ' ' otherwise.
>
> +color::
> +       Used to change color of output.  Followed by `:<colorname>`,
> +       where names are described in `color.branch.*`.

"Used to" sounds past tense. Perhaps:

    color:<colorname>::
      Change output color to `<colorname>`, where...

>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>  be used to specify the value in the header field.
