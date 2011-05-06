From: Jerome Martin <tramjoe.merin@gmail.com>
Subject: Re: Private/public branches/repos workflow
Date: Fri, 6 May 2011 11:27:11 +0200
Message-ID: <BANLkTikC23_hi4TppxdfMjCZDJWNd9ZF7g@mail.gmail.com>
References: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
	<7v4o598164.fsf@alter.siamese.dyndns.org>
	<BANLkTimggn-E+JsXp78_a2P3eWku3oTSbQ@mail.gmail.com>
	<7vk4e44gfo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 11:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIHJo-00018T-Sp
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 11:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab1EFJ1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 05:27:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61350 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab1EFJ1L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 05:27:11 -0400
Received: by gwaa18 with SMTP id a18so1082889gwa.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GD1pzqzV79jnBHHqnOEqjOaVfXnVbmaunT++5pWnZcs=;
        b=qpppV5U4/0eMdDdV1FMzpyqZaIBJLd60IiOoENEwYM7iKb5opV56WIbg7T9sFMyK5z
         TwSJPPjB/2dRAiuMnXboiu5WEZmUujBc6IVd4heTpzRNKxAjVB2LE5qyGMn6AKaSwa0P
         cYIM1FDKYia33iM5L/ssabM8jqoMdYdsVA/0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=feR0Dj2Mwm4IrbPcAEv7Hiicyzkp6/eQR9rfK0pDFkZ2nanFaTH45X2JAeMtQ/58Xn
         eYROrixp5xSKxaJJIUtRFTjzoEKVv09q6yYAPfhSW+LGq2qk/fA/VSH/yhxwMh0tsvch
         49wFTyGViI+6Lj2J/quix/Z/LldD05mCSeaSQ=
Received: by 10.236.66.75 with SMTP id g51mr3869223yhd.524.1304674031143; Fri,
 06 May 2011 02:27:11 -0700 (PDT)
Received: by 10.147.167.8 with HTTP; Fri, 6 May 2011 02:27:11 -0700 (PDT)
In-Reply-To: <7vk4e44gfo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172962>

Again, thanks for the help :-)

On Fri, May 6, 2011 at 6:10 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jerome Martin <tramjoe.merin@gmail.com> writes:
>
>> Could you tell me how you would see usage of rebasing inside the
>> workflow you describe ? I am thinking about features (mistakenly)
>> implemented on top of the private branch that need later to be relea=
se
>> in the public branch. Can this be the shortcut to avoid lengthy
>> cherry-picks ?
>
> Mistakes and changes of plans can happen, but it's not a big deal.
>
> In the git project itself, even the "master" branch that corresponds =
to
> your "private" branch is managed with topic branch workflow, so it is
> entirely possible that a topic that was originally meant only for the=
 next
> release turns out to be better backported to the maintenance track.
>
> If you have a private "feature-A" topic with many commits:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O =A0 public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0...---x---x---x---X---S =A0private
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---b---...---z =A0fe=
ature-A
>
> and later it turns out that it is better to release them also to the
> public, instead of cherry-picking the commits to the public, you coul=
d at
> that point do something like this:
>
> =A0 =A0$ git checkout -b public-feature-A feature-A
> =A0 =A0$ git rebase --onto public private
>
> which will first create a new branch "public-feature-A" that points a=
t the
> same tip of "feature-A", and then rebases the commits on that branch =
that
> were made since the topic was forked from "private" on top of the tip=
 of
> the "public" branch, resulting in:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a'--b'--...--z' public-fe=
ature-A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O =A0 public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0...---x---x---x---X---S =A0private
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---b---...---z =A0fe=
ature-A
>
> and then you may choose when to merge that to the "public" branch.
> By the time you do this, perhaps the original "feature-A" may have al=
ready
> been merged to "private" after fully tested and audited, like this:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a'--b'--...--z' public-fe=
ature-A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O =A0 public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0...---x---x---x---X---S---x---x---x-----* =A0private
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 /
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---b---...---z =A0fe=
ature-A
>
> and then after you merged "public-feature-A" to "public":
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a'--b'--...--z' public-fe=
ature-A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O---o---...---o--* =A0 public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0...---x---x---x---X---S---x---...---x---* =A0private
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 /
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---b---...---z =A0fe=
ature-A
>
> merging "public" back to "private" hopefully may have too many confli=
cts
> between the feature-A and public-feature-A branches, as they are supp=
osed
> to be patch equivalent, to produce this:
>
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a'--b'--...--z' public-fe=
ature-A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O---o---...---o--*---. =A0 pu=
blic
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
> =A0...---x---x---x---X---S---x---...---x---*---* =A0 private
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 /
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---b---...---z =A0fe=
ature-A
>
> After this you could even garbage collect the two topic branches ;-).
>



--=20
J=E9r=F4me Martin
