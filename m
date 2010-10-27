From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests with TAP
Date: Wed, 27 Oct 2010 13:00:15 +0200
Message-ID: <AANLkTimH=fbRAdz-F-V-9WTKzAyVvpzRHC06e+94a2wJ@mail.gmail.com>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
	<20101014172301.GA2770@sigill.intra.peff.net>
	<7vmxq0ebe9.fsf@alter.siamese.dyndns.org>
	<20101027045709.GA11250@idm.gtisc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 27 13:00:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB3kE-00088I-Dt
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 13:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760917Ab0J0LAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 07:00:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61306 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab0J0LAR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 07:00:17 -0400
Received: by bwz11 with SMTP id 11so404555bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pBOCLaunGLjUiQjx2B+OA+k2PrQGS47Y2qfdgBWNe8o=;
        b=GNxUU3arRr4bXhnW8mryyl6KZBCNfME7cb9t7ku6MJu/NqaYU2dD8JttTZbVtOYnZb
         OIsiRIu2xfmsjPLi0ZVHZG+2aqCKcq5lMDbCz3VbYEkB4NKIShkRUtz98+gjGkfysmxT
         /E5fPEtc3BE0FGiJGIZF5cGPli+Ffx4/KTP3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aTxGxbtP4ipk2p1g7CuMq1wQfinVMPzdWXREt/vDj1vxiDHYGNhBUIyZatlLlpehvc
         bzkYaDcwgkK0yFX3JkuWVUWCfpGqu8LEip39Jq+FkfLMe81jUFRqlmeRQM9cFvyyPVJ5
         leH5k/JjnJygu2bv89FIunydyKB/EXq3+uSgY=
Received: by 10.204.24.144 with SMTP id v16mr7300868bkb.137.1288177215908;
 Wed, 27 Oct 2010 04:00:15 -0700 (PDT)
Received: by 10.204.163.69 with HTTP; Wed, 27 Oct 2010 04:00:15 -0700 (PDT)
In-Reply-To: <20101027045709.GA11250@idm.gtisc.gatech.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160034>

On Wed, Oct 27, 2010 at 06:57, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 26, 2010 at 05:18:22PM -0700, Junio C Hamano wrote:
>
>> > like -j16, but it's a pain to construct the command line (especial=
ly as
>> > I use --root in GIT_TEST_OPTS to get a significant speedup).
>> [..]
>> I kind of like this. =C2=A0Perhaps with something like this squashed=
 in?
>
> Yeah, looks good to me. I guess you can steal the commit message and
> authorship from Michael's original.
>
> =C3=86var mentioned something about t/harness, which I honestly have =
no idea
> about (I don't have the right perl modules installed to run it). But
> maybe that could be an alternate DEFAULT_TEST_TARGET. I dunno.

The non-standard module there is only needed for the smoke testing.

If we used t/harness for running "make test" that code could be
modified to run anywhere prove itself does.

Anyway, if there's a patch now to invoke prove(1) let's use that. We
can change it to t/harness later if that makes sense.
