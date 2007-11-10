From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: gitweb, updating 'last changed' column on the project page
Date: Sat, 10 Nov 2007 09:10:05 -0500
Message-ID: <9e4733910711100610y478c62cend1d9af84e0ecc08b@mail.gmail.com>
References: <9e4733910711091709k173bf23flf2824673f82de9bb@mail.gmail.com>
	 <200711101034.47861.jnareb@gmail.com>
	 <9e4733910711100505n78459612xdaa12eaa880773d8@mail.gmail.com>
	 <200711101427.18215.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 15:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqr2X-0003Nd-FJ
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 15:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXKJOKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 09:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbXKJOKH
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 09:10:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:27727 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbXKJOKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 09:10:06 -0500
Received: by wa-out-1112.google.com with SMTP id v27so944840wah
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HeB5YzRi+FqVTk5195drFCYZwRaZkeRJAgqIyZWISgA=;
        b=jNeqFVXUnW56fyQJgZz/1URoGNMIBCQVQUP9bHbyG9KXI0aaS7yhecvAjP8H8S4Iqfcct7FkUgItYX3nmqqzEEx54aR/OUfjxd4iKvKOYeb6dxqzDqVywFonowX4qTb5Iuc8vafDlXu3G44ilkQvoRYAHN+m1EMEWSWSxtmQCxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YBtTcwuGivYZVwrxNyg39sc2YB5GPcpP+3KZVnj5G/rx4ggw3VFcVT3+yuCR4fSrLys9tq8OKjk97KiwUcSVevKG6U4gskEVb0jFncFcMvtxvguEziLYdK4jT17aTaMZsb+qTYDH+1voQr4IkJWZPUCVRhB4oRDkGsxVQ9DQ4MY=
Received: by 10.115.47.1 with SMTP id z1mr496645waj.1194703805339;
        Sat, 10 Nov 2007 06:10:05 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sat, 10 Nov 2007 06:10:05 -0800 (PST)
In-Reply-To: <200711101427.18215.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64350>

On 11/10/07, Jakub Narebski <jnareb@gmail.com> wrote:
> > It is sorted by committerdate, the sort is ascending. Did you expect
> > it to be descending, pick off the last entry instead of the first?
>
> Excerpts from git-for-each-ref(1):
>
>   git-for-each-ref [--count=<count>]* (...) [--sort=<key>]* (...)
>
>   <count>
>           By  default  the  command  shows all refs that match <pattern>. This
>           option makes it stop after showing that many refs.
>
>    <key>  A field name to sort on. Prefix - to sort in descending order of the
>           value.  When  unspecified,  refname is used. More than one sort keys
>           can be given.
>
> So I expect --sort=-committerdate to sort by date of committing,
> descending, and --count=1 pick first one, which means most recent.

git has a bug, it is not implementing the - prefix. I am using git head.

jonsmirl@terra:~$ cd mpc5200b
jonsmirl@terra:~/mpc5200b$ git for-each-ref
--format="%(refname):%09%(committer)" --sort=-committerdate refs/heads
refs/heads/m24: Jon Smirl <jonsmirl@gmail.com> 1191362799 -0400
refs/heads/m25: Jon Smirl <jonsmirl@gmail.com> 1191472422 -0400
refs/heads/m26: Jon Smirl <jonsmirl@gmail.com> 1194382038 -0500
refs/heads/m28: Jon Smirl <jonsmirl@gmail.com> 1194385071 -0500
refs/heads/m29: Jon Smirl <jonsmirl@gmail.com> 1194674673 -0500
jonsmirl@terra:~/mpc5200b$ git for-each-ref
--format="%(refname):%09%(committer)" --sort=committerdate refs/heads
refs/heads/m24: Jon Smirl <jonsmirl@gmail.com> 1191362799 -0400
refs/heads/m25: Jon Smirl <jonsmirl@gmail.com> 1191472422 -0400
refs/heads/m26: Jon Smirl <jonsmirl@gmail.com> 1194382038 -0500
refs/heads/m28: Jon Smirl <jonsmirl@gmail.com> 1194385071 -0500
refs/heads/m29: Jon Smirl <jonsmirl@gmail.com> 1194674673 -0500
jonsmirl@terra:~/mpc5200b$ git --version
git version 1.5.3.5.1651.g30bf
jonsmirl@terra:~/mpc5200b$


>
> It looks like "your" gitweb sorts ascending instead... strange...
>
>
> How does git_get_last_activity subroutine in your gitweb.cgi looks like?
> Does it have '--sort=-commiterdate'? If it has, then I think it is some
> strange bug in git, if it doesn't it is strange modification of gitweb.
>
> HTH
> --
> Jakub Narebski
> Poland
>


-- 
Jon Smirl
jonsmirl@gmail.com
