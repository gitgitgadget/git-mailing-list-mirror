From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git 
	push --porcelain
Date: Wed, 10 Feb 2010 18:43:39 +0800
Message-ID: <be6fef0d1002100243l52d1cbd4x5ab01283d54c5e9e@mail.gmail.com>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
	 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
	 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
	 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
	 <20100208213256.GA470@coredump.intra.peff.net>
	 <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
	 <20100210053937.GF28526@coredump.intra.peff.net>
	 <20100210055529.GA1566@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 11:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfA3I-0007eG-HJ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 11:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab0BJKnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 05:43:41 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:62685 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab0BJKnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 05:43:40 -0500
Received: by iwn39 with SMTP id 39so9631459iwn.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 02:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s/T8UtE0WFGTqHdbb1PY1n9R4kHymNqx9qQWXfMTc84=;
        b=IvjnpyDku0xAlON9Qp2VdBQNwjCkLO8FdCTCxedRHyTsfkf0gzRHDJB0fTkks9OAVq
         Bf+xT4krgn8eWVWo43ZEXXPBlSw9tdp7ft1BvumO+IkvFX9urdj8dDCYjaQ62NFma8Tq
         /iuD9udNjR/T8Z5HMYNr2VkrT/NLn+e+2C6p0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gE2cxg7xkVudpJQSq/VXTc3seoyiv2dspMyHJLoiDTOeqJRojgCH5RNDd7uDuNl5de
         tpL9nAj12WTilyEBtUArkY6bcOIXBnWrNNwclkT4XciBTCvbZ5k8bxwjgo33tIt31Dh3
         x1N8OKRButXdI0RinJOSZSilsz/4SSYrLKONA=
Received: by 10.231.167.204 with SMTP id r12mr82379iby.31.1265798619149; Wed, 
	10 Feb 2010 02:43:39 -0800 (PST)
In-Reply-To: <20100210055529.GA1566@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139503>

Hi,

On Wed, Feb 10, 2010 at 1:55 PM, Larry D'Anna <larry@elder-gods.org> wr=
ote:
> * Jeff King (peff@peff.net) [100210 00:41]:
>> I had initially endorsed it, but now I am having second thoughts.
>> Especially if the "usual" calling convention is to redirect stderr a=
s
>> above, then we are probably missing out on any useful error messages
>> that accompany a failure return, anyway. =A0So maybe the sane thing =
to do
>> is to leave the exit code alone, and include a --porcelain output li=
ne
>> that either says "Everything was OK, see individual ref status" or "=
We
>> couldn't even talk to the other side". Then the status code is
>> irrelevant, and stdout contains all of the useful information (and i=
f
>> you don't get an error or OK message, you know there was some
>> serious error like a broken git installation).
>
> That serves my purposes as well as the exit code would. =A0Is this th=
e consensus?

does this mean the ugly return status mangling patch (git-push: make
git push --dry-run --porcelain exit with status 0 even if updates will
be rejected) would be dropped? If so, I'm all for it. =3Dp

--=20
Cheers,
Ray Chuan
