From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git daemon --access-hook problem
Date: Mon, 3 Jun 2013 21:05:30 +0200
Message-ID: <CALWbr2ynF425qfCNr_NGH8z9UiX2G2CRrWiCo2XrgBLBbyPHMw@mail.gmail.com>
References: <CAPZPVFZDHHGyHhzBVVK6jS=XhEd2+JpmBT8ofiGOww8vuLUWWw@mail.gmail.com>
	<CALWbr2ypPCoftVLfP9uKeKStg3TWwLDchkUaL1d9s9O3kcuPwA@mail.gmail.com>
	<CAPZPVFYdeuusW3=iBTBC+iPuOeAekvtMx6d_dozB9tsDCg3C8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 21:05:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uja4W-0008Lx-RL
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 21:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973Ab3FCTFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 15:05:32 -0400
Received: from mail-qe0-f52.google.com ([209.85.128.52]:47953 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab3FCTFb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 15:05:31 -0400
Received: by mail-qe0-f52.google.com with SMTP id i11so743462qej.25
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fQiCNWrtRjblv5AMU/zX8hLroFuB5SKlcT76MPtj04E=;
        b=YLMP1aWkaCn7o9SlZLFO+NK33VM8qfCSl1NRaEB7Kcs4rSAhDR67S5UQ6eSsv2+WNH
         ffA+j93tWpA0mhQt7HOMw1YxQVqxF+3gbi7ubRAcZek6Zoq1IhE3FS2+jBQFZTP2h8dH
         zaj6GmU38+xiEfmavmpHuAsoz4M5b3uqwyZekIdCobsUsoTVEfK0wrMQwPU1vkeBJCvv
         am1ivfkUSRBnGb7UbaRvurjIebVuSaNLyi7wUMQ1aeWHlMPQsns0UUqTB5C3uGSo9K2f
         bzyTiaFVo6J1MoU4H3FGQTcyD7pLLe7TPXAPOOChw8Uc8CeT5WeAnBP5cOm0FMeCzMTg
         +yJA==
X-Received: by 10.49.128.7 with SMTP id nk7mr22947088qeb.35.1370286330497;
 Mon, 03 Jun 2013 12:05:30 -0700 (PDT)
Received: by 10.49.14.40 with HTTP; Mon, 3 Jun 2013 12:05:30 -0700 (PDT)
In-Reply-To: <CAPZPVFYdeuusW3=iBTBC+iPuOeAekvtMx6d_dozB9tsDCg3C8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226266>

On Mon, Jun 3, 2013 at 8:02 PM, Eugene Sajine <euguess@gmail.com> wrote:
> Would you be able to advise how this should be done?
> I don't get the error message (i mean the output of pwd) if i do this:
>
> echo `pwd`
> exit 1
>
> What should it be?

Actually, after digging into the code, it looks like you need to call
git-daemon with "--informative-errors" if you want to allow custom
errors. Maybe there is place for improvement in the documentation.

Cheers,
