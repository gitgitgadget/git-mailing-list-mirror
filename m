From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Tue, 26 May 2015 18:52:15 -0400
Message-ID: <CAPig+cThB1xC0B6wC29Bm0QUiPpGbkVe9j_Qu5LLdVq3XFMgoQ@mail.gmail.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 00:52:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxNhy-0007bt-GN
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbbEZWwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 18:52:18 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36366 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbEZWwP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 18:52:15 -0400
Received: by igbpi8 with SMTP id pi8so70832162igb.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=45JjduCDP6DXRY7g62Xmbk5LMXs+A1A8RIRt59cv/Ow=;
        b=kio8IDht5doG8CM4WQy6YR9IyMX1rwReCAzUsqVze7n249KZM0iQ21wOT6uy3DqOdq
         BaBNguefUfR2fYqEAP3Gpfhz4j7Y93FiCq26G/Dcd+nrwZFme6z5FpAeF+lTGm0vuH9C
         msPC3p8GfRtQiMZ0Ejqeh6Mr166N1kfPvMd0dbvT5vIre7k9h1lpdSXxazDjqcOWitxq
         pCeYvC2wrErVbU5b83uYI91Y9x+PULrxhI3+euYIXmbujG8lUFGcdVwETb6wPfxDIcOC
         jJHHU0bxHJLlz1KTGwfDGBHQRUuKhBgxCq9iJ8QmZK0rEbcgGmltad8tJQE2w5D6onCn
         5IeA==
X-Received: by 10.50.61.200 with SMTP id s8mr28188311igr.7.1432680735124; Tue,
 26 May 2015 15:52:15 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 15:52:15 -0700 (PDT)
In-Reply-To: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: vp6Ba6ZQk-YK1Ri8GzDAKjzh-40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270005>

On Tue, May 26, 2015 at 5:38 PM, Galan R=C3=A9mi
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> git-rebase -i: Add key word "drop" to remove a commit

"key word" is unusual. More typical is "keyword". However, perhaps
"command" might be even better. Also, custom on this project is not to
capitalize, so:

    git-rebase -i: add command "drop" to remove a commit

> Instead of removing a line to remove the commit, you can use the key
> word "drop" (just like "pick" or "edit"). It has the same effect as
> deleting the line (removing the commit) except that you keep a visual
> trace of your actions, allowing a better control and reducing the
> possibility of removing a commit by mistake.

Nicely explained.

Ditto regarding "key word".

> Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-i=
np.fr>
> ---
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 1d01baa..3cd2ef2 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -514,6 +514,9 @@ rebasing.
>  If you just want to edit the commit message for a commit, replace th=
e
>  command "pick" with the command "reword".
>
> +If you want to remove a commit, replace the command "pick" by the
> +command "drop".

I think the existing method of removing a commit merits mention here. P=
erhaps:

    To drop a commit, delete its line or replace the command
    "pick" with "drop".

Or, if you want to emphasize "drop":

    To drop a commit, replace the command "pick" with "drop",
    or just delete its line.

>  If you want to fold two or more commits into one, replace the comman=
d
>  "pick" for the second and subsequent commits with "squash" or "fixup=
".
>  If the commits had different authors, the folded commit will be
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..cb749e8 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
