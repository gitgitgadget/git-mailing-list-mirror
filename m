From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Easy way to empty working tree?
Date: Fri, 21 Jul 2006 09:08:40 +0200
Message-ID: <81b0412b0607210008l45198948sab391a8cf94c7af8@mail.gmail.com>
References: <761519800607201828m19684b2jc267411ef3b8b9e2@mail.gmail.com>
	 <Pine.LNX.4.64.0607201944460.29649@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robin Luckey" <robinluckey@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 09:08:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3p7u-0000Sg-6o
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 09:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWGUHIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 03:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWGUHIn
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 03:08:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:62963 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030463AbWGUHIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jul 2006 03:08:42 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1155401ugc
        for <git@vger.kernel.org>; Fri, 21 Jul 2006 00:08:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gkHWSWEUNR4/sxydG9vAYN9QnJgt1M38ADyPwyyTURXtSH7qftSRvRHTAliRhKdk2WyMgkOtV4PiAHxZtWhaXR+rkaDZ421CpDTqKyyh9BNWP6Coz6T8C7mQp+LSaMQdScN0NM0X0jxzqGYEZh4Uk3Tlcud8y7iS9ipQOUl04z8=
Received: by 10.78.151.15 with SMTP id y15mr180248hud;
        Fri, 21 Jul 2006 00:08:41 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Fri, 21 Jul 2006 00:08:40 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607201944460.29649@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24043>

On 7/21/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > After mothballing the repository with git-repack -a -d and git clean
> > -d -x, is there a convenient one-liner to empty the files out the
> > working directory?
>
> Well, you can do
>
>         git ls-files -z | xargs -0 rm -f --
>

That'd be not enough for kernel after it was compiled.
Maybe this:

   find . -maxdepth 1 -not -name .git -not -name . -print0 | xargs -0 rm -rf --
