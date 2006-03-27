From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 13:55:32 +0200
Message-ID: <e5bfff550603270355s4b71c306hb4cb2b96eafd0f6e@mail.gmail.com>
References: <20060326014946.GB18185@pasky.or.cz>
	 <7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org>
	 <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
	 <e06hts$1ne$1@sea.gmane.org>
	 <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
	 <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com>
	 <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org>
	 <e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com>
	 <Pine.LNX.4.64.0603270005330.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 13:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNqJu-0007mO-00
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 13:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWC0Lze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 06:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWC0Lze
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 06:55:34 -0500
Received: from wproxy.gmail.com ([64.233.184.230]:42944 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750930AbWC0Lze convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 06:55:34 -0500
Received: by wproxy.gmail.com with SMTP id i7so1458189wra
        for <git@vger.kernel.org>; Mon, 27 Mar 2006 03:55:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XOFJR+p0YLJ+TmLxK6ewzyIEzKgZU+DdHVB7lucHAVZ2ISVN9HGtsPLf2mdgYo4AIkRlzqfTxXB9SqRiMX2+G21lAfpjyK3nm85yFLcJtbb10liqFkyIvxuoZEaBtMcx+hDk/RWhF2shFqa6vJSFy3UMjqOrI3ZVjOkirVz6JcI=
Received: by 10.65.235.4 with SMTP id m4mr2216096qbr;
        Mon, 27 Mar 2006 03:55:32 -0800 (PST)
Received: by 10.65.163.13 with HTTP; Mon, 27 Mar 2006 03:55:32 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603270005330.15714@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18082>

On 3/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> In contrast, git-whatchanged will start outputting the recent changes
> immediately.
>

To integrate git-whatchanged like functionality with filter on a
specific code region, the Linus original request, I am wondering about
something like this:

A new git-diff-tree option --range=a..b to delimit a region,
identified by code lines bounduaries.

As example

git-diff-tree --range=10..15 HEAD -- <path>

Coud give these answers, added to standard git-diff-tree output:

* 10..25 --> modified region new region bounduaries are lines from 10 to 25

  15..20 --> region _NOT_ modified but new region bounduaries are
lines from 15 to 20 (perhaps patch added 5 lines _before_ the region)

  10..15  ---> region _NOT_ modified and lines, if any, added/removed 
_after_ the region

* 10..15 --> modified region with the same boundiaries (as example
removing trailing witespaces)

With this new option of git-diff-tree becames very simple to retrieve
a file history limited to a region, because the region bounduaries in
ouput from one rev are feed as input in parent rev.

Comments?

Marco
