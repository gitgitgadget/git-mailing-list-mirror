From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: permissions
Date: Tue, 8 Jun 2010 16:52:57 +0200
Message-ID: <AANLkTimAmSxq8dC-4bnpLsvN3JabQeTO6pDTh9ds7D0D@mail.gmail.com>
References: <4C0A19FE.1020802@wpursell.net>
	<m27hmdn704.fsf@igel.home>
	<4C0A9615.4090307@wpursell.net>
	<AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
	<4C0B6C32.1090700@wpursell.net>
	<7vvd9wvswy.fsf@alter.siamese.dyndns.org>
	<4C0E1AB1.2030702@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 16:58:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM0Fv-0000yq-6B
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 16:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab0FHO6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 10:58:14 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:60811 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab0FHO6N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 10:58:13 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2010 10:58:11 EDT
Received: by ywh42 with SMTP id 42so4055426ywh.15
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1X+AZJ7ZeiC5VGMlWqDC3hTLFl93BZdOFZVAgzTpTdA=;
        b=EeXo7pIVgNg5ynT6EuWkldGjUbAQG7n0Mz2BMQUsTysoatIjpyAL0bFU7aAPhl+yGb
         5VGauZc+HUeBbsPkGUpyn1BWxpR7j1lIkaqfWO09lJGv+bAr2VMrFqFGdAUnmAI0OJIT
         7vF0vJHMDhUY5I0Exrzd3jpC76yJanYxB5Vl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=um+cMV0o9Vseqxz5qp5TpRji9caWMBRcaQm8AAXkWi/FA8MYQvJq2TbDrpHNf64ldK
         EzkeqntHbYULx82eT0vMUQRK6eNX2HCbzwM2YaDqLzNJQdRdtEb2rTZYn+gqFS1tUKid
         /QRdPqZv7fgC6tnkO3Dh3pChM3CQRWjomt2dk=
Received: by 10.101.3.14 with SMTP id f14mr16565367ani.38.1276008780030; Tue, 
	08 Jun 2010 07:53:00 -0700 (PDT)
Received: by 10.100.123.13 with HTTP; Tue, 8 Jun 2010 07:52:57 -0700 (PDT)
In-Reply-To: <4C0E1AB1.2030702@wpursell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148679>

On Tue, Jun 8, 2010 at 12:25, William Pursell <bill.pursell@gmail.com> =
wrote:
> Here's a patch. =C2=A0This doesn't address the issue of a damaged
> repository, but just catches access errors and permissions.

The change looks fishy.

The patch moves the function is_git_directory at the level of user
interface where it wasn't before: it now complains and die.
Not all callers of the function call it only to die if it fails.
