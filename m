From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] Popup menu
Date: Sun, 22 Feb 2009 13:57:23 +0100
Message-ID: <cb7bb73a0902220457y7e9b18c5ka30ca523318cc223@mail.gmail.com>
References: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <2c6b72b30902220415q2d3cfa7dmd5fd584c89acbecc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 13:58:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbDv7-0006eR-Fb
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 13:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZBVM51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 07:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbZBVM51
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 07:57:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:34929 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZBVM50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 07:57:26 -0500
Received: by nf-out-0910.google.com with SMTP id d21so269948nfb.21
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 04:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0mtFOOGhzWB5HLqJnSZg+rIWkK18XYFIuxktcvBk/B4=;
        b=uRDg/LxlaS6CHPfaf+SwcQZ1rG0EnGoOtcQY59Ifovd7AKkU2Ch2YXeVKEa+vuYlPL
         FhqI3XAcv/Fu0Oe/k/wyht+zXMzjZMXICQ/mY/UkljR+I1MYCn+Ams62wtU3E+qlDctG
         B6xHsse+6kldX/i8BkPbBVTvO9zrInDM9fO5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bi42LwjngHw4Qh3bUMRQ7M404so9ewHA0NEYSHnrNE54tlwHO1a71Mh69RGZwMEpdw
         bUOEQaVOGZkkOjv6+Tj1LE0OuzKXM25nIR+DQEeSUK7iGc4ikxENszoMEUMCf0pSzP+f
         0hlrXX0wbdHgbWWXLK6VLyrK+paO8v9ULzYfo=
Received: by 10.210.111.5 with SMTP id j5mr2498258ebc.119.1235307443422; Sun, 
	22 Feb 2009 04:57:23 -0800 (PST)
In-Reply-To: <2c6b72b30902220415q2d3cfa7dmd5fd584c89acbecc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111003>

On Sun, Feb 22, 2009 at 1:15 PM, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Sun, Feb 22, 2009 at 12:40, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> Make the menu into a popup window that complements the status prompt.
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>>
>> We should probably consider using the high-level menu and panel features from
>> ncurses if we want to do anything more complex.
>
> First of all very cute. I take it as a comment that the menu thing I
> added yesterday leaves a lot to be desired. :) I certainly agree it is
> limited and would have liked to make it similar to Vim's horizontal
> menu, but gave up when it got too complicated.

I wouldn't say your implementation left _a lot_ to be desired, but I
found it to be somewhat uninformative on the available options, which
is why I tried this route instead.

> About using the menu, panel and maybe even the form library: Yes, it
> might make sense but then again I had also hoped to maybe at some
> point try to get tig running on just the terminfo interface. But I
> don't know if there is any compelling reason for doing this anymore,
> other than reducing the dependencies a bit.

If reducing dependencies means having to reimplement most of them from
scratch, it might not be worth it so much ;-)

> BTW, the code doesn't handle resizing or background loading (try
> starting with `tig --stat` and immediately press 'o'). To fix this I
> don't know if it would be better to "rip off" the status window and
> use this as the menu window. It would require a few flags to make the
> resize code do the right thing.

I was pretty sure resizing would bomb it, but I hadn't thought about
background loading at all, I'll see if I can think about it a little.

> tig.c: In function 'menu_select':
> tig.c:6629: warning: unused variable 'width'
> tig.c:6628: warning: unused variable 'win'

Oops, leftovers, I'll clean them up.

-- 
Giuseppe "Oblomov" Bilotta
