From: "Stefano Spinucci" <virgo977virgo@gmail.com>
Subject: Re: using the same repo with different OS
Date: Mon, 12 Mar 2007 19:33:33 +0100
Message-ID: <906f26060703121133o6de42d66y9f3ada50149a852c@mail.gmail.com>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
	 <Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0702251929170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vy7mmrspw.fsf@assigned-by-dhcp.cox.net>
	 <906f26060702281006l794173e8uea0f7174dd712e32@mail.gmail.com>
	 <20070228181251.GG5924@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpLA-0006Nw-3W
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 19:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXCLSdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXCLSdo
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 14:33:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:7712 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbXCLSdn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 14:33:43 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2346060uga
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 11:33:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SPXOal+pK5Zjy7ixq6Ab+hcFyixJ4NqGHYpKVCbRvuaWqKtVOmlN2GevUUJ4s3FxVpKWhLtGYLYgp8KHeV8D1SkK93FZWrDYsZ/8m9CVDOkjBLmGarM/vMi9E0Miy7bf/A07LW7UL1DnObCMBd6YvQA1NcsChgKPyc0x+d8aQLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E1KbixWO3CsFrT+Q01Y52ki+iCW4B32Fsp6Y6ayFTbsoEaUFJkcUtGaXGJtgE6WsZuaRyUSKiyHbUt4ghIejIIAe5uRBTj+lQrVoACtl9jh75cHh0nwiCVIlqg7Cv9qJa6E66TASjjBD7XaVSZPY1YQUu+bDDom+NmoXhSUNkbY=
Received: by 10.115.92.2 with SMTP id u2mr2003943wal.1173724413388;
        Mon, 12 Mar 2007 11:33:33 -0700 (PDT)
Received: by 10.114.92.12 with HTTP; Mon, 12 Mar 2007 11:33:33 -0700 (PDT)
In-Reply-To: <20070228181251.GG5924@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42052>

On 2/28/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> Stefano Spinucci <virgo977virgo@gmail.com> wrote:
> > Than I'm asking how you'd setup repos to work on some linux/windows
> > machines, transferring data only with an USB disk.
>
> Just create a bare repository on the USB stick and push/fetch to it.
> It won't have a checkout directory or an index, the two sticking
> points with mmap() on Windows and with a FAT32 filesystem being
> accessed through Git by both Linux and Windows.

Needing to have my repos backupped and only on fat32 usb keys, I was
thinking to have the following layout:
on usb key one --> repo.linux
on usb key two --> repo.win

Then, on repo.win, I'll do:
# before daily work on windows
fetch from repo.linux
# after daily work on windows
push to repo.linux

Otherwise, on repo.linux:
# before nightly work on linux
fetch from repo.windows
# after nightly work on linux
push to repo.windows

It's possible, or I need a third bare repository between windows and linux ???

thanks

---
Stefano Spinucci
