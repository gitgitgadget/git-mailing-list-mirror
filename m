From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] block-sha1: factor out get_be and put_be wrappers
Date: Thu, 23 Jan 2014 15:19:12 -0800
Message-ID: <20140123231912.GD18964@google.com>
References: <20140123212036.GA21299@sigill.intra.peff.net>
 <20140123212308.GA21705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6TYR-0005Hd-T6
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbaAWXTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:19:20 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:53797 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbaAWXTT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 18:19:19 -0500
Received: by mail-bk0-f44.google.com with SMTP id mz12so741506bkb.17
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 15:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=scktu1TAEqMGgzmtjU/K98b1O1peQxU+59it37Nxorg=;
        b=Dli2395e7+FOcyuhyu6pFjGnTnzhL91fBESVLvCry29Fd/C7no5HFGHDzT0vdqe+U7
         1lDZ/ooOVhs1TXKzJN4/6dqUDOUZPYUaOk87XYFzkFkdEVnM2Aorx3VKtIz7lra51tTN
         jkceab6udKpG6DL66S3pYuApve9bOat+edRThJ7w91AjtbyiClzo/RTMBjWRfiLS4jep
         WzKrou2Ofl4pzofnsVC3SUgRbKPkw39L5aWcPxtDyiyzXX48OZxMKM6AJANalGxRyUM9
         +WRWL0x+ycWablq1ju4+v28R0PNr+xNTo+opk+fsyXx/osXZRVtQH+OcXgA616AU+Zh5
         AxnQ==
X-Received: by 10.204.118.67 with SMTP id u3mr3587017bkq.41.1390519157887;
        Thu, 23 Jan 2014 15:19:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id np8sm615810bkb.11.2014.01.23.15.19.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 15:19:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123212308.GA21705@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240972>

Jeff King wrote:

> These short names might not be descriptive enough now that they are
> globals. However, they make sense to me.

Yeah, I think they're clear.  And they match the Linux kernel's
get_unaligned_be32() / put_unaligned_be32().
