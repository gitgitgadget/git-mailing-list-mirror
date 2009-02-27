From: Deskin Miller <deskinm@gmail.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Thu, 26 Feb 2009 23:27:05 -0500
Message-ID: <86d4c5e00902262027y13b19eb7nf89a45e83b986801@mail.gmail.com>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
	 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
	 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
	 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 05:28:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcuKy-0000lZ-Ub
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 05:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbZB0E1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 23:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbZB0E1J
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 23:27:09 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:52248 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbZB0E1I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 23:27:08 -0500
Received: by gxk22 with SMTP id 22so2184644gxk.13
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 20:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MYAe0ngKS6XUCDUeCanJbO/iYVddqcax9ftuTvjNH+E=;
        b=YazOHN1xdhU6p5CcvX9ZoqdTgLA2ApgmbWKTLO3C7bDPba+8RMyAEWq4QjQEPpV6vk
         9B7MdZl40fRzx1e312Rkzx5h8pVy3yphO3WGLK7lRNGCA5F+Ca/EE2H1/JhxG4EQyCty
         g0h8X888pP9+7NwvqIe8DXv901MM1zQ/5gzn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h5n+3YORlldWdQLxAyBdwDwJ9qjU/CHDmyXSS8biLa5flTJt2ulzVAcVHfG//wOrYq
         M5+TnMT6rYbI6RNcwLi+5IGDGUBrc3YrGez6BQfM5QtFaXmS9bj9kPJJPnF8Y/wTq9xF
         jvESUPZ1JddB8yaE2TLUHWlhlbN1yv4MPjyOA=
Received: by 10.151.112.12 with SMTP id p12mr3191745ybm.147.1235708825846; 
	Thu, 26 Feb 2009 20:27:05 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111629>

On Sat, Feb 14, 2009 at 17:52, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I scanned command-list.txt briefly, and could verify (by testing rath=
er
> than code inspection) that
>
> - bundle works as expected (thanks to dwim_ref()),
>
> - fast-export (like bundle, dwim_ref() makes it work),
>
> - so does filter-branch, thanks to rev-parse --symbolic-full-name
> =C2=A0resolving @{-<n>} correctly,
>
> - log and reflog also substitute @{-<n>} by the branch name,
>
> - update-ref does _not_ interpret @{-<n>} as the branch name (which I
> =C2=A0find okay, as update-ref is plumbing), but instead creates the =
file
> =C2=A0'.git/@{-<n>}' (which I think is a bug).
>

I did 'git branch -M @{-1}' yesterday and ended up renaming my branch
to refs/heads/@{-1}.  Personally my usage felt like it should work
(but of course I think that); curious to know what others think, if
this is a bug.

Deskin Miller
