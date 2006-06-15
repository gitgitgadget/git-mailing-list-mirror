From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Thu, 15 Jun 2006 11:40:50 +0000
Message-ID: <f36b08ee0606150440l544455c7r5c52609b360d0f74@mail.gmail.com>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	 <8aa486160606150426q19b0a661s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 15 13:41:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqqDX-0005W2-5O
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 13:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWFOLkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 07:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWFOLkw
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 07:40:52 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:12393 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030242AbWFOLkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 07:40:51 -0400
Received: by py-out-1112.google.com with SMTP id i49so256160pye
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 04:40:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VNpe1QgnD1xSVAdRCYfyodURQnI/J6SFR9xCG4q3uJugAWvnMkqkCuQfUh02eZNB1xxiz4xIObNEszN7/TJTzTJr8Nn+vpUynpX0F8QqHBjq34JXH9xXaQTQoiITnq2ASlAxqFZx6xuDp9Pueh6sP7OW5zRQ/AnUl4NreAy1zsg=
Received: by 10.35.21.1 with SMTP id y1mr2782965pyi;
        Thu, 15 Jun 2006 04:40:50 -0700 (PDT)
Received: by 10.35.14.20 with HTTP; Thu, 15 Jun 2006 04:40:50 -0700 (PDT)
To: Santi <sbejar@gmail.com>, git <git@vger.kernel.org>
In-Reply-To: <8aa486160606150426q19b0a661s@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21890>

On 6/15/06, Santi <sbejar@gmail.com> wrote:
> Wed, 14 Jun 2006 22:26 +0300, Yakov Lerner <iler.ml@gmail.com>:
> > Many times, I mistakenly used 'make prefix=... install' where prefix value
> > was different from prefix value during build. This resulted in broken
> > install. This patch adds auto-detection of $prefix change to the Makefile.
> > This results in correct install whenever prefix is changed.
>
> I do this each time I install packages from source. I keep them with
> "stow" and the usual sequence is:
>
> make prefix=/home/santi/usr
> make install prefix=/home/santi/usr/stow/git
> cd /home/santi/usr/stow/
> stow -v git
>
> so with this auto-detection I'll compile some programs twice.

I'm not familiar with stow. Does stow create some kind of symlinks from
/home/santi/usr/stow/git to home/santi/usr ? If so, why can't you
use prefix=/home/santi/usr/stow/git both in 'make' and in 'make install' ?
Would this work ?

BTW, is it possible to have git use argv[0] to automatically determine
the executable_dir without compiled-in paths ?

Yakov
