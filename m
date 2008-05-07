From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Accessing a single repository with different addresses?
Date: Tue, 06 May 2008 17:33:36 -0700 (PDT)
Message-ID: <m3myn354wy.fsf@localhost.localdomain>
References: <8c0610ed0805060951x70ede89bq5a93e69aece8c8c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Paul Holbrook" <paul.holbrook@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 02:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtXcL-0002V0-2B
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 02:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYEGAdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 20:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbYEGAdj
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 20:33:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21930 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYEGAdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 20:33:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so34054nfc.21
        for <git@vger.kernel.org>; Tue, 06 May 2008 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=/lrtM8Hn1XxCedW+9//P0MvH6GvKmDnIU3E7ha+riXM=;
        b=YMlw+m16eTGZxiM+YhtYZD5EDgcP6VeC1LkLR0mUCk2t6xYkC/rAEJc3DqIG3slVzgAgBqZeLpYhh4t/O91dJC27XwQbwhs+//OQRrSp3x0lxJoRG7hrrHJjlTK1PKxquLDv7YpXH8VuIIWH7ooH3bqdSlA4x1DILQPpu+xKWoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=sNzvascvNu3Z6M9+KTbRGg5BS42eqhP3bLnfe8EFbEtSylFizfzCc6MZ7Pp1jektH6b/c/5HZ8LEs7u3O4nbTEIhu6wkPPlcZ+0AoAK7i8gngG/Fl3gpX+ckoVfFiweALAhiK7jJIs+VflcdSAIRGBPDApiOE0Wwk6TDExTgUh0=
Received: by 10.210.110.5 with SMTP id i5mr1272158ebc.113.1210120417182;
        Tue, 06 May 2008 17:33:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.194.224])
        by mx.google.com with ESMTPS id 32sm1934929nfu.10.2008.05.06.17.33.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 May 2008 17:33:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m470XZlH022314;
	Wed, 7 May 2008 02:33:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m470XY4f022311;
	Wed, 7 May 2008 02:33:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8c0610ed0805060951x70ede89bq5a93e69aece8c8c7@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81392>

"Paul Holbrook" <paul.holbrook@gmail.com> writes:

> I have two machines at home that I've been using to play with git: a
> desktop box and a laptop.  I set up a repository on the desktop, and
> cloned it to the laptop via ssh, but using just a local 192.168.x.x
> address.  However, when I leave the house, I'd still like to be able
> to talk to the desktop repository, which I can still do via ssh back
> to the house - but now the address for that very same repository is
> not a 192 address, but a DNS name.   What's the best way to handle
> this?

If I remember correctly git doesn't (yet?) implements multiple-URL
fetch URIs, where first URL that works is used.

If I understand correctly you want to connect (fetch from) your
desktop machine from your laptop.  And this laptop is either connected
to local network (local IP), or to Internet (DNS address).  The
simplest way would be to create two 'remotes', e.g. dektop-local and
desktop, or desktop and desktop-dns, which differn only in URL used.

In this case url.<base>.insteadOf config variable (new feature)
wouln't help, I think....

-- 
Jakub Narebski
Poland
ShadeHawk on #git
