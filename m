From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Cast execl*() NULL sentinels to (char *)
Date: Sat, 24 Jul 2010 15:27:37 +0000
Message-ID: <AANLkTimxB-n4oq-5XUSK5XwEXLnwLsakyuryNlUnghJr@mail.gmail.com>
References: <201007141740.37867.trast@student.ethz.ch>
	<00564b8ba93617801bb78b4a0ec67784e597d02a.1279983892.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>, kpfleming@digium.com,
	brlink@debian.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 24 17:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocgdj-0007tG-IH
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab0GXP1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 11:27:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45105 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab0GXP1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 11:27:37 -0400
Received: by iwn7 with SMTP id 7so1259769iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U1X98F6SvqbR6LmqiZDccY7P29Uh1C5qY5tU5oLVSOg=;
        b=dPJaeH5ClgJ/SANt6tzl7iowGGKJ5Cynlx26Po9Bm8brplw0lIlydEmirkbgTlte4v
         58FXxMbrUm5MpRebL4zaQrBj0PVocKmUIdcbacHKALxD6DjOr+KW01sNUH+wz73SUhMr
         P/LiXW4C2SfOfEWyG1jXU88QBafWJ1XOFjIsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=llc3rJeZX+bWJhyJiTI8ZKBrslemaWFysycPc19m5KhUdOIUybla34OSa2Ao1WgwRE
         FTHM69gzhnn+/b6bdk+QvtUCWYUV2Lc/rAwDznzbD4bV5j2LTveGzW6BQ5iEbYEcRzDi
         taZe0DvxjJH+IgeMQAxkI2xtmHF/M1gpJBJbI=
Received: by 10.231.146.196 with SMTP id i4mr5056233ibv.110.1279985257147; 
	Sat, 24 Jul 2010 08:27:37 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 24 Jul 2010 08:27:37 -0700 (PDT)
In-Reply-To: <00564b8ba93617801bb78b4a0ec67784e597d02a.1279983892.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151657>

On Sat, Jul 24, 2010 at 15:20, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> The NULL sentinel argument to the execl*() family of calls must be
> cast to (char *), as otherwise:
>
> - platforms where NULL is just 0 (not (void *)) would pass an int
>
> - (admittedly esoteric) platforms where NULL is (void *)0 and (void *=
)
> =C2=A0and (char *) have different memory layouts would pass the wrong=
 kind
> =C2=A0of pointer
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Nice that you got around to this after I inadvertently pointed it out
in another thread.

Acked.
