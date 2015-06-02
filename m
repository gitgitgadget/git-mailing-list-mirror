From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH/RFC v2 2/2] git-am: add am.threeWay config variable
Date: Tue, 2 Jun 2015 15:58:18 +0200
Message-ID: <CAHYJk3TDB-NgyvpJrBpgZRPgBJKshD0XwK9Z9g22K3nD+Fx=Rw@mail.gmail.com>
References: <1433251472-29460-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzmi0-0008TC-EB
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 15:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbbFBN6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 09:58:20 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34321 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbbFBN6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 09:58:19 -0400
Received: by ieczm2 with SMTP id zm2so133514752iec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+5F4MJQyNRktCDUBKrsMwPvZMZySv/rk9n4xi4l93MU=;
        b=ug5HGBtgQZRMTOpvPdBPLqZ/WfM0XQ+4DrdaNF2T6BIgqafSjKnHhLbBi9QXShjjeD
         5bEagEj0b3IwXgyG1TELalZzWQLJZ2CTyEkm3Sz6tjSD7D1sznpgQEIpsBnA+PXhrlGZ
         1+obeVAHYrjJ8yPDwKfzeRXWvRjHAFfGizTGzFWCPGPqdhCpijijhnKAanp4kAlhqBrL
         IYMSZg8swFAJIDCDfIjioRWhf5ciadaZisCeP71aPnv9/Bcw31PJY2IfFwxZztToSNdp
         aw0q4hio4dhIh6jv3iLAfLuGNFpqQcYRpdksHjunrgtcqIDUO527TW6Vy56Vry2yxJvM
         uZKg==
X-Received: by 10.50.114.5 with SMTP id jc5mr1698852igb.43.1433253498597; Tue,
 02 Jun 2015 06:58:18 -0700 (PDT)
Received: by 10.36.93.134 with HTTP; Tue, 2 Jun 2015 06:58:18 -0700 (PDT)
In-Reply-To: <1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270536>

On Tue, Jun 2, 2015 at 3:24 PM, Remi Lespinet
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> Add the am.threeWay configuration variable to use the -3 or --3way
> option of git am by default. When am.threeway is set and not desired
> for a specific git am command, the --no-3way option can be used to
> override it.
>
> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> ---
>  Documentation/config.txt |  7 +++++++
>  Documentation/git-am.txt |  6 ++++--
>  git-am.sh                |  7 +++++++
>  t/t4150-am.sh            | 19 +++++++++++++++++++
>  4 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d44bc85..8e42752 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -769,6 +769,13 @@ am.keepcr::
>         by giving '--no-keep-cr' from the command line.
>         See linkgit:git-am[1], linkgit:git-mailsplit[1].
>
> +am.threeWay::
> +       If true, git-am will fall back on 3-way merge when the patch
> +       cannot be applied cleanly, in the same way as the '-3' or
> +       '--3-way' option. Can be overridden by giving '--no-3-way'
> +       from the command line.
> +       See linkgit:git-am[1].
> +

This part spells it 3-way while everywhere else appears to be 3way.

-- 
Mikael Magnusson
