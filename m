From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 2/4] git-credential-store: support XDG_CONFIG_HOME
Date: Tue, 10 Mar 2015 21:43:03 +0800
Message-ID: <CACRoPnRoY=c5NukCCS0OPMaL1TvqSuSL036-mK+4sae_6VgrVA@mail.gmail.com>
References: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
	<1425801532-8483-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 14:43:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVKRD-00074Y-F0
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 14:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbbCJNnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 09:43:07 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:44996 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbbCJNnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 09:43:05 -0400
Received: by labgm9 with SMTP id gm9so1719282lab.11
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VxjyTtaAjF0lNuk6SEEEsKnMOaQV+/Z6Vf/6QKxC1eg=;
        b=kf8aHL/Ug4pUxuBPaI3F0D3io1uchFS1/tPEwgx8phiWGFWBzvonHaXssOFm0KuOhx
         CPwzCK/CcORRGA3GA2mnZ/4KHnJYJh3obAwXFKqoMpp77USWA6c2WqGw07ZRvLlRwNKI
         eeRxz2TPhlX8XV3FwNgsZPf8/R3OYcQcvSyrTLQJDdpXeBiVlAH+8L1yLZu/WrAahp5u
         xNvXHC88knAXBw8JRvpVdxhW4sQ9Kc/SdHRKDTparni/yG6PqSEe2zAPKmaQsm2lXprd
         PSmXc/3QFR5kVgJTUg4p22fmHgGzsgp+BO+hNSN5t1m8yMC0AX3Fx3wp785bKJpuwo9h
         DaOg==
X-Received: by 10.152.19.9 with SMTP id a9mr30922503lae.80.1425994983639; Tue,
 10 Mar 2015 06:43:03 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Tue, 10 Mar 2015 06:43:03 -0700 (PDT)
In-Reply-To: <1425801532-8483-3-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265234>

On Sun, Mar 8, 2015 at 3:58 PM, Paul Tan <pyokagan@gmail.com> wrote:
>                 remove_credential(&fns, &c);
>         else if (!strcmp(op, "store"))
> -               store_credential(&fns, &c, fns.nr - 1);
> +               store_credential(&fns, &c, 0);
>         else
>                 ; /* Ignore unknown operation. */

Whoops, seems like I squashed some commits in the wrong order (but
there is no functional difference). Will re-roll the patch series.

Also, store_credential() should take a string as the default filename
instead of an index into the filename string_list for extra API
flexibility.

Thanks.
