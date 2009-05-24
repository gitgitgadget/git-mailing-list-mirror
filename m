From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Mon, 25 May 2009 00:57:44 +0200
Message-ID: <fabb9a1e0905241557l403037f6p7c1df1f587cb9cf7@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7voctirzu6.fsf@alter.siamese.dyndns.org> <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com> 
	<7vfxeurwh0.fsf@alter.siamese.dyndns.org> <cb7bb73a0905241518l43048416i34cb905c143c63e0@mail.gmail.com> 
	<fabb9a1e0905241528r7b5102b0w5d064727125654d@mail.gmail.com> 
	<cb7bb73a0905241553i2cf2c246ycd0b5466e60c8de8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 00:58:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Mdw-00014x-Pm
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 00:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbZEXW6G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 18:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbZEXW6F
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 18:58:05 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:41346 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbZEXW6D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 18:58:03 -0400
Received: by ey-out-2122.google.com with SMTP id 9so733996eyd.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 15:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oIXGR3GnpzwvlKbjZrZHz3SQHf8CedEi8mNciir4Jvs=;
        b=AYRhlScxJIGJsc5rU565XhoUEFv2xkwivA9e1vR1Z2NJDjiUWW/ExPKD1fhbrXCUFZ
         sZ7Ydff6gQeJhQ/x/lJ9ulWTnP6/ZwrjKyxUNHBM2FBX3Z0YUTq6NnAiJ6AtPNPZsNwm
         lrJviax3HtK0MKhwBlgbGM1sGla39y0CWpnSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=s/yAVp+8atYFQ05K/4WX4GIBSv+VmnJjQYdWQnNuVELref3j+yd9bKxnOj7mnlcgkd
         Y0hS/zyppU7VGg8CMD+idPttgxeJlGPNVyJrWLDWp55rnbOwI/mNmw3MVQ6peIluNFST
         N0uYMnQO9S+sw5N96PQ7grUp6OeZPDxUPycGM=
Received: by 10.216.73.193 with SMTP id v43mr1273824wed.157.1243205884127; 
	Sun, 24 May 2009 15:58:04 -0700 (PDT)
In-Reply-To: <cb7bb73a0905241553i2cf2c246ycd0b5466e60c8de8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119873>

Heya,

On Mon, May 25, 2009 at 00:53, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> This is an interesting solution. And git-am could call git-munge
> automatically before feeding the patches to mailinfo, replacing
> =A0git mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
> =A0 =A0 =A0<"$dotest/$msgnum" >"$dotest/info"
> with
> =A0git munge "$dotest/$msgnum" | git mailinfo etc

I was thinking the other way around, so that 'git am' doesn't need to
be modified.

Behind the scenes, git munge "$dotest/$msgnum" does something like:
1. munge the file so that it's in the appropriate format
2. dispatch to 'git am' with the munged file
3. profit

--=20
Cheers,

Sverre Rabbelier
