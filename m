From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ensure the default stylesheet is accessible
Date: Mon, 26 Jan 2009 12:35:36 +0100
Message-ID: <cb7bb73a0901260335n3cc53295m162ca56810702596@mail.gmail.com>
References: <1232933322-9186-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200901260248.22120.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPrJ-0001py-6L
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbZAZLlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZAZLlF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:41:05 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:50279 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbZAZLlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:41:04 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jan 2009 06:41:03 EST
Received: by ewy14 with SMTP id 14so323180ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j+kfdvlLrAytoqItXb0epo+APSvMzP5qlEPagqShgx0=;
        b=MTuDXg98gsi/sN+e16vRuJsV/nU0AEgCx93H+ek2lpDb8g8ixe1B+E93/N2G3kE4Ng
         ghdHRPb7eQWeK4Qdy4eWLdToZjgpXv22MMHoAcinNHnvi9OG4l5anrljarKTprjpFxkc
         V0360wbHC2POCRhR6a94KpUI69NprY31nh0Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zq0RtqadXRCXERdER2oZqYFDJJbmq1aG+muYY1K0TRfsu6qQMcafeYKzNUJYRyGEko
         k2bAd1Z84ZkML1XaIuGe5oIeVCxU/Wuxcz3PZQeq5f9TsHeBMi9L/ZsaJk7QAeAq3X+L
         YUgFgCzvptVMFR6QhaTGKxx7l3zuUj4GU6dw4=
Received: by 10.210.139.15 with SMTP id m15mr3905039ebd.69.1232969736740; Mon, 
	26 Jan 2009 03:35:36 -0800 (PST)
In-Reply-To: <200901260248.22120.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107193>

On Mon, Jan 26, 2009 at 2:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>
>> On some installations the CSS fails to be linked correctly when
>> path_info is enabled, since the link refers to "gitweb.css", whereas it
>> should be "${my_uri}/gitweb.css". Fix by setting the appropriate default
>> in the Makefile.
>
> Why "on some installations"? What does "some" mean? I don't think it
> is something indeterministic: please spell when one can have problems
> with linking CSS file.

The truth is, I haven't the slightest idea. It works fine on my
machine, it doesn't without the patch on ruby-rbot.org, but I really
don't know why.

> Wouldn't it be simpler to deal with problem of base URL when using
> path_info gitweb URLs to add BASE element to HTML head if we use
> path_info? Something like:
>
>        if ($ENV{'PATH_INFO'}) {  # $path_info is unfortunately stripped
>                print qq(<base href="$my_uri">\n);
>        }
>
> somewhere in git_header_html() subroutine?

Ah, this might work. I'll test it.

> It is not the same case for git-logo.png and git-favicon.png as for
> gitweb.css? If it is not, please explain why in commit message.
> If it is, then your patch is only partial solution to path_info
> problem.

Oh, interesting, true, I hadn't noticed.

I'll look into the base thing.

-- 
Giuseppe "Oblomov" Bilotta
