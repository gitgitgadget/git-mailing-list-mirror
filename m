From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/2] Simpler way to draw commit graph
Date: Fri, 20 Oct 2006 13:46:33 +0200
Message-ID: <e5bfff550610200446o35bac985n3d520066fdbae2bb@mail.gmail.com>
References: <200610191613.31119.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 14:16:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GatIj-0003ml-Lo
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 14:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992605AbWJTMQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 08:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992604AbWJTMQb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 08:16:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:10660 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2992602AbWJTMQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 08:16:30 -0400
Received: by wr-out-0506.google.com with SMTP id i4so44423wra
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 05:16:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KWD3qA5aE0J/y8F/bkiCV/X6nsr5hRTNeV9q9lFGbMjVcC7SlqDWRuYk1syy6auj4YOk14FDw7S60U+PfWSrTwNajHK0v0WTKjktyt3fxXudaIaWEiEikHRt/MxYVk0iZsEOpqLzMzE/I2T5pBzXQrBrZkNyxt0bsaqs7BhajPk=
Received: by 10.35.76.9 with SMTP id d9mr419543pyl;
        Fri, 20 Oct 2006 04:46:33 -0700 (PDT)
Received: by 10.35.42.4 with HTTP; Fri, 20 Oct 2006 04:46:33 -0700 (PDT)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200610191613.31119.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29456>

On 10/19/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> For drawing the commit graph, previously every item got a
> pixmap created and set with item->setPixmap(), which is
> drawn by the standard implementation of QListView::paintCell().
>
> Instead, this commit implements drawing of the graph
> directly in our own ListView::paintCell(). This gets rid of
> a lot of complex code to reset the pixmap of invisible items
> which was needed in large repositories before to not allocate
> huge amounts of memory.
>
> As we directly draw only the visible cells, it has no
> influence on performance (especially, as we got rid of
> pixmaps of invisible items before, and most often had
> to draw the graph anyway).
>
> Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
> ---
>

It looks sane. Thanks, I will apply this week-end.

>
> In order to solve this, I looked at the code, and do not understand
> one thing: Why are you creating pixmaps for the graph, and do
> draw directly in paintCell() ?
>

The code to create pixmaps is older then the one to remove not visible pixmaps.
When I added the latter I missed the opportunity to reformat exsisting code.

> This patch does exactly this, and the next one does cleanup
> of code which is not used afterwards.
>
> If you like, I can comeup with a patch to directly draw the lines
> which would get rid of the original problem.
>

Yes, please.


Thanks
Marco
