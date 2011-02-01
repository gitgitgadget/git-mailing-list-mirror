From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Unify "pathspec" semantics
Date: Tue, 1 Feb 2011 21:56:06 +0700
Message-ID: <AANLkTinQBQaL0zE+EYAADPBhroi71sgKAcprCjLy_SKB@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7voc6x57el.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:57:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHfE-00025C-CJ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319Ab1BAO4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 09:56:39 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62260 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab1BAO4i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 09:56:38 -0500
Received: by wyb28 with SMTP id 28so6767800wyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Ii3feHDa3B9z8NLUPs1noUO103lRlhBqBJ+hNppI0dc=;
        b=sA9zvA5qcQGgFCA7B3uiTt32ay9mZWSLxrzBaylRrZy/ii/CDbJ77SqkWx9oD0bu/8
         saHzoRef87lkQRwpNpoYvRChIrX4PofOUMKwIk7nHeFNeZjChpblGnPUkYnT8N1RWIRU
         a16e6dPB5JtxQgGzHYm4zh4bt7pcofRRA9Vbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DUDn34grWmBBvY9HTBSV7DX56zyW6Y2XAEEjmYOkcxaPYRNk/0EMonoUK3xDojM4cg
         pRisUjz67iR/92NZtTLBAeU15XXY/RSt8hEqhgInf1jzV82INKiiRj9Pps+8lDoG7viW
         eh81oxP2DtteDmOotOqwCBsGIR8B9T66nMRpA=
Received: by 10.216.169.71 with SMTP id m49mr7541762wel.4.1296572196812; Tue,
 01 Feb 2011 06:56:36 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 06:56:06 -0800 (PST)
In-Reply-To: <7voc6x57el.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165814>

On Tue, Feb 1, 2011 at 12:07 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Some projects may track a file whose name is asterisk (e.g. "foo/*") =
and
> output from "git log 'foo/*'" would look different. =C2=A0Before the =
change,
> only commits that touch that exact path would be shown, but after the
> change, any commit that touch a path underneath "foo/" directory will=
 be
> shown. =C2=A0This is a backward incompatible change.

Can we support quoting wildcards? I can imagine a file name such as
'***DO NOT DO IT***'. People who wish to match exactly that file would
have hard time ahead without a way to tell git those stars are
literal.

A prefix/special leading symbol or cmdline option to indicate the
given pathspec is literal is fine too (e.g "!literal:***hey***" or
--literal "***hey***"). In fact I can extend that to support negative
pathspecs.
--=20
Duy
