From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Use pathexpand to preparse the relative pathnames in blob references
Date: Tue, 18 Dec 2007 13:06:38 -0800
Message-ID: <56b7f5510712181306k13e8b06dt35313e09727a8f59@mail.gmail.com>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	 <20071218204623.GC2875@steel.home> <20071218204752.GD2875@steel.home>
	 <20071218204947.GE2875@steel.home> <20071218205253.GF2875@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>, danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:07:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jea-0004FW-6Q
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbXLRVGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXLRVGl
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:06:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:6734 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbXLRVGk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:06:40 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1460953nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 13:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6R/isgzMMH31x4dSzO5LjbEH/7JDLD8JImUNfv4hxvI=;
        b=B8gKkNIDA5rLFhSn4kbt23oqpIDkf3fZxz5P+uamUgp0DwF+xqrhy28dfEabh6n9OpgzpFsAMu6D78cKzkkpL/pHPbJnwRl9MULdZelRRIrwVyDRxaaAmX2cxUisL4SZu5aBYZ/71XWkFRwuWao2LOzSACLX7T0TIxtWQhlbUX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uNlLFqPmsOU3fHU9pRie61tBdqFqh9iekGFIbCzMGMCiU1/g9Fw8CZSuB4rKs1SWScRbRmUuagjx03DhuIkgPLI5hdPEYVip9j4kBouXpekfr5ArLFH0EjFG8OSfgGBkkvJtCZ1EDm030oQ/lM2YzJvUcYaH00PDarsmyhQms9g=
Received: by 10.78.122.16 with SMTP id u16mr4832543huc.28.1198011998486;
        Tue, 18 Dec 2007 13:06:38 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Tue, 18 Dec 2007 13:06:38 -0800 (PST)
In-Reply-To: <20071218205253.GF2875@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68815>

On Dec 18, 2007 12:52 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> This, OTOH, is a bit intrusive and changes the current behaviour a bit
> too far. git-show cannot use the absolute pathnames in blob locators
> at all now, which I consider bad. An obvious way to use rev:/path is
> blocked by Johannes' get_sha1_oneline. It would have worked, though.

Last May Junio proposed the current :/ should be changed to :?
since it actually searches backwards.  Then :/ would be an absolute path,
and : could default to relative (like Unix command line).

Because of this incompatibility I think he wanted to delay it
until 1.5.6 or 1.6 (see old thread).
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
