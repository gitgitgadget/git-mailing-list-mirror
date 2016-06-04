From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Fri, 3 Jun 2016 19:03:59 -0700
Message-ID: <CAPc5daWJ1v8EU89UN2HPK8=U17vz4LiANA9FyCvH5as7Hb1bTQ@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org> <20160530232142.21098-2-e@80x24.org>
 <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
 <20160531074506.GA8911@dcvr.yhbt.net> <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
 <20160531182932.GA27021@dcvr.yhbt.net> <20160602075125.GA19551@dcvr.yhbt.net>
 <CAPig+cTLVXJBn00aco0vC9oFvZuchTgtNXtGGjpLPx1LwRZz4Q@mail.gmail.com>
 <xmqqlh2loq6p.fsf@gitster.mtv.corp.google.com> <CAPig+cQXA3mgYC3rCTx2h93rB6djdKvYJ+oCXUP24-xk2PqW=Q@mail.gmail.com>
 <xmqqzir1zvo2.fsf@gitster.mtv.corp.google.com> <CAPig+cTQkEb6K95aeJ9vNyJ=S+8x+JnCQAYSEzydXKzbq-+Yyg@mail.gmail.com>
 <CAPig+cQ7y7J02+PVtdJywGEudOGXsy1jgadvVwBg5creiUv6zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <e@80x24.org>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 04:04:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b90ws-000255-0o
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 04:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbcFDCEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 22:04:21 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35884 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbcFDCET (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 22:04:19 -0400
Received: by mail-yw0-f181.google.com with SMTP id x189so96549637ywe.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 19:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3RxK0aZyzNfpjfdwbk6FgPNa5E4P3bgg/USDjzaeF8E=;
        b=q87SfdbrjuOKCDC6dFzrBJNakDzna+7tfs6v1zFZ9SP/SxCW9Lzq/BJ0BgWfSy/NB1
         0NoesaPYLrcDm3JTVL4OG0uBYWUaXhN7S3pIlx1HLgS0VZaUgf9J1XFMlm33evFuLDuz
         ozYxy/0jhHjtnGB0vS34Z1dO56qoJ3o6tmanxmqSrqqIN4kENCGP+AnUmakNwy2fpK+j
         nVqVPpuReC6k1WkoeIwoEXUrnz1Ig93NAN2Oc8PbGelGoFe8CJB0/LwBeQ6mH2P/dsSN
         aU1jjWbAaSN/fe7HJPhI+jYV6/zmewu1cDwbMKxiftdAWx/j9MWNS9A8wHYZTsQEgH6h
         aHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3RxK0aZyzNfpjfdwbk6FgPNa5E4P3bgg/USDjzaeF8E=;
        b=XQ8zDHkZ22UheX3QMuAbdQjE/Qa53F/QaFTcVmJ4sb1oj/FLft0GydPs6kPAZRHM7S
         7K+4ipGmpx9HR4mJ9OQHfGtNKnQr0FDuPRSOR3YYaUIKN6hQd3PmRwllF8752vQzJWqy
         AIXgm6ZK+RXFzrQP2kB4iqkrNisChgS9mTlVV7ac21QJkVkdYNzvWTax3d+ssdAqwyFg
         IFRQEsMAYsXvn+Qmy1EXSyC+X65MMmKNWQDISW6+cw6YTskV2kcCUHQBrefNmk/WTu1L
         KprN/ELwMT/DVtb4TII6AILy/6Yc7mYR74Y2cSuczSsmv1sR/2837yyiXP0P0KHczsdF
         DNWA==
X-Gm-Message-State: ALyK8tKuQ3vEJ3rVDal2ee2kC9OJvZjax9Vp7iBiAM4EgEmhfCqjj75GFq8ObSw7uQLisGLPD3/U159Qu5sJuw==
X-Received: by 10.129.80.139 with SMTP id e133mr4736824ywb.197.1465005858642;
 Fri, 03 Jun 2016 19:04:18 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Fri, 3 Jun 2016 19:03:59 -0700 (PDT)
In-Reply-To: <CAPig+cQ7y7J02+PVtdJywGEudOGXsy1jgadvVwBg5creiUv6zA@mail.gmail.com>
X-Google-Sender-Auth: reB2Miq2g1UMhl025MOdluRCG3o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296438>

On Fri, Jun 3, 2016 at 5:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> My only minor reservation is that it your concise version is still
> subtle with regard to not taking 'linelen' into account. At first
> glance, it looks like a bug that it doesn't consider the logical
> end-of-line, and someone reading the code has to put in extra effort
> to convince himself that the code works as intended.
>
> For that reason, I have a bit of a preference for a version of
> is_mboxrd_from() which does take 'linelen' into account explicitly.

That certainly is true. You could check that the end result did not consume
more than linelen after the single-liner computes its result, but I am not sure
under what condition that check would trigger. Even though we may hold the
entire e-mail file without NUL-terminating each line, we have a NUL-termination
at the end of the file, no?
