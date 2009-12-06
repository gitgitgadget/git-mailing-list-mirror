From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Continued work on sr/vcs-helper and sr/gfi-options
Date: Sun, 6 Dec 2009 11:23:17 +0100
Message-ID: <fabb9a1e0912060223h148a67b0q589b8461dae6330e@mail.gmail.com>
References: <fabb9a1e0912051653s77ba25e1g9ff1e21219cd06c9@mail.gmail.com> 
	<7vr5r8oov1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 11:23:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHEHM-0006Rn-9O
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 11:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230AbZLFKXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 05:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933219AbZLFKXc
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 05:23:32 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:64121 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217AbZLFKXb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 05:23:31 -0500
Received: by vws35 with SMTP id 35so1669294vws.4
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 02:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=z9hkfr2XWrm1/az0hV39nI8J8KLFc+JdL37bEwtNAv8=;
        b=x+vAz2SVvbyIQ5BPmTtKRutIZQAjYd4vNuYwv+23UHd6mu66Uh7NxJbnVj/gqG3o3e
         ImaHcLHprONeplJ+UDdBzvf6EEpRYfKuzjZB62VG+80Clq47mFXVsXy1gM6l0kEWwqre
         AnVjCFWVu0zWFXGwJigdfTH7dsoCZeAboR/Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=s9lzlyGyXDsiFVwc8EvZ6zcPKal4FqZoykc1g2RPe3bTBnrjbsRsGx8WjgAA3PSZ3u
         6rKXP3oNyKUj1uJSWamCHxLyq3GFrZj9z21ADOLCP2BemmvHnYjlgn+ThXtNUhzEi+qD
         Si1MVAeGCnqv4YCuE+zxGzH1f+Nk52Sk9al+c=
Received: by 10.220.125.7 with SMTP id w7mr6791516vcr.14.1260095017251; Sun, 
	06 Dec 2009 02:23:37 -0800 (PST)
In-Reply-To: <7vr5r8oov1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134657>

Heya,

On Sun, Dec 6, 2009 at 02:47, Junio C Hamano <gitster@pobox.com> wrote:
> =A0- sr/vcs-helper seems to be near completion; I'd expect it to be a=
mong
> =A0 the first batch of topics to go to 'master' after 1.6.6 final (so=
me
> =A0 fixes may happen between now and 1.6.6 final to make the series a=
 bit
> =A0 longer, though).

*nod*.

> =A0- sr/gfi-options started moving again and there could be a couple =
more
> =A0 iterations before it would hit 'next'.

Yup, I'm hoping for a review by Shawn and the vcs list.

> Until sr/gfi-options becomes more solid, one way we can manage
> sr/remote-hg is (thinking aloud):
>
> =A0- Fork sr/remote-hg from today's sr/vcs-helper;

That makes sense, this way I don't have to re-resolve those merge
conflicts either.

> =A0- Merge today's 'master' to sr/remote-hg (optional);

I'm not sure why this is though? (no objections against it, I just
don't understand the motivation)

> =A0- Whenever any updates to vcs-helper topic appears, apply them to
> =A0 sr/vcs-helper, and merge the result to sr/remote-hg;

*nod*

> =A0- Create an unstable sr/pu-remote-hg branch that:
>
> =A0 - is reset to the tip of sr/remote-hg at the beginning of the day=
;
> =A0 - merges the day's sr/gfi-options on top;
> =A0 - re-applies patches to implement Hg interoperation on top of the
> =A0 =A0 result.

Ok, that does make sense, how would I send out patches for review from
this unstable branch though? (since others would not have the required
merges etc) I reckon it would be necessary to publish sr/pu-remote-hg
somewhere?

> When sr/gfi-options becomes solid, we can merge it to sr/remote-hg it=
self,
> get rid of sr/pu-remote-hg "patch queue", and move the Hg interoperat=
ion
> patches we helpd in sr/pu-remote-hg to sr/remote-hg branch. =A0We wil=
l merge
> early parts of sr/remote-hg (at least up to the merge with sr/gfi-opt=
ions,
> and perhaps early parts of individual Hg interoperation patches as we=
ll)
> to 'next', and remaining parts on the branch to 'pu' (and they can be
> replaced).

Luckily the remote-hg patch is just that, a single patch. I've already
put all the other work that's needed into sr/vcs-helper and
sr/gfi-options.

Thank you for the detailed explanation :).

--=20
Cheers,

Sverre Rabbelier
