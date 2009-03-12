From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 18:15:02 +0530
Message-ID: <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
	 <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
	 <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
	 <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
	 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
	 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
	 <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
	 <7veix33f5e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:47:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkJc-0007Yu-AF
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbZCLMpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 08:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbZCLMpG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:45:06 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:13846 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZCLMpE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 08:45:04 -0400
Received: by yx-out-2324.google.com with SMTP id 8so453680yxm.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NC5XpuRomXZIu/xb+oeu5qmoocc1Ae56u0AIeTSOUT8=;
        b=FqHdYSTcn7umM7zjjIfGq4uA/zBgzWE+PWKwr8wG+TeHjuaqz9KTMvmlS4Mtxs2mWz
         yWSJwrA23FqtV4FGvDeyJXaBssqZsTytb3iOmvGcFB6DXTMV71l3UZFA7qF6D403vjIB
         rGVI74hLKbU1MrmlITQhqa09yWFP6MnbC6/8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wglROmTv2UDisWUI5TEP3FXH0A5U52SKi4ay5mHUhFxhQRVMxQNDtYnkP4qlJSAXG7
         W9+AefvbmDMotleWvUsMg5lnBtztXO7HdCi6n/+LgfY+9jSnn4Km41esVq0JZw46exlC
         mN42fUNYUqGiWOSTf4FnSLtQMbiHiiRIxyoUA=
Received: by 10.231.14.72 with SMTP id f8mr2264946iba.34.1236861902200; Thu, 
	12 Mar 2009 05:45:02 -0700 (PDT)
In-Reply-To: <7veix33f5e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113059>

On Thu, Mar 12, 2009 at 3:17 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> You can cut it both ways. =A0For an OO document, you do not necessari=
ly need
> any file-level merger at the driver level, but just let the "binary"
> driver declare conflicts and punt. =A0A merge helper can do all the w=
ork
> starting from the "original, ours and theirs" that are not smudged wi=
th
> conflict markers.
>
> Between these two extremes, the discussion from other people in the t=
hread
> seemed to all focus too heavily on the "driver punts" approach, forge=
tting
> that mergetool is useful only because most of the time we do not have=
 to
> even use it, thanks to the fact that "xdl" driver works reasonably we=
ll
> for most trivial cases where branches being merged stayed away from e=
ach
> other, which is the majority case. =A0It is a huge win from the produ=
ctivity
> point of view, and many people might be unaware of it because it is s=
o
> invisible.

If I am not wrong, then for merging two xml files, if we use a simple
xdl merge driver then it will mark the conflicts in the normal way as
it does for simple text files. As far as I can understand, the
following things are supposed to be aimed here taking an example of
xml file:


=3D>Merging of two xml files

=3D> existing merge driver (like xdl) is called which marks the
conflicts points just like a normal text file.

=3D> the conflicted file can be read through a text terminal and
conflicted lines can be seen.

=3D> suppose the xml file is from the domain of OO document. Then, a
merge helper for OO xml type file is called which takes input as the
conflicted file produced by xdl driver.

=3D> The merge helper creates a new file or changes the input file to
make it a valid xml file so that it can be opened in OpenOffice and
user can see the markers like "=3D=3D=3D=3D" or "<<<<<"  in an appropri=
ate
manner and can resolve the file manually.


>=A0When it cannot autoresolve,
> but there is no way to "mark" a tentative result with conflict marker=
s, it
> can do the same thing as the "binary" driver and let the mergetool ba=
ckend
> handle the "driver punted" case.

I think you mean to say that in case, there is a conflict and the
changes don't overlap, then merge driver leaves the file as it is and
the merge helper will handle the file.


--=20
Saurabh Gupta
Senior,
NSIT,New Delhi, India
