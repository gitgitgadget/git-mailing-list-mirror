From: David <davvid@gmail.com>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 20:41:34 -0700
Message-ID: <402731c90710162041q457c7dd3tf906ba0c6faf29ca@mail.gmail.com>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	 <20071016070421.GE13801@spearce.org>
	 <11F85069-1013-4685-9D56-C53F0F8231BF@MIT.EDU>
	 <4714F2CA.5000509@op5.se> <20071016174026.GA506@uranus.ravnborg.org>
	 <20071016230952.GA18099@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 17 05:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihzn3-0001oL-Gb
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 05:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbXJQDlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 23:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758291AbXJQDlh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 23:41:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:5022 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932620AbXJQDlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 23:41:36 -0400
Received: by ug-out-1314.google.com with SMTP id z38so202476ugc
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 20:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PtFY7fcdqOXWcqAi8SS0sZu7UEKeyaha+mAhQQWGCb8=;
        b=poa9eLbaAAzO3qR4Xh+okCl2qCkgGz0W1Fuc+lvCqMZ8st67WHOXJwmB18+JjQ4rtPmTIQ7K1S5X/msNQu9K5bDkGGemi3q83kDQWkg4RKitmd/3kc3c8EpAJpqxE2mCKKN5L7GvcaGtZtMXDoZs1zH3QMZbctJDOFWFzJ+p9qM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pUnE/e7i7N3sj40k1Oc0v+28UXp20E+V2XaIPrZdWsRrahU/NJUpm1bKHiLlGvpTFgEs0xAt/3QCER4K+H5V6Gb366GM2oKgY1tRsZpTS7rXqvagv/yv5WrA0hqsF0jcn4xrr9xfNjX1NVPbp6M30bgtqNOjxG1H8y5N7ZPd7bo=
Received: by 10.66.225.17 with SMTP id x17mr117960ugg.1192592494715;
        Tue, 16 Oct 2007 20:41:34 -0700 (PDT)
Received: by 10.67.118.1 with HTTP; Tue, 16 Oct 2007 20:41:34 -0700 (PDT)
In-Reply-To: <20071016230952.GA18099@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61325>

On 10/16/07, Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Oct 16, 2007 at 07:40:26PM +0200, Sam Ravnborg wrote:
> > Tabs should be used for indent and not general alignment.
> >
> > Consider:
> > <tab>if (some long condition that
> > <tab>....&& spans two lines) {
> > <tab><tab>my_private_printf("bla bla bla"
> > <tab><tab>.................."more bla bla\n");
> > <tab><tab>}
> >
> > This will look good and align "more bla bla\n" as
> > intended no matter your tab setting.
> > But replacing the 8 spaces with a tab will
> > cause it to look bad.
>
> I'd so much love to have this and sometimes do this even manually, but
> does anyone have an idea how to make vim do this for me? I never got
> around to investigate this in depth or possibly make a patch...
>
> --
>                                 Petr "Pasky" Baudis
> Early to rise and early to bed makes a male healthy and wealthy and dead.
>                 -- James Thurber


Hello
I use both vim and emacs so I must be weird.
Anyways, here's some useful vim settings that I've come across:

set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set list
set listchars=<tab>:.\

The last two are extremely useful, especially if you're hacking on
python.  That's
listchars=(less-than)tab(greater-than)(colon)(dot)(backslash)(space)
(don't forget the space!).

That makes vim display tabs with a "." indicator, so you have a very
clear view of when tabs are in use.  This has helped me countless
times.

You can use any character in there instead of dot.  I actually use an
extended ascii character since it looks nicer but I didn't want to
risk email mangling it.

-- 
    David
