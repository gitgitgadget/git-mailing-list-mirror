From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/6] clone: factor out checkout code
Date: Tue, 10 Jan 2012 12:57:23 +0700
Message-ID: <CACsJy8DG2CCbDipfFEp2JM5wb0Nn9F7v8Cxx1bPAZ-40OdEA9A@mail.gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com> <1326023188-15559-3-git-send-email-pclouds@gmail.com>
 <7vd3ascs85.fsf@alter.siamese.dyndns.org> <CACsJy8DZpA0sQ6ZYjgrp8PsRTsYm0nOfSXcDOEhB2TRjqwbM0Q@mail.gmail.com>
 <7vhb04b1bc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 06:58:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkUie-0008Mj-DO
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 06:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab2AJF54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 00:57:56 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56417 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab2AJF5z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 00:57:55 -0500
Received: by bkvi17 with SMTP id i17so182689bkv.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 21:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qIyojvKiqK2X4ggyZd3i0oO28NHrvOmtaHxLbrOxXFI=;
        b=Rwq/Ox+w1V2tPqtJtVZarTpz5Ox7vUczRYVjk+PN9lGmb1weK5D5MDxpWdA2GUTh6d
         Vrui7wYcqp3E1GnAh8xHJPEgsCD2fdm3KjRomS+xNF2C+TSGsDHo2odav9PHW1fs22XM
         8gYneU9ch4V86xQucOrZAMFZLgjRPSmvYM/bU=
Received: by 10.205.122.138 with SMTP id gg10mr8410741bkc.94.1326175074167;
 Mon, 09 Jan 2012 21:57:54 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Mon, 9 Jan 2012 21:57:23 -0800 (PST)
In-Reply-To: <7vhb04b1bc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188222>

On Tue, Jan 10, 2012 at 11:59 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> There's also one thing I missed in the commit message that it makes
>> update head code and checkout code more independent. Update head cod=
e
>> does not need to maintain our_head_points_at at the end for checkout
>> anymore.
>
> I like that reasoning in general. The logic ought to be:
>
> =C2=A0- Learn what the remote has;
>
> =C2=A0- Combine it with --branch parameter, determine what local bran=
ch our
> =C2=A0 head _should_ point at;
>
> =C2=A0- Make our head point at it, and check it out.
>
> I wonder if we can somehow make the above logic more clear in the
> code. Perhaps the first two could be made into a single helper functi=
on
> "decide_local_branch()", and the third would be the "checkout()" func=
tion
> in your patch, updated to take "const char *" parameter or something?

yeah, I split the first two into update_head() but dropped it for some
reasons I don't remember. That would make the main function easier to
follow. I'll look at it again.
--=20
Duy
