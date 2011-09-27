From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Tue, 27 Sep 2011 05:35:33 +0530
Message-ID: <CAMK1S_gZFxtCwUnzRU3PocB9LcewZ-f5RyraCebJdaBASODaPg@mail.gmail.com>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
	<CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
	<20110925094822.GA1702@myhost>
	<CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
	<7vwrcuzy44.fsf@alter.siamese.dyndns.org>
	<CAMK1S_gR6U=OxzGsjTD8LbvZFS125=p1fQ8Af7aRD2XSsRur_Q@mail.gmail.com>
	<7voby6zwxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 02:05:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8LB5-00072P-2G
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 02:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab1I0AFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 20:05:35 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48522 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab1I0AFe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 20:05:34 -0400
Received: by vcbfk10 with SMTP id fk10so3254570vcb.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 17:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LYwn5/2WpgWXIz21lsGLD2QBCWPFOFySAXGFchy84Jw=;
        b=gTuYLDUCECLGEnypf+Rj0jv0utGeYo9WbUKhnV1BPvFmkF2p5782L07wRBwyCXYZo9
         gPfqsG8e7WwN3CnH7cJ0fjAYS7t0U/dj+qtOgQ2ZqXGtx1+szeg2cOvHUpwOFSOmoS9k
         w93ikroRI7Tntm3g+tx+6NtjXgm+iYkaqCE7U=
Received: by 10.52.93.178 with SMTP id cv18mr1900014vdb.134.1317081933777;
 Mon, 26 Sep 2011 17:05:33 -0700 (PDT)
Received: by 10.52.160.161 with HTTP; Mon, 26 Sep 2011 17:05:33 -0700 (PDT)
In-Reply-To: <7voby6zwxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182197>

On Tue, Sep 27, 2011 at 5:19 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>>> In that case (if "non-existent-ref" was indeed non-existent, and no=
t just
>>> pointing at a dangling commit), I would say the post anything hook =
should
>>> not be called for that ref. These hooks of course need to run if th=
ere
>>> are _other_ refs that were updated, though, to handle these _other_=
 refs,
>>> but I do not think they should be told about the no-op.
>>
>> Question is what happens if none of them existed. =C2=A0It's a diffe=
rence
>> between not calling the hook at all, versus calling it with no
>> arguments/empty stdin (as the case may be) -- which would you do?
>
> In case it was unclear, I was trying to say the hooks should not run =
with
> empty input.

I saw "should not be called for that ref" and I did get confused;
thanks for clarifying.

I perfectly fine with it for post-{update,receive}.  My interest is in
making sure the *update* hook runs, which (in an earlier email in the
thread) I explained why and you agreed it made sense.

Thanks,

--=20
Sitaram
