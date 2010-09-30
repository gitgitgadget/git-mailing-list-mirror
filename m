From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 00/16] git-send-email cleanups
Date: Thu, 30 Sep 2010 10:30:42 -0400
Message-ID: <AANLkTimi-8jotJwubC5FpNx0NfVB0zQ_+dKaeEW0y4hN@mail.gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 16:31:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1KAJ-0003Ve-VX
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 16:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435Ab0I3ObP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 10:31:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50234 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0I3ObO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 10:31:14 -0400
Received: by bwz11 with SMTP id 11so1402245bwz.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XCr9PDbu7aRexMge5Y1COP6+IIvgsbSzONGsxIp1uUs=;
        b=rFzR44kNgN89qwo82rrOyYWr/iZqhvcNBPGCVsBInanj8wwsyHqMNincidEsYPd7vp
         wOBj0Jaj3bhboLlSwi6v4LbIcto8Fm7oQtclIylAfKI1UHZ1TlbaLIrCFGTiAIiTe0bD
         yFCRErsehno6JOgxHuNn5tT+ZVrFesIbm/9jQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BsUhQ6dfBnvUsUGalBQt0PrNKxV0jCMndNxGaJnmsYrYBXvpTRMB9kRfqZyOdv5j5x
         T+QpkLL9jEx0af3WQpK4ugvMJk2z/+/vHPifzgCHRdW2Y0ACOgQQq8C4bgZpxwQ9j51E
         56+w7d9eXPsHLrpKN8Ceb9153op2uz5m5f310=
Received: by 10.204.123.136 with SMTP id p8mr2681262bkr.148.1285857073311;
 Thu, 30 Sep 2010 07:31:13 -0700 (PDT)
Received: by 10.220.122.6 with HTTP; Thu, 30 Sep 2010 07:30:42 -0700 (PDT)
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157673>

On Thu, Sep 30, 2010 at 9:42 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> As threatened here's a series that cleans up some of the glaring wart=
s
> in git-send-email.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (16):
> =C2=A0send-email: use lexical filehandle for opendir
> =C2=A0send-email: use lexical filehandles for $compose
> =C2=A0send-email: use lexical filehandles during sending
> =C2=A0send-email: get_patch_subject doesn't need a prototype
> =C2=A0send-email: file_declares_8bit_cte doesn't need a prototype
> =C2=A0send-email: unique_email_list doesn't need a prototype
> =C2=A0send-email: cleanup_compose_files doesn't need a prototype
> =C2=A0send-email: use \E***\Q instead of \*\*\*
> =C2=A0send-email: sanitize_address use $foo, not "$foo"
> =C2=A0send-email: sanitize_address use qq["foo"], not "\"foo\""
> =C2=A0send-email: use (?:) instead of () if no =C2=A0match variables =
are needed
> =C2=A0send-email: is_rfc2047_quoted use qr// regexes
> =C2=A0send-email: extract_valid_address use qr// regexes and /o
> =C2=A0send-email: send_message die on $!, not $?
> =C2=A0send-email: make_message_id use "require" instead of "use"
> =C2=A0send-email: use Perl idioms in while loop
>
> =C2=A0git-send-email.perl =C2=A0 | =C2=A0 80 +++++++++++++++++++++++-=
------------------------
> =C2=A0t/t9001-send-email.sh | =C2=A0 =C2=A02 +-
> =C2=A02 files changed, 39 insertions(+), 43 deletions(-)

These all look pretty uncontroversial and sane by me, though I don't
think you touched any of the lines I contributed to git-send-email. If
anything, perhaps this series is a bit too granular -- I might combine
the commits that get rid of the function prototypes into one for
example. Otherwise, thanks for the cleanup.

Acked-by: Jay Soffian <jaysoffian@gmail.com>

j.
