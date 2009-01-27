From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH/RFC v1 5/6] combine-diff.c: remove a call to fstat() 
	inside show_patch_diff()
Date: Tue, 27 Jan 2009 12:06:52 +0000
Message-ID: <e2b179460901270406i3425b99pb412536ce28fb44d@mail.gmail.com>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
	 <1233004637-15112-6-git-send-email-barvik@broadpark.no>
	 <e2b179460901270135j6e4cb887radbe664ac98f39f1@mail.gmail.com>
	 <86myddj6qi.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Jan 27 13:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRmjq-0003qO-Gv
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 13:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbZA0MGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 07:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbZA0MGx
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 07:06:53 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:45115 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbZA0MGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 07:06:53 -0500
Received: by qyk4 with SMTP id 4so7152915qyk.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 04:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JGSacNdRDqhGgNcTsBCIvjmJuD5felVPSr4TyDXfChg=;
        b=fBwOhiJAS3VoEJ6/XQDEskrC5aFic3i4XGfdnhcaVeAj3/l36jGrszaW8XWGROv9D3
         UJe5JZv02CDnQDQRP9qTVrxEYsaOHNnGQxFd4Xq5qC3pUwZjA2fEM0MldADM9QRWqBx1
         7dL/nL4Y8Sxr89duVENHMb1Byey/4rqTirexU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LvjfRUGCiZfpGfjCCrWMHntPtoFUK9trBBaiIgALqQKEmy2/a6c2c5k9Hj5I/R40Ug
         sRSTw+0QtyG7PepDKQeAS2q1fM+j0Pet54x/FIEZ2cedaHqVbeKcvmcZCrWBONKvk9e/
         VaJYXiPegndYqyTXY2RT7ji6C2J5WWxuryVbo=
Received: by 10.214.46.20 with SMTP id t20mr4249325qat.103.1233058012100; Tue, 
	27 Jan 2009 04:06:52 -0800 (PST)
In-Reply-To: <86myddj6qi.fsf@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107336>

2009/1/27 Kjetil Barvik <barvik@broadpark.no>
> Mike Ralphson <mike.ralphson@gmail.com> writes:
>
> > 2009/1/26 Kjetil Barvik <barvik@broadpark.no>:
> >> Currently inside show_patch_diff() we have and fstat() call after an
> >> ok lstat() call.  Since we before the call to fstat() have already
> >> test for the link case with S_ISLNK() the fstat() can be removed.
> >
> > s/have and/have an/ ?
>
>  Correct! Will fix.  Thanks!

Typo stood out and blinded me to the rest of the grammar... How about:

Currently inside show_patch_diff() we have an fstat() call after an
ok lstat() call.  Since before the call to fstat() we have already
tested for the link case with S_ISLNK(), the fstat() can be removed.

'Half-a-job' Mike
