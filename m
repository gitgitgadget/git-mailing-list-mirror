From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 01/44] wrapper: implement xopen()
Date: Wed, 1 Jul 2015 14:05:39 +0800
Message-ID: <CACRoPnSJGhMHX6+4uEGZgN1xYfpY_GeKmux0N3vAkuaQ0rm74A@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-2-git-send-email-pyokagan@gmail.com>
	<5590CE10.3020104@web.de>
	<xmqqr3oubfhz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 08:06:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9v-0004e5-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbbGAGFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2015 02:05:53 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:32928 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbbGAGFk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2015 02:05:40 -0400
Received: by lbcui10 with SMTP id ui10so6331666lbc.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CjLQZ+XcW2U74RtgoR1U64dbMELOSe68/1ZAEjmQ/ew=;
        b=UTDGjgWXWqJC2lbYuO/5SfNWbOebjXEAMFvsWMGNNlyocXYSZAsmEXDiGWWagFQELo
         f/w0tkuYw54PTS7+++F6zxE5LXzdEMBz3eqFKoB8y3FMMLkBYwcv6lMGBSpXe73cV4+C
         DfTP2xiDLE9JzWoxVUy+BCSAks63kjdgDJ4yh+C8+U55PCs+ktZtHuh3Uqu+tbwCeNQB
         szp31XndDvR1V/28rQSVquv7qDDMVhca8WfgwH94Dfx/AtN3rfyY9ToOEI9YMolvy5II
         3o4MS9DuPbDxFNFB+ZCj8YXqUJRcoessPNK4x6hPPJ/FwJQrsHFcJd/rzmWoAocTEUk3
         ny5w==
X-Received: by 10.152.87.13 with SMTP id t13mr23571039laz.66.1435730739084;
 Tue, 30 Jun 2015 23:05:39 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 30 Jun 2015 23:05:39 -0700 (PDT)
In-Reply-To: <xmqqr3oubfhz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273131>

On Tue, Jun 30, 2015 at 1:18 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>> 2 remarks:
>> - I don't know if and why we need the assert() here (but don't know =
if
>> we have a strategie in Git for assert())
>
> There is no bright-line rules, but I think it is sensible to remove
> this.  Nobody sane would throw a NULL at open(2) and xopen() is
> supposed to imitate that interface.  We do protect ourselves from
> careless use of our own API, but no need to clutter the code with
> overly zealous check against insane code, I would say.

Ah, okay. Will remove these assert()s.

Regards,
Paul
