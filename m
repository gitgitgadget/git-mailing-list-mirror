From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 12:47:31 +0300
Message-ID: <37fcd2780903030147q7062ee47w7ce524c28a6aa347@mail.gmail.com>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
	 <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
	 <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
	 <200903021530.01165.trast@student.ethz.ch>
	 <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:49:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeRFD-0005hI-AA
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbZCCJre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 04:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbZCCJre
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:47:34 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:35569 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZCCJre (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 04:47:34 -0500
Received: by fxm24 with SMTP id 24so2352067fxm.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 01:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S7bMZ8QK47L7TAmwy29LHp+wNxhK1l9KZbB4938VKeA=;
        b=soG0xXdWV1h1sFd4CytzISkdVIv+zQL8URKTdOWhFXPskv/pa8FsDN2umlEdPARMr+
         ga7jjlg9sDe/NWsPJ2G1ilRVXHpDPUlAvruN62jppQBwP0DLaSJL69504wZRbazeVbnI
         sPe31fCtGoy6Tg92ME6g33YlK22PKlLmSK+s8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gH83kztNF3DHlIXbDzsxPtcOBaKo7pt4E6NzfEmCydsQeZc5WmZz9YnhlcnEpinxgK
         ikJhP5znBfW96mPTsZE7NTY446fOCkpjhAtTFWUKcbNkIya3EQ/Y5KXIevAi3Yyh2ojC
         d2rAl43CcquEPJSDOIwJ1JFYnawW3kBPUGUUE=
Received: by 10.86.53.11 with SMTP id b11mr4214983fga.70.1236073651252; Tue, 
	03 Mar 2009 01:47:31 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112044>

On Mon, Mar 02, 2009 at 09:41:57PM +0100, Peter Krefting wrote:
>
> In most cases, I would most definitely agree with you on calling it that,_
> but when it comes to Unicode support, Windows is one of the least broken__
> OSes (with Symbian being my favourite).

The C Standard requires that the type wchar_t is capable of representing
any character in the current locale. If Windows uses UTF-16 as internal
encoding (so, it can work with symbols outside of the BMP), it means you
cannot have 16-bit wchar_t and be compliant with the C standard...

Dmitry
