From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix "next" link on bottom of commit log page
Date: Fri, 30 May 2008 01:12:49 -0700 (PDT)
Message-ID: <m3y75s1a9v.fsf@localhost.localdomain>
References: <20080529181003.1249.qmail@b35f4f9e60eb05.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri May 30 10:13:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1zkG-0001lG-87
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 10:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYE3INA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 04:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYE3IM7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 04:12:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:4130 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbYE3IM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 04:12:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so67793fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=fYvaNvRjvoFZy4pJrf7en5TJmR08NC0bEr9mFvk+s0o=;
        b=EMRMdP1OzIbB0PyJFrUvU7ZNTuxa/YLmAwS1XxJTzwBPUUIwDEwkWN+YWFadcNSmCWaD9J1jLfLI/Bfi5MRZJkQ+kq+51isrXCz7fPmodK8eIb0z5+FaPg3HytufU9or51CQ//qeQIWy0AtQ/j0rkXiAEmmw5lhBGQSuPJHsT0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=CfzfzVNcNSuJSOkiFL2guGVf0jQiAJZPznFjn2UWZQMXtzcX14P/wNcVyeVs/47540KiERn+t9GRs2RDMY207ysqc5Jl/vffm5+mYn3MhHVQbFqxQVLZcLalpeJf7mChNVrYBu7HFL3QmsU++Ni2agEE5Pf+Wulh6TeWuTvVz24=
Received: by 10.86.29.19 with SMTP id c19mr467149fgc.28.1212135175866;
        Fri, 30 May 2008 01:12:55 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.197.146])
        by mx.google.com with ESMTPS id d4sm253513fga.4.2008.05.30.01.12.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 01:12:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4U8C3G7022222;
	Fri, 30 May 2008 10:12:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4U8BfnC022218;
	Fri, 30 May 2008 10:11:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080529181003.1249.qmail@b35f4f9e60eb05.315fe32.mid.smarden.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83276>

Gerrit Pape <pape@smarden.org> writes:

> When viewing a gitweb repository commit log, the "next" link at the top
> of the page works as expected, the "next" link on the bottom of the page
> has a=search instead of a=log and thus fails to get you to the next
> page.  This commit replaces the bottom "next" link with the same links
> as shown at the top of the page.

> -		print $cgi->a({-href => href(-replay=>1, page=>$page+1),
> -			       -accesskey => "n", -title => "Alt-n"}, "next");

Should not happen: href(-replay=>1, ...) should have the same value
of 'a' parameter as the page it is in, so it should be 'log' not 'search'.

Will investigate.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
