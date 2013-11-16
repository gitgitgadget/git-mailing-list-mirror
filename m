From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/6] for-each-ref: introduce %(HEAD) asterisk marker
Date: Sat, 16 Nov 2013 18:23:23 -0500
Message-ID: <CAPig+cRkaQAZm76tzuPMnddaZE2qaN=yOF8O9dSaB4pzbBq9ww@mail.gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
	<1384513148-22633-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 00:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhpDN-0002L1-2g
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 00:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab3KPXX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 18:23:26 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:59791 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab3KPXXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 18:23:25 -0500
Received: by mail-la0-f53.google.com with SMTP id ea20so3780817lab.26
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 15:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ClnC3r2HsmF4kPWokR/j1GNYlfvr7kD3htDWqphVqe8=;
        b=yEiF4q76U/Q6qDDtk9mRIKsiBMoXEB8mRcqSrpj49HFme2kgfq6rx+DpZ49iPg4E4o
         Gk4zApRNZNl2ZjS86VHCGgKng/TFVpuzz5KZcGzb6+AoTmzb/xl7L1jCoKhVMuUVc8yZ
         uhLUpZTk0myDkv38gnGh9FQdDJJ0NbVqug41eGBXOGNUc6qziR3mriLp/Xk8nBGSNqto
         PT7X/hrzc9bGBV+X9DNl6OIfBe4BxZYb4+X0ZU1kKtRjqRnOwdTVUWJ8yFazy8i7HRtA
         xxfhnwA6PcYPYnQMZAEgicC7/E13k/WdFaNMqWNe+bC8/3UP/WtkxpkIYZbe81VJ+qpO
         BqNg==
X-Received: by 10.152.120.231 with SMTP id lf7mr370837lab.36.1384644203357;
 Sat, 16 Nov 2013 15:23:23 -0800 (PST)
Received: by 10.114.200.180 with HTTP; Sat, 16 Nov 2013 15:23:23 -0800 (PST)
In-Reply-To: <1384513148-22633-4-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: 8EENRQ30pUhE7IJHruMe5nvsQ-w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237945>

On Fri, Nov 15, 2013 at 5:59 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> 'git branch' shows which branch you are currently on with an '*', but
> 'git for-each-ref' misses this feature.  So, extend its format with
> %(HEAD) for the same effect.
>
> Now you can use the following format in for-each-ref:
>
>   %(HEAD) %(refname:short)
>
> to display an asterisk next to the current ref.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  4 ++++
>  builtin/for-each-ref.c             | 13 +++++++++++--
>  t/t6300-for-each-ref.sh            |  2 ++
>  3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index f2e08d1..ab3da0e 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -93,6 +93,10 @@ upstream::
>         from the displayed ref. Respects `:short` in the same way as
>         `refname` above.
>
> +HEAD::
> +       Used to indicate the currently checked out branch.  Is '*' if
> +       HEAD points to the current ref, and ' ' otherwise.

"Used to" sounds like it is explaining something it did in the past.
None of the other field names are described in this fashion. Perhaps
something simpler along the lines of:

    Asterisk "*" if HEAD matches the current ref (the checked out branch),
    otherwise space " ".

> +
>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>  be used to specify the value in the header field.
