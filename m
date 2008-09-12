From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] submodule.*: Introduce simple C interface for submodule lookup by path
Date: Fri, 12 Sep 2008 14:35:54 -0700 (PDT)
Message-ID: <m3hc8lnj4k.fsf@localhost.localdomain>
References: <20080912210817.31628.69014.stgit@localhost>
	<20080912210857.31628.7605.stgit@localhost>
	<7vsks5njmg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 23:37:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGKB-00041y-H6
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 23:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYILVf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbYILVf6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:35:58 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48947 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbYILVf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 17:35:58 -0400
Received: by gxk9 with SMTP id 9so20383836gxk.13
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ExrLNqHdRZA7p+uQT1iHPYG9i1TE9hKlMugMaxj7Ja0=;
        b=Wsm4MYYIJJlV7h+287JH6+sosmdrK903X+S4yHuxH8Dot6z7fVMqA8X/64WOW0SajD
         xjS4VkzVGlOmPBnPiarEoo3Mpgz6JEi2XLoO507OjAyzb86U0trsV+sFRBRPCzVOuDCk
         KScHV7A2ClzIxWvD3id43duKksI+p+gy3iZtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=jqABE/VXDkbKh6wOEjnUyRsaDvjrimLdtqmLFdQOtWJROzFB3qfB2X1olGknJkH7xI
         ARVQ9Goa3ky9iGZ+u1D5Q3FtPyxkKAseM7y4wRQyHgFjSw7k+jbc2zJUqYNByPHKpt1Z
         cGx/m2pz9AtfwTidSOOU9kwCMMbG7M8TXsfTs=
Received: by 10.103.214.13 with SMTP id r13mr3390092muq.4.1221255355657;
        Fri, 12 Sep 2008 14:35:55 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.228])
        by mx.google.com with ESMTPS id y2sm8292789mug.2.2008.09.12.14.35.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 14:35:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8CLZ3n4021444;
	Fri, 12 Sep 2008 23:35:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8CLYakl021436;
	Fri, 12 Sep 2008 23:34:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vsks5njmg.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95771>

Junio C Hamano <gitster@pobox.com> writes:

> Petr Baudis <pasky@suse.cz> writes:

> > +{
> > +	struct gitmodules_info *info = info_;
> > +	const char *subkey;
> > +
> > +	if (prefixcmp(key, "submodule."))
> > +		return 0;
> > +
> > +	subkey = strrchr(key, '.');
> > +	if (!subkey)
> > +		return 0;
> 
> This cannot happen; you made sure the thing begins with "submodule."
> already.
[cut]

Are there any api to access and manipulate configuration,
including fqvn with the subsection part, instead of having
to do this again and again?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
