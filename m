From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Fri, 16 May 2008 11:19:06 +0100
Message-ID: <e2b179460805160319n420c309eg9b9bbb1e3adb299@mail.gmail.com>
References: <1210149355875-git-send-email-mike@abacus.co.uk>
	 <4821992F.4060201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 16 12:20:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwx2f-0000XL-5n
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbYEPKTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753238AbYEPKTJ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:19:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:31370 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbYEPKTI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:19:08 -0400
Received: by rv-out-0506.google.com with SMTP id l9so106791rvb.1
        for <git@vger.kernel.org>; Fri, 16 May 2008 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m4NVI5K95A+YluWLMcnmremc5mQhG4TM6q67vzeaHeA=;
        b=ZMjRgkNYXPIF2hNh2avT3zyMyAkDcdlWsIoEziqQJ+swYxcwrO36bpIxTq5tfL6EYJLKbIEvuvCrESqOfkHbGsJA8te2dCHACX+cXgs3wrPlDrWRI9JyBjSm9wZeOzsIRMu9cLt7uuNiwRW9qAv5+9Vl3QTIkU/RHwULO0t8hPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SAe0/cRnbpaRUjMxWe7tPK73ez3XPzvktJ11HSqr3c/UuS7crUg9Ltyyj/pg5avI7u038D1kMmKjZzRGpd6WVOpT62OgeJ+iMoIn/HftrNoWtlvOl8IkQMUnal0C2Rz1u84/d5mXla7vj/6Fawpo+jOEq64sEaJWvlfaLujhVfE=
Received: by 10.140.140.3 with SMTP id n3mr1673009rvd.299.1210933146342;
        Fri, 16 May 2008 03:19:06 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Fri, 16 May 2008 03:19:06 -0700 (PDT)
In-Reply-To: <4821992F.4060201@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82264>

2008/5/7 Johannes Sixt <j.sixt@viscovery.net>:
> Mike Ralphson schrieb:
>> NO_MKDTEMP is required to build, FREAD_READS_DIRECTORIES and the definition
>> of _LARGE_FILES fix test suite failures and INTERNAL_QSORT is required for
>> adequate performance.
>
> I'm trying this patch on AIX 4.3.3 (sigh!) with gcc3...

Now the interaction between FREAD_READS_DIRECTORIES and _LARGE_FILES
has been sorted out, and the
wt-status.h warning fix is also in, did you manage to finish testing
this? The INTERNAL_QSORT gave me a 2 orders of magnitude speed up on
git status / commit etc.

I should have mentioned that I build with SHELL_PATH = /bin/bash and
ensure that /usr/linux/bin (or /opt/freeware/bin) from the AIX toolbox
is prepended to the PATH to run the test-suite. I didn't want to fold
these into the patch as the paths are somewhat environment specific.

Mike
