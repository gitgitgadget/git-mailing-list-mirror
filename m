From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 18:23:58 +0200
Message-ID: <bdca99240908180923x49213f30q79cf9424c6aa8202@mail.gmail.com>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
	 <4A8AA511.1060205@gmail.com>
	 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
	 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.01.0908180836440.3162@localhost.localdomain>
	 <alpine.LFD.2.01.0908180906441.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRTi-0006wn-RY
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbZHRQX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbZHRQX6
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:23:58 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:54012 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZHRQX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:23:58 -0400
Received: by fxm11 with SMTP id 11so388845fxm.39
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HHrFT8yuni9BrSZq3yTqfPCrBRIqfVWxvWLBjkwcPOM=;
        b=acYpoGamn/7c5ZHNi48H3xQSAGV1lVdosOQlhpKf4oKVxSRG1KHLddFS8BY/6KRQav
         pGtsiIeSnhcMFsCNs/2MzQ2lk/OwqOuRITBrAwEciv5KzpYrdgWZiJapsaZ5cm8xoihs
         4+PjITdzTLQ3V6bTqNAcdFT3f7HIkfj7WAWc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JwToXbfgo9xKc0+aVolQWfPBNyBYe7cUne/dGSPpKRQKzfWTwX5zMYMa+NSJVrEX0Z
         7u6b6VIDLm2wztpMrKtPjw4anAo0gs1I6Bv4TLBQuRFY53NM0QkVja9t/jxSe7wJrjts
         nb043CojH2gUBnZhaet0IVeRnjVMPPpKeW1sM=
Received: by 10.204.157.16 with SMTP id z16mr3934798bkw.103.1250612638194; 
	Tue, 18 Aug 2009 09:23:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0908180906441.3162@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126409>

On Tue, Aug 18, 2009 at 18:08, Linus
Torvalds<torvalds@linux-foundation.org> wrote:

>> I'd suggest not using a gcc builtin, since if you're using gcc you might
>> as well just use inline asm that has been around forever (unlike the
>> builtin).
>
> That seems to be what glibc does too.
>
> Here's a patch.

Looks good to me, compiles & runs fine on Windows (with Hannes' patch
also applied).

-- 
Sebastian Schuberth
