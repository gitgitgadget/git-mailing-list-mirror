From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 22:41:47 +0700
Message-ID: <AANLkTin=y=THaQEzgMhyBVLBriJBCa-pVvONXDnzUmew@mail.gmail.com>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net> <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net> <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org> <AANLkTi=OJ_o2WQ2W6d30HXQZrg7=W70+fZWrbQPrAs=s@mail.gmail.com>
 <7v39mdhni3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:42:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2QCW-0002Wt-NH
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 16:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab1CWPmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 11:42:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32921 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1CWPmS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 11:42:18 -0400
Received: by wya21 with SMTP id 21so7765797wya.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=QOPb+ifMa6pUvHHbGwQkJyWcmT7Lo5O5Cy2ZMN/ObeI=;
        b=vYLZv1qCb0o8iiQt5766jBAkWFqDoD7O+Jy9kC4U7NCgBsDBmkD1GXTch3FFRDpaSx
         HhcCs1srEznWxbU7q6vAHoGpM0qf0cbjH5AjL/QKzkIg6wSKK+MiGhqyRj/5oQiuFS72
         6l6NSeKSIJKcDT3uH+T6dCT0lm+WaR+ftLOLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Wp/JhI1K+CqoRjEQbV2E00IwXiC7YCm6Tvynbh5Gxa7pcD9gp1yN8N6RCNRvgXY4n/
         DoAtuDvj+dMTIGHMeSXRu+YrcBMqKvi1V9K0uAX+f4bf5Y25B4BEJDrhHknEThvXHRHB
         mpD8zmWNqxApSScq/bkqvBL8FG7x4a+NTQDRg=
Received: by 10.216.242.134 with SMTP id i6mr1294990wer.81.1300894937153; Wed,
 23 Mar 2011 08:42:17 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 08:41:47 -0700 (PDT)
In-Reply-To: <7v39mdhni3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169843>

On Wed, Mar 23, 2011 at 10:20 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> (off topic?)
>>
>> "ls-tree -r" does not understand wildcards. Maybe it should not, but=
 I
>> think read_tree_recursive() should use tree_entry_interesting(). The
>> function it uses for matching, match_tree_entry, looks like another
>> variant of t_e_interesting.
>
> I thought that you already did that within the scope of your earlier
> topic.
>
> "ls-tree" is quite a low-level plumbing, and until we absolutely know=
 that
> all the old scripts people wrote relying on its original behaviour ar=
e
> extinct, we shouldn't touch it without a reasonable breakage protecti=
on.
>
> It is Ok to give it a command line option to make it in line with oth=
er
> pathspec users, namely, that causes the command to missing pathspec s=
hould
> automatically mean the whole tree and to honor globs. =C2=A0No existi=
ng script
> would be using that option, so that is a safe thing to do.

This read_tree_recursive() affects 'archive' and 'checkout -- paths'
(ie. no wildcard awareness). I will probably move match_tree_entry()
to ls-tree.c to preserve its behavior, then change
read_tree_recursive() to use tree_entry_interesting().
--=20
Duy
