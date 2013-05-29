From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH v2 4/8] rebase: cherry-pick: fix abort of cherry mode
Date: Tue, 28 May 2013 22:35:44 -0700
Message-ID: <CANiSa6g10XQJMCrvu1U-YG8OpZXOLA1A_fTYoPh=RHoBkHu2Mw@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:35:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZ38-0007yz-FM
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab3E2Ffq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:35:46 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:44298 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3E2Ffq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:35:46 -0400
Received: by mail-wg0-f45.google.com with SMTP id n12so5934335wgh.0
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E/nFr9eL1JNuWycT2s2mkOB5gzNgRutX1wrG+m7i3Ng=;
        b=p0/2Cra5JIKtOpwz5ZYDOPTYDHnsmDBqr0JvDkvEHsEDhdkceFgxQzHf6I/DRZrqSW
         hfIyhfH90o84AewhW6uV/ptDRTiZIg3zXQaLTcis7CK4YVgeE3oSCS66JqTW1YL66qLL
         jqPJzH10FZBB/Z/bkfb4UNIpzivqY9T1ZdrUoDvyUg6y9YxPGGZcp1sjQO3rXPTlR1fq
         w1wvYTbiSXKr5x/iNrGzJtQvLignOT4KRz7eiXaFfoLNOoZ13otG0DQKylEWfdX78tvA
         FoSdN5qJY7EXtHzMldRKkLQAatQAyzjXDymXBneOK7tgsmr1rdJTyLVynX3pFeJnfp/n
         BDSQ==
X-Received: by 10.180.108.3 with SMTP id hg3mr831273wib.17.1369805745033; Tue,
 28 May 2013 22:35:45 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 28 May 2013 22:35:44 -0700 (PDT)
In-Reply-To: <1369801000-3705-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225739>

Same here: should this have been in the first patch? If not, do you
know for how long it has been broken (since which commit)?

On Tue, May 28, 2013 at 9:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-rebase.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 76900a0..9b5d78b 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -335,6 +335,7 @@ skip)
>         run_specific_rebase
>         ;;
>  abort)
> +       test "$type" == "cherrypick" && git cherry-pick --abort
>         git rerere clear
>         read_basic_state
>         case "$head_name" in
> --
> 1.8.3.rc3.312.g47657de
>
