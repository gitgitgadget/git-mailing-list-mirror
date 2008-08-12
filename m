From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: TopGit: problem with patch series generation
Date: Tue, 12 Aug 2008 23:28:42 +0200
Message-ID: <8aa486160808121428t259f5340x6d1a14cadedac30c@mail.gmail.com>
References: <20080812161854.GB30067@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git discussion list" <git@vger.kernel.org>, pasky@suse.cz,
	"Manoj Srivastava" <srivasta@debian.org>,
	"vcs distro packaging discussion list" 
	<vcs-pkg-discuss@lists.alioth.debian.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT1R7-0003MN-9F
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 23:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbYHLV2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 17:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbYHLV2p
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 17:28:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:47030 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbYHLV2o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Aug 2008 17:28:44 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1006981yxm.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BV6XOrtW1QY7hn44TXlara4PL6s3+VBDbwbL4vsts3U=;
        b=Ptz4ukN/IIiLoc5AWjVWj+HB4L190aEOA+vagp4PmPNP0vWNCJZSTJxr90LURJN5yg
         Rrytylq9IGMEGGZOr/UO4cm4ksxw4Tm0lwoEW47fdt1mS5HKZVvKDXvSUAwnMp+Uv5jf
         jM6Vrfj8Z2fwx9awcEhtagUFNEvJCKddjWMEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kwz9q5Eg49gzDojSNyjNwxboB7zvT8ubbjJyVCx4hQJvgJ607Mkt2X+l4n31xTX70d
         4OC/OWwd6DMBA/mo5C/V16XkBc/9NhZnfWI1imgrDhwjLfC4Kvq2xYlOMJHnC1IG0p6V
         WDys5j0+39n+81hmZkY9HJLbxRePTuv6zLH+s=
Received: by 10.150.152.17 with SMTP id z17mr11796043ybd.242.1218576523031;
        Tue, 12 Aug 2008 14:28:43 -0700 (PDT)
Received: by 10.150.230.18 with HTTP; Tue, 12 Aug 2008 14:28:42 -0700 (PDT)
In-Reply-To: <20080812161854.GB30067@lapse.rw.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92141>

On Tue, Aug 12, 2008 at 18:18, martin f krafft <madduck@debian.org> wro=
te:
> Hi folks,
>
> I am playing around with TopGit and encountered a (conceptual)
> problem. I'd love to hear some input.
>
> I want to use TopGit for distro packaging. Any of my packages have
> one or more feature branches, some intended for upstream, some
> distro-specific. As I am packaging TopGit for Debian, I encountered
> the situation that two branches conflict with each other (they
> change the same line), but there is no dependency between the
> branches. Thus, when I squash the branches into a series, the
> resulting patches will not apply (they both change the same original
> line to something else).
>

I don=B4t know if it fits topgit, but this is what Junio uses:

http://article.gmane.org/gmane.comp.version-control.git/24498

Basically he creates a new feature branch that is the merge of the
conflicting branches (it works for both semantically and explicit
conficts), and there he resolves the conficts. Then if one of the
branches are merged in master (in you case a patch is created) then
the other branch fast-forward to the merge.

HTH,

Santi
