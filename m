From: "=?ISO-8859-1?Q?R=E9mi_Vanicat?=" <vanicat@debian.org>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Sat, 19 Apr 2008 00:13:50 +0200
Message-ID: <6b8a91420804181513m139baf06x41d8efeb7acd49a3@mail.gmail.com>
References: <87od88eslq.dlv@maison.homelinux.org>
	 <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org>
	 <6b8a91420804170844t2776e8a7sf735e3f87a95298b@mail.gmail.com>
	 <7vskxjj9rb.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.10.0804181135540.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 08:55:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmyqv-0004aD-0A
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 00:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYDRWNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 18:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbYDRWNy
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 18:13:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:18726 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYDRWNx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 18:13:53 -0400
Received: by fg-out-1718.google.com with SMTP id l27so655383fgb.17
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=/TQirtn6NO9miuVv6BcCi4kvYYtOBaoPp69ccXtl0Xs=;
        b=L2bAuxYRRK8uPfpbRKJq3K3qg6C8S2k9jTi3aTXgBTYVARHsT5wCWUGgt4lkznWTS9bMTrY2qnJNxqVM3CgzUwZ1lOp+No9+K/77wZJubpGgRER17pp8NOUxgxdJlb4y4TeCfafAUpjJrCbcACFVUigo6HMXv5E0fbl5GBbzqxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=qCCWqRnH1OI8kW3Bnk/NsZDTdkLvFbf0vvSiHtbLjXKS8z33LURM8JWev9Iblp8L5BHYgdDd8AnswTFxHYhMeBc+o4HemT59QKjJDzOppNHv2H0GD72nmVjLpWV72YgXmavK/929TRZJ1xOKhO+aK+kxd3Q85POxcqTpl7qJtk4=
Received: by 10.86.91.12 with SMTP id o12mr6228446fgb.72.1208556831225;
        Fri, 18 Apr 2008 15:13:51 -0700 (PDT)
Received: by 10.86.84.17 with HTTP; Fri, 18 Apr 2008 15:13:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0804181135540.2779@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: be9fa73ac9e8166b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79873>

2008/4/18, Linus Torvalds <torvalds@linux-foundation.org>:
>
>
>  On Fri, 18 Apr 2008, Junio C Hamano wrote:
>  >
>  > -             (echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
>  > +             (printf '%s\n' "$SUBJECT" ; echo ; cat "$dotest/msg") |
>
>
> Well, get rid of the superfluous second 'echo' then too, replacing it
>  with another '\n'. IOW:
>
>         ( printf '%s\n\n' "$SUBJECT" ; cat "$dotest/msg" ) |
>
>  instead.

This work for me: no more test failure on my computer
