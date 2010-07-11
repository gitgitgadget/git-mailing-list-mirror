From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v6] Add infrastructure for translating Git with gettext
Date: Sun, 11 Jul 2010 07:22:02 +0000
Message-ID: <AANLkTikOAzaAzAjst0tAWAuUwyEnKbdafF0qWtXANBnI@mail.gmail.com>
References: <1278794867-32438-1-git-send-email-avarab@gmail.com>
	<AANLkTilHE02RUBAnyZReB9zRkmQ2oJXRyspUlx3I9KZH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 09:22:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXqrb-0001r2-CV
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 09:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab0GKHWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 03:22:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56477 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab0GKHWE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jul 2010 03:22:04 -0400
Received: by iwn7 with SMTP id 7so3627683iwn.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3yG/AHuBGfmKGB0oTHObvwablIuUqQuG0IGV6PGd7JE=;
        b=T1SLqfeUo7EGcyhBL91N/EH9VkqaQH0GIMnbcYVVGLY/XAWsdYJnUYKoocAxuh1qEQ
         ykHj6EeF9Iq8o2k7A36+NAiwRB4CxGIwUHLNrlO0Qq49EpdbGAQeUGoghL2Z7JJ0ph8C
         KgXm5ZNL/ReNsSv+jCwECtdozyNcshNFbQsME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SKL49DPgp+l6RY6tfQNjjzZBHZWAV0cxM5xgafqT7KkFYR0cjG+2rcmymTC0aevlAe
         wut+MxfiJolSfkZwlSzrX59LP2KgPvS4UDwoF0/Hwfywf8T5Vsh8WBzxevU63z2kwCFW
         hwVWYsSygBpoLH8jsgoF6JgmfSGfhrtxLpV5s=
Received: by 10.231.145.1 with SMTP id b1mr11983525ibv.69.1278832922256; Sun, 
	11 Jul 2010 00:22:02 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 11 Jul 2010 00:22:02 -0700 (PDT)
In-Reply-To: <AANLkTilHE02RUBAnyZReB9zRkmQ2oJXRyspUlx3I9KZH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150766>

On Sun, Jul 11, 2010 at 01:55, Nazri Ramliy <ayiehere@gmail.com> wrote:
> On Sun, Jul 11, 2010 at 4:47 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> For Shell and Perl programs we rely on the git message
>> catalog not being available. That's a reasonable assumption since th=
en
>> the message catalog won't be installed on the system during make
>> install.
>
> Would a "stale" message catalog (from a previous installation of git
> with gettext
> enabled, via make install) be deleted upon new installation (via make
> install) with
> NO_GETTEXT=3DYesPlease?

No. Just like we don't delete anything else that may exist on the
system from a previous "make install". The patch assumes that this is
the sort of thing package managers are for.

I didn't think it was worth it to guard against this case (by
e.g. cleaning out Shell/Perl support at make time).
