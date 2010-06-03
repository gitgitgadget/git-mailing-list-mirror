From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Aliasing with parameters doesn't seem to work properly in git 
	1.7.0.5
Date: Thu, 3 Jun 2010 07:55:36 -0700
Message-ID: <AANLkTikWBzHLCQzC57bZQwCB6MxOYS8R5Y-UBZoh_ndS@mail.gmail.com>
References: <AANLkTilEZknW7m0n3y8SX5oAaZiUTorgqfX3jTB8mnDC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 16:56:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBq3-0001lG-BH
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab0FCO4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:56:02 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59543 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab0FCO4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 10:56:01 -0400
Received: by yxl31 with SMTP id 31so78754yxl.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=6Dtk7T2r51Qb1Fso0ztxglip4KmCMXZfaE5Kcsws4Ao=;
        b=pEJUG58glLvvYWm1JzLPZxtOAQO7+3PTnHFfvsy9Ts7ZRexwql+UyPqJy0xxy3TF3w
         AJN3PRpMMdpyfvLfRHnhVH265DL3XJXnL3uyHo8n5VJPJHhUA/T9TD6OJO7ttNPZ8k2Q
         s+lnPz62i6hP+eSK+jxVdfLsK59R0CCXixkOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Pw2qwjNa67+GH0k7GEea1ww0/joLPz6munjobUTeYKz/cdJOM5/ZCcpNDGNe4mkBBu
         0ykTRzBm87uwpivNUNo8+4rpxjsn8Tg6byef5gY21kOelG0dA1T4odHZ7TVO6RAzltPZ
         6OmUo18Loo7QOxSK+fUXROZ04MnroRNE4D9ag=
Received: by 10.224.121.135 with SMTP id h7mr4878222qar.136.1275576956310; 
	Thu, 03 Jun 2010 07:55:56 -0700 (PDT)
Received: by 10.229.24.3 with HTTP; Thu, 3 Jun 2010 07:55:36 -0700 (PDT)
In-Reply-To: <AANLkTilEZknW7m0n3y8SX5oAaZiUTorgqfX3jTB8mnDC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148329>

On Thu, Jun 3, 2010 at 07:52, Eugene Sajine <euguess@gmail.com> wrote:
> Hi,
>
> i'm trying to create an alias like this:
>
> cln = !sh -c 'git clone git://server/"$1"'
>
> the idea is to make a shortcut, so instead of command like this:
>
> $git clone git://server/folder/repo.git
>
> i can have something like this:
>
> $git cln folder/repo.git
>
> or even
> $git cln folder/repo
>
> if the alias is like this:
> cln = !sh -c 'git clone git://server/"$1".git'
>
> this doesn't work as it tries to initialize a repo called server.git
> and then fails because "remote hang up unexpecedly"
> is there something wrong in expansion of this alias or the alias
> itself is not valid?
>
> Any ideas?
>
> Thanks,
> Eugene


You need " -" at the end of your alias for the parameters to get through.

Try using:

cln = !sh -c 'git clone git://server/"$1"' -

or

cln = !sh -c 'git clone git://server/"$1".git' -
