From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [RFC/PATCH 4/4] inexact rename detection eye candy
Date: Sat, 19 Feb 2011 11:29:33 -0500
Message-ID: <AANLkTi=s6FxnYVv3UinV4Q+4C_9dX9rCLQQoCFD7kG9S@mail.gmail.com>
References: <20110219101936.GB20577@sigill.intra.peff.net> <20110219102533.GD22508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 19 17:30:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqph5-0004su-0x
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 17:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab1BSQ36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 11:29:58 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61469 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1BSQ36 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 11:29:58 -0500
Received: by gyh20 with SMTP id 20so404214gyh.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jcx3UbyKseBTNk1gXClnLzk66SSCI1h0lObPjB9wBc4=;
        b=CdSlXjPZYnT/5/4sx61cp6PvM9TxT8mBrE2iTNGzMN+p8MDm6BMcbxHPJtavzIUEMA
         UW0yXtQwp2Rs6z4Cs1fycc0QsH9kbi5ny4mNZr+ifbCtmGklAS38iyfR3uXKYJFbpXmZ
         2ckwlbT8hjj6mXBW7fByuWQwVHiHpYymIRGZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=s21dOVQZV8qV0fCfmLmf/0NP53d+veJ6GHmVR9vdUI1ALoaSJGf7vnoMFL55q1KuCM
         J2dJA9Tsg3ermKDYh4XaBr6cqVdghxCmyAEsheMybAqV+h96Yq7vl6gOpEKg9atIyTbd
         4hngopqXygal6ILV/Vmk4LdMWXkA4IVEcShVA=
Received: by 10.90.87.9 with SMTP id k9mr2777386agb.194.1298132993099; Sat, 19
 Feb 2011 08:29:53 -0800 (PST)
Received: by 10.90.53.7 with HTTP; Sat, 19 Feb 2011 08:29:33 -0800 (PST)
In-Reply-To: <20110219102533.GD22508@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167300>

On Sat, Feb 19, 2011 at 5:25 AM, Jeff King <peff@peff.net> wrote:
> During a merge, we might spend many seconds doing inexact
> rename detection. It's nice to let the user know that
> something is actually happening.

Given that we're doing costly work, could the results of rename
matching be recorded in a .git/MERGE_RENAMES file?

If that file's available, the simple merge-helper script I've
described is possible...

git commit would have to unlink it on successful commit...

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
