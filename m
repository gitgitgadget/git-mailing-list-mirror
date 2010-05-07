From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 15:11:21 -0400
Message-ID: <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 21:11:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OASxg-0006rh-Bj
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937Ab0EGTLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:11:43 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:57223 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799Ab0EGTLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:11:42 -0400
Received: by ywh36 with SMTP id 36so823376ywh.4
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eVinV3OR2I877HKW4dgoZ5rzF8GoYNUcKADq7OhW06s=;
        b=whWdQrW8mGnpGkZrNv3YJxYgVw2su8tYIZublihN9K7w+J5f+jZ2Zyk6msGR1lQo/r
         E00Z1ftaPClLK0y+KMmuFCxBw5L7xoXJIWDa2iId35RZfMyeE2Wxr8w8kOPWignST0vX
         cluJkZX9/2W56J9DRmvUfjQYb9Cfyt0muQJuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jLt1TKlf6Onp4sB9YtJGUBVmTE0Kb1Zv5igmu28bGLce5bQ/evkkmv1iVDk65dgAQD
         yNX2qIrW8hyhj1QTpk7t2Sd/khbiy3Wfbq29ycnc8ha2nyDASiy4d9WNS4E2tAihD9GV
         uDLvTwRKt9SJkHijlD3OnkOue2OU5x3Xkgfw4=
Received: by 10.150.214.17 with SMTP id m17mr4678497ybg.74.1273259501863; Fri, 
	07 May 2010 12:11:41 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 12:11:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146557>

On Fri, May 7, 2010 at 3:02 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Btw, another option might be to start searching ".gitconfig", but onl=
y
> allow a certain "safe subset" of config options in that. Things that =
can
> really be about the project itself, and not per-user or per-repositor=
y.
> [...]
> Things like
>
> =A0 =A0 =A0 =A0core.autocrlf
> =A0 =A0 =A0 =A0i18n.commitEnconfig

Unfortunately this option wouldn't be as flexible as Eyvind's current p=
roposal.

What his method allows is to mark some files in a project as "these
should be the native EOL style" and others as "these should be left
alone."  Then each person can set a (usually global) config option
that states what the native EOL style should be.  Like core.autocrlf,
only it wouldn't affect projects without crlf attributes (like git.git
or linux.git) where CRLF translation is pretty much always wrong.
(And if one person disagrees that it's always wrong, well, he can
always set core.autocrlf for himeself.)

Have fun,

Avery
