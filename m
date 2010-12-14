From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Can `add --patch` display the diff in my difftool instead of just
 printing it on the command line?
Date: Tue, 14 Dec 2010 16:22:27 -0600
Message-ID: <AANLkTimV3eQuLcUcoTHWOeXCNoGoboSggkVfoxvVcx8X@mail.gmail.com>
References: <AANLkTi=_VyUAL+qjWLEcThX-zC5n0v0WB-W7hTSZn0ae@mail.gmail.com>
	<20101214213810.GB2216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdGT-0003Zy-SK
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272Ab0LNWW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 17:22:29 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48910 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758105Ab0LNWW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 17:22:28 -0500
Received: by qyk12 with SMTP id 12so1283535qyk.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 14:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TZPhYtDBMOSNXiTlF4iFUUdw0GuC7znxYvGRUe3sbyo=;
        b=UBT2OFdz+aNmfM7mIXE09rLst3U41Ny5cAwgfGA9A/rJNoKVsZxGtaK6hFxCxi29r7
         73TF93OyCYFaW3sUAhSaVblxXnl9KzYZGGM5Y5opmNDB+Z3wxNmprq1D2qGMgAK0CWyU
         peTs9wHZLygVfeQck1ChYxSU4+A++AyTBx2rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bnNr6SGv8U1ei0MSyhMxvtEz4HM6EOtEmMOyv+tBWIDRX0pcO2t8m1TxE8opw5CIXo
         zaGF297UpGHL9DOLlwn7FEwlPkVki/DOrO7dAvaP7rFSPX/yBTaCtdps0kafsVC9RvHW
         wlsAJf3GBSzD2bU20S9ph9UYygz3ikpgG4X/M=
Received: by 10.229.182.134 with SMTP id cc6mr202089qcb.217.1292365347825;
 Tue, 14 Dec 2010 14:22:27 -0800 (PST)
Received: by 10.220.191.66 with HTTP; Tue, 14 Dec 2010 14:22:27 -0800 (PST)
In-Reply-To: <20101214213810.GB2216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163697>

On Tue, Dec 14, 2010 at 3:38 PM, Jeff King <peff@peff.net> wrote:
> You can't do this with "git add -p" now, but I suspect the patch woul=
d
> be relatively straightforward. See patch_update_file in
> git-add--interactive.perl. You just need to replace:
>
> =A0for (@{$head->{DISPLAY}}) {
> =A0 =A0print;
> =A0}
>
> with code to dump the diff in @{$head->{TEXT}} either to stdin of you=
r
> display program or to a tempfile that your program operates on.
> Conditional on having some config option to specify your program, of
> course.

That's exactly what I want, thanks. Seems like there should be a flag
/ config that tells `add --interactive` to render the diffs through a
difftool. I know several Git users who always use their difftools for
large, complex patches, which are exactly the kind of patches you'd
manage with --interactive / --patch. Hope one of you Git bigwigs takes
the time to add that feature :-)

=2ED
