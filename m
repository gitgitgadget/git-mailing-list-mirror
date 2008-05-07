From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-grep: Add ability to limit directory recursion
Date: Tue, 06 May 2008 17:34:48 -0700 (PDT)
Message-ID: <m3iqxr54uy.fsf@localhost.localdomain>
References: <1210094304-2450-1-git-send-email-aidan@highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Wed May 07 02:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtXdG-0002lg-He
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 02:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbYEGAex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 20:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752792AbYEGAex
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 20:34:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:61830 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbYEGAev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 20:34:51 -0400
Received: by ug-out-1314.google.com with SMTP id h2so484035ugf.16
        for <git@vger.kernel.org>; Tue, 06 May 2008 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=M9QrG9CHqb59X03oe3VcqH9Wr59aLIPfJ5ozrDQAvS4=;
        b=kmabGapP1hbr/DhnyMMdOxNQINZ5pSJHfSwcFYVJpZAk6L7AB79n9lPg9OdJMONvRi1sddJp3pZtDMxiQLW9emAvHc0+xo5izsGNgntHNXUzR5W/it5XDn2j6/nlYevPnlBQQCSqKzSYb3JOzmqsoRdvtDLsc3j22cUuhkiFCUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ckFfMVrnr/jbQo39+Ayu31aS6wc0OCTX06npQXHpt5lyagE/mVYM9eb2cLcvpjabJrGEQPeQ4xv3m0gGZRlvMWKvbGyInZMW94b3I6CeTQmmuLHipfdi64sxhNF0E8lKJsIkdI0l5lBhNjHWpfFAPwZ90u0H+s8Zj/nqLRhzuLE=
Received: by 10.66.239.16 with SMTP id m16mr6785632ugh.28.1210120489912;
        Tue, 06 May 2008 17:34:49 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.194.224])
        by mx.google.com with ESMTPS id g12sm1947345nfb.28.2008.05.06.17.34.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 May 2008 17:34:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m470YnU2022325;
	Wed, 7 May 2008 02:34:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m470YjWZ022322;
	Wed, 7 May 2008 02:34:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1210094304-2450-1-git-send-email-aidan@highrise.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81393>

Aidan Van Dyk <aidan@highrise.ca> writes:

> This add a -R <limit> option to git-grep which will limit the depth of the
> directories recursed when git is doing a grep.
> 
> This allows you to do something like:
>         git grep -R 1 <pattern>
> and see only the results of the grep on files in the current directory.
> 
> It defaults to a limit of "0" which disables the limiting.

Nice idea, although I'm not sure if we shouldn't borrow "-maxdepth"
option from GNU find and friends...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
