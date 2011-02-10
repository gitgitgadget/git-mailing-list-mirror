From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Thu, 10 Feb 2011 09:24:55 +0700
Message-ID: <AANLkTi=dmqRQqBD2HZfv2x-kxaqrxvSx3r62d09KMP1k@mail.gmail.com>
References: <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr> <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net> <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <20110207195035.GA13461@sigill.intra.peff.net> <20110208100518.GA9505@neumann>
 <20110209210312.GB2083@sigill.intra.peff.net> <7vipwsomq8.fsf@alter.siamese.dyndns.org>
 <20110209234621.GA12575@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 10 03:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnMEJ-0006U1-Nc
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 03:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1BJCZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 21:25:30 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34035 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab1BJCZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 21:25:27 -0500
Received: by wwa36 with SMTP id 36so911229wwa.1
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 18:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=n/qkcQZ5he8XQpkl4EMNZ0UjpwCUGCbMWyHo1XEYi2Q=;
        b=hc56m3rJqQw7tIbez5+E9BOMYGucRJm0n4+MCSBEEvor/wjEY+IPblg9dGsRaS9U+e
         4/gMGC6LL0N8z9tagPSN816gvz+wm7LfzlIIZ1sK+3xAN1EsLUP2f8VMsykr3vrpcxBY
         aaxkp/M49BxbtrHhZqcKJAB2dd2FmYjPv3f5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vcvI86+OJedAnRzctebSjaCfTpBXUIWbuU7j1gZfg7rM2/wdkZkEu2d4Qrr5rcNZpf
         y6sZs85wr+4phk5vSTMc2AlNDpSTwFA01g9PYU0jSRpInurBhduZMEBmFJnTp6CySSta
         tEGUKdlzhxKvtGbPhSEPPsFiwiAI4ab0XmMrE=
Received: by 10.227.127.132 with SMTP id g4mr586202wbs.169.1297304725959; Wed,
 09 Feb 2011 18:25:25 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 9 Feb 2011 18:24:55 -0800 (PST)
In-Reply-To: <20110209234621.GA12575@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166464>

On Thu, Feb 10, 2011 at 6:46 AM, Jeff King <peff@peff.net> wrote:
> Assuming we move from relative to full-tree, I think the possible thi=
ngs
> to move are:
>
> =C2=A0add -u/-A
> =C2=A0archive
> =C2=A0grep
> =C2=A0clean
> =C2=A0ls-files/ls-tree
>
> I don't think it's worth moving ls-files/ls-tree. They're plumbing th=
at
> people don't use frequently. So the cost of moving them is high (beca=
use
> we are breaking something meant to be scriptable) and the benefit is =
low
> (because users don't type them a lot).

No we should not, but we should add --full-tree to
ls-files/ls-tree/archive. I'd love "ls-files --full-tree
'*somefile*'".
--=20
Duy
