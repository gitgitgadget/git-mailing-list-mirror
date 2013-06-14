From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 21:45:24 +0530
Message-ID: <CALkWK0n+KSrehL3tZ557c2hfKna6p_jVGL+a2az5V+h4=DstJQ@mail.gmail.com>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
 <1371196058-23948-2-git-send-email-artagnon@gmail.com> <7vhah0raps.fsf@alter.siamese.dyndns.org>
 <CALkWK0m6r4yRfCLb3dejdY+1KJgdOHPfrvPXbftNucApXFx+0A@mail.gmail.com> <7v1u84ra77.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 18:16:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWfc-0005aJ-JE
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab3FNQQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 12:16:08 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:42198 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab3FNQQF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 12:16:05 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so356651bkc.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hLqK8VO0CAcZ0T8Douz6I3uSfkQipb9EIZon4zyGbXI=;
        b=AzRZ7E0NF6xmPDH1c0X7QZGSAcw1tR7mF7y5c23Pe1XvJTEYWj93hPqOMhTTTnjpoE
         2YW1YpnV2GpNSBD/b/E/yGRBmZl9gNqCSPoB8B0qYQ7/zlGKMamKSDdposPNv2EE6aaS
         //H99IKn9EgWRwx6SavfapWyu9+i+gMtZKsXeSdbJMKLnc62PgOgGLD602wYXf2q69OX
         A9JN/UYBc3EQP+XKuE71iDauIyQ81W8MyPLTMMd8NXviHSy2pVdtJg/pBymiZkx6h7AQ
         TwkghPoT3jF1irMixAl8aEvsHyjZydyqE/ocVJmJHoE78pErtqUNldOF5aC81aXtKtzI
         BTZA==
X-Received: by 10.205.103.67 with SMTP id dh3mr437093bkc.19.1371226564764;
 Fri, 14 Jun 2013 09:16:04 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 14 Jun 2013 09:15:24 -0700 (PDT)
In-Reply-To: <7v1u84ra77.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227893>

Junio C Hamano wrote:
> The reason would become clear once you think what string you are
> feeding eval_gettext with if you do not escape.  The translators
> translate a fixed string (possibly with placeholders) to a fixed
> translated string (possibly with placeholders).
>
>         eval_gettext "Stray $dotest directory found. ..."
>
> would allow the shell to expand $dotest before eval_gettext sees it,
> which would mean the string is no longer a constant.

Ah.  I was scratching my head wondering why $dotest needed to be
translated (it's just a path).
