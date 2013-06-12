From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 09/31] git-remote-mediawiki: Change the behaviour of a split
Date: Tue, 11 Jun 2013 21:54:17 -0400
Message-ID: <CAPig+cQBDSvGswgspsipeEAVWSXr9YxcqwQj_ne5kRm+eG9vUg@mail.gmail.com>
References: <1370989102-24942-1-git-send-email-celestin.matte@ensimag.fr>
	<1370989102-24942-10-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 03:54:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmaGn-0000K3-6N
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 03:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757Ab3FLByT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 21:54:19 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42080 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab3FLByT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 21:54:19 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so6074184lbi.19
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 18:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2+TkR9MpsXi3mxpMKm31Cr75FPmvr7jRoZY5EihtYAU=;
        b=g2eZhDfVVQgOLMKVB8sfYTK/hBuEuHVoHc4rXFTKmRgwDbNPYc5q9PJl8mgDTO+eM7
         XGO/DcwxtolRUusPbEhURd/bokff0fH4d8jOFWCpyyVw4RpWDPWuyOcJvT1GH5bTO5JY
         hHOk1AYZZLybAxAL+Go2VMAkdvvVXrD0UV+ZIXG4u6COyPFmTCPfTUy80GG7l/OA2rT+
         eIbW2xdhaZYHNKRyA3a+Vv6En/zfNyemHAoYRFPGNnxgJNvngxxJXvMX7XlvrHX2Sihh
         YfJvmzkmw5H7LqTo5cxJgS6k1SEKn3KyNk38Nehm9ME6CRdyNlRNuaYJJ5G7pawz+EUq
         zF7w==
X-Received: by 10.112.89.226 with SMTP id br2mr9850408lbb.12.1371002057597;
 Tue, 11 Jun 2013 18:54:17 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Tue, 11 Jun 2013 18:54:17 -0700 (PDT)
In-Reply-To: <1370989102-24942-10-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: 8rmgheS6cgoQt8PzCVNbWoCEbVQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227585>

On Tue, Jun 11, 2013 at 6:18 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> A "split ' '" is turned into a "split / /", which changes its behavio=
ur: the
> old method matched a run of whitespaces (/\s*/), while the new one wi=
ll match a
> single whitespace, which is what we want here. Indeed, in other conte=
xts,

I missed this nit in the last round. '/ /' will match a exactly one
space (not an arbitrary whitespace character), so this really should
be: s/single whitespace/single space/

> changing split(' ') to split(/ /) could potentially be a regression, =
however,
> here, when parsing the output of "rev-list --parents", whose output S=
HA-1's are
> each separated by a single space, splitting on a single space is perf=
ectly
> correct.
>
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
