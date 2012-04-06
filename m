From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Fri, 6 Apr 2012 22:44:39 +0700
Message-ID: <CACsJy8AkFiiaKnqqyLEZfa+DJsRyKd6dGEN71c3q=6j3fo8jww@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
 <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
 <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
 <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com> <87r4w1vofu.fsf@thomas.inf.ethz.ch>
 <CAJo=hJssfTvGqzQtaAj+Dk_R2oU5BwY=sQQuH3=SFTf+Zcp=3A@mail.gmail.com>
 <CACsJy8DaBxCtU7UQcc510J71zk95DMMsWdr9S3eYTupdRLjWBg@mail.gmail.com> <878vi8sx1x.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Thomas Gummerer <italyhockeyfeed@gmail.com>, david@lang.hm,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 06 17:45:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGBLo-0006ZB-GB
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 17:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512Ab2DFPpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 11:45:14 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54772 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab2DFPpK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 11:45:10 -0400
Received: by wibhj6 with SMTP id hj6so644866wib.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DQ0S2DJpusyonb0tVFdW6NjF7pLo/2cUZHaupDMEdno=;
        b=IkAacQcH/RR/LGSxZQ25xOC3mrKySPVETzeLxKOQWnQrNiNkdICi1FknHj33akT6W1
         vQaYk9W6RHH7axulGDxHilT/XdEu+cSTYc0ggdgY/SQDaoHxOObcdSA8PEBQKEFAEUim
         2Y17I2hxYgI8C6vz3kFAh5+vqhHaeMMAH74KbqC5j/TGfYSnKrey5NZ/uQFDNUEnaav1
         taj6DRrvv2o1Zo0uzMXRD/tiHtQ0jV+QJSwN41DG1D0iUPx4jtpoQ1a1D00UEWVQHfo/
         mR5Ax6rfP92gfn9UI4rCS7QMkQ9vfyni5mL2jNIkQxjKaOSBEWJNfVMI/qVYKF9Objjk
         MrpA==
Received: by 10.180.102.3 with SMTP id fk3mr12843928wib.9.1333727109660; Fri,
 06 Apr 2012 08:45:09 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Fri, 6 Apr 2012 08:44:39 -0700 (PDT)
In-Reply-To: <878vi8sx1x.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194876>

On Fri, Apr 6, 2012 at 10:24 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> But even so: do we make any promises that (say) git-add is atomic in =
the
> sense that a reader always gets the before-update results or the
> after-update results? =C2=A0Non-builtins (e.g. git add -p) may make s=
mall
> incremental updates to the index, so they wouldn't be atomic anyway.

Take git-checkout. I'm ok with it writing to worktree all old entries,
or all new ones, but please not a mix.
--=20
Duy
