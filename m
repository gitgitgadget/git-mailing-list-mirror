From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 02:15:34 -0700 (PDT)
Message-ID: <m33aqxzknl.fsf@localhost.localdomain>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:17:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ0bP-0008DX-1Z
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758395AbYCKJPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756495AbYCKJPo
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:15:44 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:14012 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758385AbYCKJPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:15:42 -0400
Received: by py-out-1112.google.com with SMTP id u52so3427697pyb.10
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=xPFiplHm/KNJvmCQCgE56HHQoJqtNr61q8vuSV+OA24=;
        b=l9iDZ0Qg0KjBBc6i/l1dq0eYj6HjkAbh4qIf4Yw3pycS7H584HWa1icj3mjcuaUrgiMfq9sj3uw17M3/s7DlS6UJUYtNR28VmLltlU+z4PSgbGERtg4eOdHPborDuYSSxipSg4er4ZI5QjUu1J+gq/uik7QxHnB8fiNp3jzMWEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=I95bdnhk0OUoa1psScrh1Oxx/mqwLZAf0ex1WNP7qKPeFDoe2ouplaWi7KXyQ+uwXZZvUzojRSMqfaBCSWPNSIYcPJPG+5g0/qu1+DrT+t6HsxOKO8NonLC4Pz6KSFKCI50y7TK0xvY+J0huUto6F4E+1sv6BWoCljCrHh+jtzw=
Received: by 10.64.249.20 with SMTP id w20mr12586832qbh.24.1205226937471;
        Tue, 11 Mar 2008 02:15:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.230.40])
        by mx.google.com with ESMTPS id r38sm10011025ugc.55.2008.03.11.02.15.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Mar 2008 02:15:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2B9FToF002763;
	Tue, 11 Mar 2008 10:15:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2B9FQg1002760;
	Tue, 11 Mar 2008 10:15:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76817>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> +FAST FORWARD STRATEGIES
> +-----------------------

I think this should be named FAST FORWARD OPTIONS or something like
that.

> +
> +allow::
> +	Do not generate a merge commit if the merge resolved
> +	as a fast-forward, only update the branch pointer.
> +	This is the default behavior of git-merge.

This is equivalent of current '--ff'; perhaps this should be mentioned
as well in this option description.

> +never::
> +	Generate a merge commit even if the merge resolved
> +	as a fast-forward.

This is equivalent of current '--no-ff'; nevertheless I think that it
would be better to name this strategy 'commit' or 'merge', as in
--ff=merge, or --ff=commit.

> +only::
> +	Only allow a fast-forward.  The merge will fail
> +	unless HEAD is up to date or the merge resolved as
> +     a fast-forward.

This is equivalent of '--ff-only' or '--strategy=ff'... Errr...
I'm sorry, such option does not exist, and it would be I guess
useful addition to default non '+' fetch refspec allowing fast-forward
only, and to receive.denyNonFastForwards to control push behavior.


>  --no-ff::
>  	Generate a merge commit even if the merge resolved as a
> -	fast-forward.
> +	fast-forward.  --on-ff is an alias for --ff=never.

Typo: '--on-ff' instead of '--no-ff'.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
