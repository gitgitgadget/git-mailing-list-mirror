From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Thu, 29 Jul 2010 20:29:32 +1000
Message-ID: <AANLkTi=-+9TbR7=McSsh55gdzfKEsdqcao67kf0yFxsr@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
	<AANLkTikvhi-Bm-eV9ZfjoZdugRpiCwg8n-TQ4oOVvC=G@mail.gmail.com>
	<AANLkTikoOL0jYi4kD0L1uLU=UCmG9p0Rc3VLOU-djQnY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 12:29:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeQMt-0004vQ-H0
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 12:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab0G2K3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 06:29:34 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43292 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756342Ab0G2K3d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 06:29:33 -0400
Received: by vws3 with SMTP id 3so147028vws.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aWOfCZDKZea+B8I3zukiVg8gFLwdRYGSRBjT2whCaxU=;
        b=hV38uCo5Cezikqbuo2dQOzd+bCMllBVEnlvrWNxdSr0OksL5nWOTMtJOEChqiNatjk
         vC4oShanx7e5QvX67NOP+2SexNdvtWSVhWjAp6HeiU8rPi8/LRq12nySNG2MQ0rmTNcg
         MbtRkHRUrdyFjBKORv8eB/19gJyQaj+sy9aZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZnyjyjGakuAU+Fu2YuBpqMwNn2YMP24dWhZOpQGa3ahSE2ug4S4WkYTohKz8lTWssY
         38TsSLO4oELxz9Y3Mf6U4s19UKt9xN0WxJBSz2EvmCvet+lcv9TVzmXHCxpJ2Vpn7ER1
         TLIl1UCUMf/wU70Y41Tlc1UYIhdwui/3tvnQo=
Received: by 10.220.49.204 with SMTP id w12mr7114365vcf.243.1280399372407; 
	Thu, 29 Jul 2010 03:29:32 -0700 (PDT)
Received: by 10.220.101.201 with HTTP; Thu, 29 Jul 2010 03:29:32 -0700 (PDT)
In-Reply-To: <AANLkTikoOL0jYi4kD0L1uLU=UCmG9p0Rc3VLOU-djQnY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152171>

On Wed, Jul 28, 2010 at 1:59 PM, Elijah Newren <newren@gmail.com> wrote=
:
>> Revision walking is not the only gate to access objects. Others like
>> diff machinery needs also be taught about rev-list limits.
>
> Right, good point. =C2=A0Are there others than the diff machinery (an=
d the
> fsck special case) that you know of?

A lot (just found out as I was pushing subtree clone as far as I
could). For merging, you can hardly limit sha1 access. When writing
tree, git's particularly paranoid and check for sha1 existence
(has_sha1_file and assert_sha1_type). You can find that has_sha1_file
is used in many places, not just commit/write-tree.

Narrow/Sparse/Subtree/Lazy/Whatever-it-is clone will have hard time..
Oh.. the lazy one does not.
--=20
Duy
