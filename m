From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Adding Beyond Compare as a merge tool, was: Re: What's cooking in
 git.git (Feb 2011, #05; Wed, 23)
Date: Sun, 27 Feb 2011 11:57:57 +0100
Message-ID: <AANLkTimWPwCFgnAYz_jJ3Yw5QWvPNhPxq=j502UorEot@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<4D68D4FA.7090500@gmail.com>
	<4D69E355.7010104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	charles@hashpling.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 11:58:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PteKD-0000eO-6v
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 11:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab1B0K57 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 05:57:59 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61886 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1B0K56 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 05:57:58 -0500
Received: by qyg14 with SMTP id 14so2624660qyg.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 02:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mESA/wXqmlauOYG4SISuGpWlt6q4Eazdcvv8DIeTw2o=;
        b=DoU3fgINcvqubcVuyefEtkN6XFXgT4WpVTBL0jk+OWIjqA3qMOOeeyLXCC/4fPbnEw
         cHSBWtGQD1TNGdhbhYTCaVxI6SNUCn+aR8EJkCe/mA8P7dR6y+oz5ngX4IJJFXjj0DHi
         SDOvFVN3eTGY3ACf9u3B1oML+8/YdckPqcFVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mrrOVQrggTRaFe29MRa+ixS72jWqg1mGQ0Rg+zwGFKsmBJQ6a1jDtLkPNGnQcXaAHm
         sjMACqFobGYivbFK0B7O5BTyFBVgk+kMCe6PPtsrA918tsdAW/u2hLiL6ia1zJmsIRfE
         Yqn+SeLL50alJVrw7/CODt0qSk59JvPwYNpXA=
Received: by 10.229.82.80 with SMTP id a16mr3151557qcl.76.1298804277929; Sun,
 27 Feb 2011 02:57:57 -0800 (PST)
Received: by 10.229.17.73 with HTTP; Sun, 27 Feb 2011 02:57:57 -0800 (PST)
In-Reply-To: <4D69E355.7010104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168022>

On Sun, Feb 27, 2011 at 06:38, Chris Packham <judge.packham@gmail.com> =
wrote:

> Sorry that I missed it (I didn't really look too hard).

No problem, at least this got me dig out my series again ;-)

> 3-way merge tool. Trying to indicate v3 only make sense to me (at lea=
st
> until they release a v4 :)

True. In that case, read it as "Beyond Compare version 3 an up" ;-)

> In linux it's bcompare, although BCompare is the eventual executable
>
> chrisp@laptop:~> rpm -q --filesbypkg bcompare
> bcompare =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/usr/bin/bcompare
> bcompare =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/usr/lib/beyondcompare/BCompare

Ah, OK, being on Windows I just checked the TAR.GZ file, which does
not contain /usr/bin/bcompare (but bcompare.sh, which probably gets
installed by install.sh).

> Unfortunately /usr/bin/bcompare is a little more involved than a syml=
ink
> so for linux we need to call bcompare. Do we have a nice way of handl=
ing
> this? We could just treat them completely separate but that seems a b=
ut
> like sweeping the problem under the carpet.

We could just call "bcompare" on Windows, too. As Windows is
case-insensitive, it will just work.

> with your suggestion. We should probably make use of the -title optio=
ns
> to remove ambiguity.

Good idea, I'll look into this.

> I'll give it a whirl when I get a chance. I suspect I'll need to hand=
le
> the BCompare/bcompare thing but that's not a huge issue.

You could probably just wait a few minutes until I have pushed out an
update for this patch.

--=20
Sebastian Schuberth
