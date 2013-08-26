From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: git-svn - canonicalize: Assertion `*src != '/'' failed.
Date: Mon, 26 Aug 2013 10:52:06 -0700
Message-ID: <CAKRnqNLupBKdvkK-LCuO8a+cz00oJbCcjKDEV8FepV9xSOAJEw@mail.gmail.com>
References: <521B8D61.8040608@gmail.com> <20130826172853.GR4110@google.com>
 <CAKRnqNK4ZftcejAHjCcnFukr=Dm_U109uFmXEmXT+VpeW4DCBA@mail.gmail.com> <20130826174242.GT4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Development <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0xt-0007YM-2S
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab3HZRw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:52:29 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47978 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab3HZRw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:52:28 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so3967498wgh.5
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lEwnCq6TKGYGYN07t8Zr6Z77aQ2peG1dtudZng3iYJQ=;
        b=Mtm3gSOal4kdwS2bnEmw3WSTjlfMN7PCIhQx3LlDDObipQn3JGv6QveG1Tq4mdq6rq
         wdKc2LJo9S8OHKPEQVm+p6yI0p9QDDau79nUIn0x/OcZ1Duz7yK1V8HUY8+8W60hIPp0
         EZ/+xJ48BSDVbSUqg9PPDTS97mEZRsE13TBKxrEKa0aQOxM9AtKqJICYcY7jlE0r28Km
         ZunJYPUZDeWsQOMIWYVdRh9nGoD1tla80lZnGKkUR0pgOBws3IKMT9y+LhLHU6tPlgmB
         8a5/0K/ydIe1Q1Y8D65SSs/LJ/0nnYMj1sj42I+P3XIS0VtYdlUUvEcTY/544GFrJ12D
         GGnQ==
X-Received: by 10.194.201.225 with SMTP id kd1mr2836469wjc.35.1377539547213;
 Mon, 26 Aug 2013 10:52:27 -0700 (PDT)
Received: by 10.194.24.193 with HTTP; Mon, 26 Aug 2013 10:52:06 -0700 (PDT)
In-Reply-To: <20130826174242.GT4110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233014>

On Mon, Aug 26, 2013 at 10:42 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Bruce Korb wrote:
>
>> $ git svn --version
>> git-svn version 1.8.1.4 (svn 1.7.11)
>
> Hm.  Two ideas:
>
>  * Does 1.8.2 or newer work better?  (It contains v1.8.2-rc0~110^2,
>    "git-svn: do not escape certain characters in paths", 2013-01-17,
>    which at first glance looks unlikely to help but might be worth a
>    try.)
>
>  * Does "git svn clone file://$PWD/private-lustre-svn $PWD/private-lustre-git"
>    work?
>
> Ciao,
> Jonathan

I get different results:

> $ git svn clone file://$PWD/private-lustre-svn $PWD/private-lustre-git
> Initialized empty Git repository in /u/bkorb/work/private-lustre-git/.git/
> Couldn't open a repository: Unable to connect to a repository at URL 'file:///u/bkorb/work/private-lustre-svn': \
> Unable to open an ra_local session to URL: Unable to open repository 'file:///u/bkorb/work/private-lustre-svn' \
> at /usr/lib/perl5/vendor_perl/5.16.2/Git/SVN.pm line 148.

That makes it look like I didn't get a proper copy of the SVN repo.
Since the real repo lives behind a firewall through two ssh hops,
getting what I need may require learning Subversion instead of using
conversion and familiar tools.....

(I need to extract patch sets for three development branches so I can
apply them to a lustre GIT repo.)
