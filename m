From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] commit -s: allow "(cherry picked " lines in sign-off section
Date: Wed, 17 Nov 2010 01:23:44 -0500
Message-ID: <AANLkTinpEVuPVhDDfEcrvHa4T5BfL+X5w4y=cJkho4d+@mail.gmail.com>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
 <20101116193018.GA31036@sigill.intra.peff.net> <20101116202556.GA27390@burratino>
 <20101116204027.GB27390@burratino> <7vlj4shoej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org,
	Martin Svensson <martin.k.svensson@netinsight.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 07:24:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIbRb-0003e8-KW
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 07:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933366Ab0KQGYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 01:24:16 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40464 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824Ab0KQGYQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 01:24:16 -0500
Received: by iwn35 with SMTP id 35so1742639iwn.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 22:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=P8R4bDrN1keZyB14ykwizLsy6Bm/QfCqxY/qouhMH40=;
        b=lQGp0A4BJJWocbX2jrZMI3X0IdUmNpoDCvMmNibx7Ebe46PfUSVQ3eg20CaK37M+uH
         sG3zMb3gS7otlU66kVkNzAMHQeXSKMnv7WuVOFA1eSL/HIwljRqK8Jk8lbExFd07ryZk
         JJLGhVUNYb6ZgtS/GbMkhlfoMNfvIe5Y7fzWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tTSms2TYJbBTMAQSulhmJiNEBeIjYtrrNIEGhOpMS5rzUZyygNZCHCr9+XM0SLz01U
         xqL0WGgJxt9dbMUSDETcUgqZt/3XmZdvykFnfyPCESU48tkCvgidSXZP3uHcwoJAFP+L
         Xj3do+Fe+5GBrJ8+krTBGc06ahpBeLcWzMB9Q=
Received: by 10.231.33.71 with SMTP id g7mr6560425ibd.54.1289975055138; Tue,
 16 Nov 2010 22:24:15 -0800 (PST)
Received: by 10.231.161.21 with HTTP; Tue, 16 Nov 2010 22:23:44 -0800 (PST)
In-Reply-To: <7vlj4shoej.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161600>

On Tue, Nov 16, 2010 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I am not sure I agree with the reasoning of this patch, by the way. =C2=
=A0A
> cherry-pick is an event that breaks the life of the patch, so it may =
even
> be a sensible thing to do to express "the above sign-off chain shows =
who
> were involved in the original commit; I am cherry-picking it out of
> context, and these people do not have much to do with the result" wit=
h a
> blank line on both sides of the "cherry picked" line, like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A concise summary of the change
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A detailed description of the change, why =
it is needed, what
> =C2=A0 =C2=A0 =C2=A0 =C2=A0was broken and why applying this is the be=
st course of action.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Andrew Morton <akpm@linux-f=
oundation.org>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Linus Torvalds <torvalds@li=
nux-foundation.org>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(cherry picked from commit 9d8117e72bf453d=
d9d85e0cd322ce4a0f8bccbc0)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Back Porter <backporter@exa=
mple.com>

Or perhaps prefix them with Original-, inspired by email headers, and
which I think makes it even more clear that the sob lines don't apply
to the new commit.

 =C2=A0 =C2=A0 =C2=A0 =C2=A0Original-Signed-off-by: Andrew Morton <akpm=
@linux-foundation.org>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Original-Signed-off-by: Linus Torvalds <tor=
valds@linux-foundation.org>
        Cherry-picked-from: 9d8117e72bf453dd9d85e0cd322ce4a0f8bccbc0
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Back Porter <backporter@exam=
ple.com>

j.
