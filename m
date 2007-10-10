From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 23:45:46 +0200
Message-ID: <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
	 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
	 <20071010213925.GB2963@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: hanwen@xs4all.nl, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:47:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjOd-0003kw-5y
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765AbXJJVpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756976AbXJJVpy
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:45:54 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:52677 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbXJJVpr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:45:47 -0400
Received: by rv-out-0910.google.com with SMTP id k20so306434rvb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vgH5yRzF/tsN6EfAxs0Cdk1EJVr6zTbSYjnIQiktRj4=;
        b=E+oENwr/DfqCi0ld4A8Pw01UTAi7ej0b1Hm/MiQKOWoWjciv69DtWfd2hsbLp5NPpu4BSQN08RSkZe49BjFsjEyecs3uFUy6w5CwDgYW27Gc89Yc5Pe0V1OYkUOzH5UHU2HWyjpzHUYM9SbGL/VeaWCAobELZw8VcQ3iw7HXGXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mGMih2aqnTCdk1sGQSCkVjEwhl3MCLdsUKD6zC7uh5XR+Nvsp/kpzha1V4wMyYIpz1Gf+oWn0eTcHYYo7/o0F2b2HxaA5bqTxI1c53DakPINfQKTiltIfXOY/nzqFjjllbRdp3jtKD6IpnJq8R4znVJufhdJRXMsGYrHiS8AV9I=
Received: by 10.115.55.1 with SMTP id h1mr1313900wak.1192052746197;
        Wed, 10 Oct 2007 14:45:46 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 10 Oct 2007 14:45:46 -0700 (PDT)
In-Reply-To: <20071010213925.GB2963@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60553>

On 10/10/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Wed, Oct 10, 2007 at 06:30:02PM -0300, Han-Wen Nienhuys wrote:
> > could it be that GC does not handle cyclic alternates correctly?
>
> Does it handle alternates at all?  If you run git-gc on a repository
> which other repositories get objects from, then my impression was that
> bad things happen.
>

AFAIK 'git gc' is safe, while 'git gc --prune' will remove loose
(unreferenced) objects.

-- 
larsh
