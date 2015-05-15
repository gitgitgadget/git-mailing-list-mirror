From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Documentation/log: clarify what --raw means
Date: Fri, 15 May 2015 13:29:28 -0400
Message-ID: <CAPig+cTWipduPMXg-3uxgaBo_VkzGQdHe-D72EuN93B3dWzbmQ@mail.gmail.com>
References: <297757279.1883703.1431704571028.JavaMail.zimbra@imag.fr>
	<1431704674-18595-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	eda@waniasset.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri May 15 19:29:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtJQU-0002dK-ED
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 19:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933913AbbEOR33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 13:29:29 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36575 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbbEOR32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 13:29:28 -0400
Received: by iepk2 with SMTP id k2so120730352iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Uq89XN0FcCzUBz/0DDk8Y3xPmI43+JBrehv4j7tQ2fM=;
        b=uJ3F/5G50gkjHopj+/eE2s6HYwBYU/QJg+R4jRIQZ44Nx5XBa3P+fAn/iQfGa0FeXO
         4BJfqo0OVb1Ee/D07WNuAWtIeP2RIiTkV1ls1Xpd9r1ysxfeyjws1hZEe9X6L6e2J5Tl
         8p+/jagBxQ0Ze1xNuNPcSzrrRBoIAoTQ0R/NOlgmHvHQp1Z00OCwcjhfat3GzczCL9GY
         SIPlKrRsiB567mpHKvW6jSFmh8N20VjafDby2xrdT+esL28egB3b1gocz1pNHrQgGlAQ
         mN8XPtZOkUjDxGCGnZqFoIVwU2T2VH//5wdoI8V2hgYT0S2YDqpmpih6f5EZxQyaosxc
         fgYw==
X-Received: by 10.50.66.230 with SMTP id i6mr26905693igt.22.1431710968087;
 Fri, 15 May 2015 10:29:28 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 15 May 2015 10:29:28 -0700 (PDT)
In-Reply-To: <1431704674-18595-1-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: Pb6hfceNWxDFhI0EN7kAzEyJd7U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269158>

On Fri, May 15, 2015 at 11:44 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> There are several "raw formats", and describing --raw as "Generate the
> raw format" in the documentation for git-log seems to imply that it
> generates the raw *log* format.
>
> Clarify the wording by saying "raw diff format" explicitely, and make a

s/explicitely/explicitly/

> special-case for "git log": "git log --raw" does not just change the
> format, it shows something which is not shown by default.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index ccd4998..163163b 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -41,8 +41,17 @@ endif::git-format-patch[]
>
>  ifndef::git-format-patch[]
>  --raw::
> -       Generate the raw format.
> +ifndef::git-log[]
> +       Generate the raw diff format.
>         {git-diff-core? This is the default.}
> +endif::git-log[]
> +ifdef::git-log[]
> +       For each commit, show a summary of changes using the raw diff
> +       format. See the "RAW OUTPUT FORMAT" section of
> +       linkgit:git-diff[1]. This is different from showing the log
> +       itself in raw format, which you can achieve with
> +       `--format=raw`.
> +endif::git-log[]
>  endif::git-format-patch[]
>
>  ifndef::git-format-patch[]
> --
> 2.3.5.2.ge515092.dirty
