From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-recursive: tweak magic band-aid
Date: Mon, 21 Mar 2011 12:24:12 -0600
Message-ID: <AANLkTik8qaiu0NeM4oyuOvWXtw5QzamQxoyENAUsQxj3@mail.gmail.com>
References: <7v4o7260no.fsf@alter.siamese.dyndns.org>
	<7vpqpp1kww.fsf@alter.siamese.dyndns.org>
	<7v1v250xnr.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jm8-000075-Gv
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab1CUSYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 14:24:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1CUSYO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 14:24:14 -0400
Received: by bwz15 with SMTP id 15so5248916bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NlpN+CrXmOuC3g/ujw8dfo+HsB9PkU1JC67l7WzeaFc=;
        b=lzigAyv1zJD2gcnZx6DjPoKlBN7KGYimKut9ebCK1qNHVa3vME+GLBql+i/kRed2Zt
         Z4H4J7YBKTLqKdh8e5eFAVtUI/IxXVa4fx6DBQJh4tk3cpRPFHJWHda6DRv274G/st2t
         9SFak+ZxtRMkmosX2EI5RThWJvNFdlvHcbIys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DZPIrpz+1yiIJ6Dz7DDAy2jUjMP70mSVsi7tkrP9ja+LwisDzDCO8rY+e6/MhHg0dl
         eBLA4M8e7o3i9YYEz8pWAdw6StEWTa8BAMFP8RX9hL34VEvDMh1827vAdCQUYSqfWVcI
         xs5+dSEB81FbKTvgjO9GQKRCofwnJ9wI2NnMc=
Received: by 10.204.17.20 with SMTP id q20mr27525bka.151.1300731852876; Mon,
 21 Mar 2011 11:24:12 -0700 (PDT)
Received: by 10.204.23.75 with HTTP; Mon, 21 Mar 2011 11:24:12 -0700 (PDT)
In-Reply-To: <7v1v250xnr.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169623>

Hi,

On Fri, Mar 18, 2011 at 12:07 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Running checks against working tree (e.g. lstat()) and causing
> changes to working tree (e.g. unlink()) while building a virtual
> ancestor merge does not make any sense. Avoid doing so.
>
> This is not a real fix; it is another magic band-aid on top of
> another band-aid we placed earlier.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Sorry for not responding sooner; thanks for fixing this up, though.
Also, I have to apologize for having left a bunch of changes on my
harddrive for several months; one of those changes includes the first
half of your patch (which I should have remembered and not made the
problem worse with my more recent patch submission.)  I just never got
around to cleaning up those changes and getting them submitted.  Maybe
I should just send what I do have for now, and then send the cleaned
up version when I get a good chunk of time in another month or two.

> =C2=A0 merge-recursive is riddled with places that touch/inspect work=
ing tree
> =C2=A0 when it shouldn't, and it is beyond salvage without a major re=
factoring
> =C2=A0 in its current shape, so this magic band-aid should do for now=
=2E

Yeah, I agree this needs to be fixed up.  If no one else takes a look,
I'll try to when I get back to my other changes.
