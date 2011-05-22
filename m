From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Recovering from a bad object
Date: Sun, 22 May 2011 18:47:23 -0400
Message-ID: <BANLkTinbNXRkRdDusz6=-aJkxW==rGVVeg@mail.gmail.com>
References: <BANLkTindTWzeTFKYA3if4HYG3mj+NZX8oQ@mail.gmail.com>
	<7vy61ywjpa.fsf@alter.siamese.dyndns.org>
	<BANLkTinPOYH_pJsFkbQHCb_H5GhyTn+xhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 00:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOHQn-0003jr-AI
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 00:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab1EVWrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 18:47:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53178 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab1EVWrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2011 18:47:24 -0400
Received: by iyb14 with SMTP id 14so4190213iyb.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hgmv2TWHH2YwyvfVTesXdqztYUJH2gzHl+N35LoIJdY=;
        b=rSfVEHQCooqbAI/FsdnrJFyF4RN6iQkbt/awqgVsogJhEBAZIHdOCWMeIfw0S0gDaS
         OYSWYCOhvybp2wpP+vyJ6bSHQSMTsn67ruMKA5s1wIsd5hrfSlSRSCyG6lphGjbXGexh
         uBCOtN2HiODM80DrVGKOqhFTPhijPSrvT93Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d/jfrvMK6BwXV4jWAsN2GQMxeofMv95+3dYzMOY7OxqL+cIeagXtGTvy0wEJRIofaq
         ttDAF5l1fizL+QNJ8jXHZpUyOx3ipA6Ggg3xSfiRaTVvwerRL1SE4F9Zbu3hmkKVJI+z
         bbSnXuvvUFaI1uraqRuzNElr6/SpeIlwkHyck=
Received: by 10.42.131.133 with SMTP id z5mr8513608ics.399.1306104443590; Sun,
 22 May 2011 15:47:23 -0700 (PDT)
Received: by 10.42.28.200 with HTTP; Sun, 22 May 2011 15:47:23 -0700 (PDT)
In-Reply-To: <BANLkTinPOYH_pJsFkbQHCb_H5GhyTn+xhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174205>

On Sun, May 22, 2011 at 6:31 PM, jonsmirl@gmail.com <jonsmirl@gmail.com=
> wrote:
> Looks like the corrupt object is ok in the object store.
>
> I checked out about 20 of the dangling objects. They all start off wi=
th...
>
> commit aa96dc2459563fa362bc53597cb076d93bcc884a
> Author: Jon Smirl <jonsmirl@gmail.com>
> Date: =A0 Sat Mar 19 13:30:55 2011 -0400
>
> =A0 =A0refresh (create temporary patch) =A0 =A0d666137c5fe3ee4c4c812c=
706b1a3c539405ffd0
>
>
> That's stgit leaving all those dangling references. I will experiment
> with the current stgit and see if it is still leaving the dangling
> references or if they are leftovers from an old bug.

I've confirmed it is a problem in stgit. I made a brand new clone and
did three refreshes in it.

jonsmirl@terra:/home/apps/lpc3131/linux$ git fsck
dangling commit 78fe5e16791996ffa3e60eb8015c8782c02496ca
dangling commit 5d41f5a4368036f18a021a8e72ad5577839070c6
dangling commit b3b2be2f2a78d356059d92dbb937f9df726de166

Now I have three dangling commits.

Now I don't know enough about stgit works. Are those really dangling
commits from stgit abandoning temporary commits, or is stgit tracking
them and 'git fsck' simply doesn't have a reference to them.

>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



--=20
Jon Smirl
jonsmirl@gmail.com
