From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv3 0/9] Push limits
Date: Sun, 15 May 2011 23:52:10 +0200
Message-ID: <BANLkTi=yKYw+kyPBPHSB6QfpjDqOi+WOmg@mail.gmail.com>
References: <201105151942.29219.johan@herland.net>
	<1305495440-30836-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 15 23:52:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLjEX-0005Se-RZ
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab1EOVwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 17:52:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43928 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab1EOVwM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 17:52:12 -0400
Received: by fxm17 with SMTP id 17so2681362fxm.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kwKuGFko3zIDUgetw9oNafK5ne25DRRM7+VvvdbcATI=;
        b=xQl8mP41nTsfw05pBrj4jbOz5MtKOMZt8F8W8BFymuNo9msaqbDBwCPi8rykUYkvV5
         v/qb2roc4zeqFwWeSfWe9xjHSfm/ZKW7FQMIASTvlSrxBkpdtwZHd/fpHwAZ9S7THhHx
         VYKbzWvLujbUs+ynp/UpMJjc3XWYzT8AdH6vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BlOxUpdAh+4oKJ4Wpty/Pp0yJ+w1fjK4H4yaLsSLStqN3JszKZs82bvOMG++FsqzUF
         z9UgJYXCgOpknE2ITyDD+r3dYSXizR0HES43RDfuST5JwEWA2nOlxht3oF1mr9oWGCfd
         5qT9qg8Rhopoe2ntHt+rvIedguA9WZGNzZADk=
Received: by 10.223.38.149 with SMTP id b21mr1912518fae.18.1305496330907; Sun,
 15 May 2011 14:52:10 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 15 May 2011 14:52:10 -0700 (PDT)
In-Reply-To: <1305495440-30836-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173677>

On Sun, May 15, 2011 at 23:37, Johan Herland <johan@herland.net> wrote:
> Here's the next iteration of what started out as a simple patch to le=
t
> the server refuse pushes that exceeded a configurable limit on the
> #objects in a pack.
>
> The current patch series allows limiting pushes by
> =C2=A0- size of pack
> =C2=A0- #objects in pack
> =C2=A0- #commits in pack

=46WIW I'd find this very useful. I recently spent a fair amount of tim=
e
cleaning up the mess created by a user pushing all the tags from
repository A to repository B (don't ask), the options you've
implemented here would have stopped that.

And as you point out even if you refuse these sort of things with a
hook (which I later implemented) that doesn't stop the server from
accepting the objects and keeping them around.
