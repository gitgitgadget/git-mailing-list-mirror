From: "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?=" 
	<avarab@gmail.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Tue, 18 Dec 2007 21:10:28 +0000
Message-ID: <51dd1af80712181310q38255593t989be64799be2e0e@mail.gmail.com>
References: <87wsrhex4c.fsf@cpan.org>
	 <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
	 <7vir31u210.fsf@gitster.siamese.dyndns.org> <877ijhm1b5.fsf@cpan.org>
	 <46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
	 <46a038f90712181238p7529a02bmde21c89956a3f641@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?=" <avar@cpan.org>,
	git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:11:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jif-0005yX-3A
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbXLRVKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbXLRVKb
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:10:31 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:16342 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXLRVKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:10:30 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1380771nze.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 13:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7pSGm0sBbxr/74q8TbaWbYeK3ITDupkUwOzRJ9jRV1o=;
        b=x4E0U35f/yRsQudnss08OQdKX+srOkM/9gMLBpBSfHQO6mlZKYkPxGryn9UzJ393R8gtHSFzqor5NZkyX+FQMbGoz97PrZn5OVWpZ/ygKLkDUx7fhqnEZhFYa/+OWuufY+9DFfwXbM/IxgdGrfmEiVIEWVrwVfyUzVltXojGtS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DJ69ogJh9eQqbp1psAi19Zq0M8OVbNUWTAVcj1+GutTpJSKs+RIM/3+EVAqvn6y+bo9ZKcX1tTDCshtkz/aaivZF8ywRger3CqQHDhRKaeHyNfXU4o3SwQi+eecO6LA0LY2EgEAErXZ4dPayg1rzMJEWp/0zrtexafw8NciRM2o=
Received: by 10.142.253.21 with SMTP id a21mr1243832wfi.168.1198012228998;
        Tue, 18 Dec 2007 13:10:28 -0800 (PST)
Received: by 10.142.241.19 with HTTP; Tue, 18 Dec 2007 13:10:28 -0800 (PST)
In-Reply-To: <46a038f90712181238p7529a02bmde21c89956a3f641@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68816>

On Dec 18, 2007 8:38 PM, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On Dec 18, 2007 10:41 PM, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >  - git/config is very likely to be readable if the site is served via
> > other means, like dumb http protocol, or git+ssh. So even if the
> > password scrambling is mickey-mouse. it might make sense to force the
> > password data to live elsewhere.
>
> On this aspect, I see no reason why we wouldn't have the passwords
> crypt()ed or SHA1'd. Perl includes crypt() in the default
> distribution, so it wouldn't add any dependency.

It also includes Digest::SHA in the default distribution as of today:)

I could add another option for allowing users to choose their password
storage, e.g.:

[gitcvs]
    password_storage = plaintext # or sha1, crypt, ...
