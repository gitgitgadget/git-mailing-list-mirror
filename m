From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: nesting refs (Re: [1.8.0] Provide proper remote ref namespaces)
Date: Sat, 5 Feb 2011 11:30:25 +0700
Message-ID: <AANLkTin+VLTf62NHSdAb61qEckrsLMg+s-hnWHb0HLna@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 05:31:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlZnj-00068r-JS
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 05:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab1BEEa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 23:30:57 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37958 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab1BEEa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 23:30:56 -0500
Received: by gxk9 with SMTP id 9so1178003gxk.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 20:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=+woVMVDXcf94dIxsN11uoAaIfQ+dmQbm4PKDPt1UwBQ=;
        b=bkmP6UCqyvjoB3x3Ey+IqDG2psCsRU2/FVZD9Se3K5MViVOLAgYEbNXgKh2rExKwDS
         xbq8rTYsz2UWsUDvpWvduLrzOoB/T0yy90YP4NMkkNRTP02mtCRdjy79UmQVcDdyJzwe
         9wVdjvsiThcKtxxVIEr/VJr0m+sSL9K91YrWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=UOAjShTiuFKyk6yLxA4qMY65ZkSpg0JdOrTnU3K5G3GiwHjLk2G7x35nTJhVNfH3Ed
         Rdudbff/FqwWVlA5WhxLde6819axRcV7zwvlfjTTzh1fRTUi3Yw2I1hXnLllLczrBvVV
         73GQr5q5jI1JHsxtngsN8M5fM1wetuYHYldQY=
Received: by 10.91.55.8 with SMTP id h8mr16264906agk.145.1296880256125; Fri,
 04 Feb 2011 20:30:56 -0800 (PST)
Received: by 10.151.145.12 with HTTP; Fri, 4 Feb 2011 20:30:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166076>

On Sat, Feb 5, 2011 at 5:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> While you are talking about drastic reorganization (and rewriting the ref
> code to support it), another possible Sub-proposal we may want to consider
> is to allow "next" and "next/foo" at the same time.

Oh yeah.. how about "next/.ref" and "next/foo/.ref"? Ref search code
can be modified to check both "next" and "next/.ref" when "next" is
requested. Old git basically won't work with new ref style, so there's
not much compatibility issue.

We can also add "next/.summary" to save a brief description of a ref.
But then it would be lost in packed-refs, hm..
-- 
Duy
