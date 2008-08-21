From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Bug/problem with 1.6.0 on UnixWare
Date: Thu, 21 Aug 2008 12:35:53 +0100
Message-ID: <e2b179460808210435w31b911a5ie6059b5628db8138@mail.gmail.com>
References: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Boyd Lynn Gerber" <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 13:37:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW8TL-0002ey-1V
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 13:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbYHULfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 07:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYHULfz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 07:35:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:46728 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbYHULfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 07:35:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so900780rvb.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rNO9UOx4RPYco0yb9L7X13BAq4iub6tpl81ALVYyyNE=;
        b=Ubr3hvNns+MzmLtzvlsJaMeIn8+dtHN8uLWWzU0jk6V9LK1ClCb1Oa5mqU8xQqwKuL
         RgPQRgMNkBZPrJtUnwmSN9phhSLAYWl8JkDc4gW7dt7TnmcIhM/ae8lD3xo/zH8yKBIU
         CNiyNOHd0vfPDkpTnMqpZAh7SBsTzDHd7wnV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T+PEDk+0BFh9i38E1eUSqGKE3uk44u6aeJYps3dw1zlZF+hwWAyoIQ9UITjqHUgRtZ
         NIkK7s1jQncHHaKZKnn5Yr06E24tCRpJhG9PEpghHsVK+Qs/KRYiVtkO5CeBe0jXnfLP
         T4gVjBC/1P7r0yG9KCr4sn6ij33yLmlyr4oeg=
Received: by 10.140.201.15 with SMTP id y15mr656784rvf.33.1219318553966;
        Thu, 21 Aug 2008 04:35:53 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Thu, 21 Aug 2008 04:35:53 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93138>

2008/8/21 Boyd Lynn Gerber <gerberb@zenez.com>:
> I am having the same problem on UnixWare as I have with the SCO OpenServer
> 6. trying to build git-1.6.0.
>
> Here is the error.
>
>    CC shell.o
>    AR compat/lib.a
>    LINK git-shell
> Undefined                       first referenced
> symbol                              in file
> hexval_table                        abspath.o
> null_sha1                           abspath.o
> trust_executable_bit                abspath.o
> has_symlinks                        abspath.o
> UX:ld: ERROR: Symbol referencing errors. No output written to git-shell
> gmake: *** [git-shell] Error 1

I think you've hit the problem described here:
http://article.gmane.org/gmane.comp.version-control.git/92945/match=git+shell

Junio's revert of the offending commit is I think in the 'next' branch.

You could also look at reverting 5b8e6f85f97 locally?

Cheers, Mike
