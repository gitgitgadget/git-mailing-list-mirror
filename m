From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v17 16/48] refs.c: add an err argument to delete_ref_loose
Date: Tue, 17 Jun 2014 07:34:12 -0700
Message-ID: <CAL=YDWmHg8b0qGqWjSy+0mT20mGgbADnteNKzd5A6OC-VUrsUA@mail.gmail.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
	<1402941859-29354-17-git-send-email-sahlberg@google.com>
	<xmqqd2e8o05p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:34:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwuSr-0000z7-OO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 16:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933214AbaFQOeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 10:34:16 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:52944 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696AbaFQOeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 10:34:13 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so6616641vcb.9
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rZojAuD0FMup0earQk0r4Q/XKH48WKtk+n0KS1BuZsg=;
        b=dP3Sb3xAORrESIuP13Zj9XwFcc8p5hLkFmzQz9LfEzRV9qzPAiXzum7LkOhcDWqy1U
         48ZsrEEJ62Biq8eQBsMMmgJ9xz2vMBswPqIAq/r4OyG2HKb5Te2+KNTsnw16+olEdvBe
         232sc85fAs6GEpb658LFbrcqaQuCZOqIv3gbXmbbR2TvijYXolSs8zmNYU4F0AozN8+h
         3opc8933CMi+aT3OC6gDAjmF/kf1jgu4UEOcdKmnPaWlef801Mt/JxH3xmRh74tfcF9/
         9cpIE6ty+LMTqH3fXeuDvK5eHFipouOzm+Ws8A0hC7nLoR8m6z2I8QL0JMs+EiJli6ZR
         zqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rZojAuD0FMup0earQk0r4Q/XKH48WKtk+n0KS1BuZsg=;
        b=fh30QVLijImTkB2YnpUQHlWiY8/wt1Au9dwVE3cWHRGOZ+txXxO4eg8NdjnEsTEGm/
         ze/4vClCSXLaRkTZQr7gmVQyw9gOKSSJ69jUXYtAGQYrWTIys6RLp88amEN9rHZb9DFE
         v712ioyagbPJpiZ34xtXcvn0z2WDlUoHz1eNOFTJDG0+3DsIH7OEkQumoiNT2q7Oab5x
         APGmOMfmQuuzdgnBMIeESLYL6Kv6Q9dDC3IIHC8uqXpzb+JecVqerXp17FndXMJToO8r
         DAoLlKX9M66yBOveFClLvEvqs4RVh7/ZweDCVK3ArZiIiNqPgikDqoyWtlvo7VRcVjeg
         ne3Q==
X-Gm-Message-State: ALoCoQkmES801Ehj/sHZL2kF/f35KIiyeTkP0FcJTnomyFwkEx5L98zjI5XAtXfl5TCoAYByGhRX
X-Received: by 10.52.248.209 with SMTP id yo17mr578824vdc.60.1403015652550;
 Tue, 17 Jun 2014 07:34:12 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 17 Jun 2014 07:34:12 -0700 (PDT)
In-Reply-To: <xmqqd2e8o05p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251861>

Let me redo it so it applies to current master.

On Mon, Jun 16, 2014 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The series applies cleanly up to 25/48 or so to 'master', but this
> step already breaks tests, at least t1400 but possibly others.
>
> Please do not make me bisect X-<.
>
> Thanks.
