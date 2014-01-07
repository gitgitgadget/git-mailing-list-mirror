From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH] git-submodule.sh: Support 'checkout' as a valid update command
Date: Tue, 7 Jan 2014 18:42:02 +0100
Message-ID: <CALas-igswi9ro=j1r3YJ9wLd2ikp9fa6M-3ZSYQZXKmaTfGOWw@mail.gmail.com>
References: <1389034726-8744-1-git-send-email-ceztko@gmail.com>
 <xmqqtxdgfz8a.fsf@gitster.dls.corp.google.com> <CALas-ijrD1VnyUcr2yQw_1Je4K3eEdXtxqDNDKdGPZE=1=Nm3A@mail.gmail.com>
 <xmqqlhyrg49c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0afb-0004Dn-AE
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbaAGRmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:42:24 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:47861 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbaAGRmW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:42:22 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so537617oag.14
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D+8Yx17zQnChv7XRSXGqZWFZ7TyP7lvdEzx7IMkSViU=;
        b=X/yCDCiu+yxr00n/MrMhxdF431Hb44Asvda4nt9VX/2RUCjUvV3tZcS/0ZV1rNuMTt
         oiuYIFm1semANnA6tqR4zYOt44A3OZe1RacxdHQTpth9UjyA7yRjlRNCMqhpmhxfMXCK
         ag/5cRt/VM9GvymeAa0yGRZZAcR2ZqewF3rttQ5/aIlKxd6ttOFgfimGKDW7cdj3kxxz
         P3b3e4XpSDTbrS37EbYBHJuaSxpOZ0CcH1VsG0mZUNCG6X3xKgF+0nttAps1K7JElxY1
         eWURgMn/wNL1eTb/IPpuBKWk5Bi7DO6VIcXd3WsOKKI6H0Y6iAuOPlZmIIIeRuYBDK2S
         dwSw==
X-Received: by 10.60.51.102 with SMTP id j6mr75854933oeo.6.1389116542108; Tue,
 07 Jan 2014 09:42:22 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 09:42:02 -0800 (PST)
In-Reply-To: <xmqqlhyrg49c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240116>

2014/1/7 Junio C Hamano <gitster@pobox.com>:
> It is not about preference but what we want to convey to the
> readers.  When you start the sentence with "Oh, it already works
> correctly", the readers need to see this sentence finished: "It
> already works, it is handled correctly, but we change the code
> nevertheless because ...?".
>
> Here is my attempt to fill that "because ..." part:
>
>         Subject: git-submodule.sh: 'checkout' is a valid update mode
>
>         'checkout' is documented as one of the valid values for
>         'submodule.<name>.update' variable, and in a repository with
>         the variable set to 'checkout', "git submodule update"
>         command do update using the 'checkout' mode.
>
>         However, it has been an accident that the implementation
>         works this way; any unknown value would trigger the same
>         codepath and update using the 'checkout' mode.
>
>         Tighten the codepath and explicitly list 'checkout' as one
>         of the known update modes, and error out when an unknown
>         update mode is used.
>
>         Also, teach the codepath that initializes the configuration
>         variable from in-tree .gitmodules that 'checkout' is one of
>         the valid values---the code since ac1fbbda (submodule: do
>         not copy unknown update mode from .gitmodules, 2013-12-02)
>         used to treat the value 'checkout' as unknown and mapped it
>         to 'none', which made little sense.
>

I wouldn't be able to explain the change better than your description.
Also, I was under the improper assumption that the change was obvious.
Thank you very much for the amended patch description.

Cheers,
Francesco
