From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/4] Deprecate "not allow as-is commit with i-t-a entries"
Date: Thu, 9 Feb 2012 09:23:47 +0700
Message-ID: <CACsJy8CC-VuriJO3WhzwwU9WYVuC7hudnziopd1+upp6AFLYfQ@mail.gmail.com>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
 <7v8vke38a1.fsf@alter.siamese.dyndns.org> <CACsJy8DSM3kPXJ4oYexCLs5qp6YdZ4Mf9RrGo78a0tHkRaTe4g@mail.gmail.com>
 <7v8vkdz0sg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 03:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvJgN-0006Cj-OA
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 03:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026Ab2BICYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Feb 2012 21:24:19 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44785 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2BICYS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 21:24:18 -0500
Received: by werb13 with SMTP id b13so864821wer.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 18:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bDCqGSW3WEOwysyK3Ee7ojVe789vAeT0ILv+aENWluw=;
        b=Dt6Mx1mUMz9wG69ep9QQ2iL5Y8ERfytORGXPxo0Jesj2cc/LzbCMxAgQNBFvvCE0tW
         J/SpO7xV8irgerWCBzZA74k2gLauYzH4OA6sVCnqn9f4JDxYYj8u3fY+Fe3aELo6W4Fy
         bRTdl302I1wc28qGWquGs7+BgRGXOAx+bv45o=
Received: by 10.216.136.211 with SMTP id w61mr4570668wei.18.1328754257400;
 Wed, 08 Feb 2012 18:24:17 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Wed, 8 Feb 2012 18:23:47 -0800 (PST)
In-Reply-To: <7v8vkdz0sg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190266>

On Thu, Feb 9, 2012 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ok, the strategy part is now behind us, but I have this slight suspic=
ion
> (I didn't look at the code nor tried it out myself---I don't have tim=
e to
> do this myself today) that using this codepath might result in a corr=
upt
> cache-tree, whose entries point at a section of the index it covers a=
s a
> subtree of the whole project but with incorrect counters or something=
 like
> that. =C2=A0It would be good to make sure this "just ignoring i-t-a" =
is doing
> the right thing not to the resulting commit, but in the resulting ind=
ex as
> well, before we go forward with this change.

I looked a little bit and I think i-t-a entries do not break
cache-tree. CE_REMOVE ones might though because they are taken into
account in entry_count field, but they are not written down to file.
Will look into it tonight.
--=20
Duy
