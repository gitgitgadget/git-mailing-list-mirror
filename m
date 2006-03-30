From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible --boundary bug
Date: Thu, 30 Mar 2006 22:55:44 +0200
Message-ID: <e5bfff550603301255j52c68963v4b8eebea697eeecf@mail.gmail.com>
References: <e5bfff550603301034r58b38500ie5897ed06fce6e9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 22:56:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP4BY-0006uw-Ax
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 22:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWC3Uzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 15:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWC3Uzs
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 15:55:48 -0500
Received: from wproxy.gmail.com ([64.233.184.230]:43942 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750869AbWC3Uzr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 15:55:47 -0500
Received: by wproxy.gmail.com with SMTP id 58so101201wri
        for <git@vger.kernel.org>; Thu, 30 Mar 2006 12:55:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bpe5FLZQK2neeNTFbI+LIh0Hdv2ewqLOKe0L97T6+sD2hgRTa0HvyN/ggC5NXIxD06JQWwNj0nUO/lzVHeqpUOBAW7VKHB91oEK3IRQYq8EEjL5OmhcFJWzWEGW/++LpO/k10gGwtw2U4Tifau/zKNOKmxxA5NHpFHtvlpa5Cb4=
Received: by 10.64.131.13 with SMTP id e13mr123536qbd;
        Thu, 30 Mar 2006 12:55:44 -0800 (PST)
Received: by 10.65.163.20 with HTTP; Thu, 30 Mar 2006 12:55:44 -0800 (PST)
To: junkio@cox.net
In-Reply-To: <e5bfff550603301034r58b38500ie5897ed06fce6e9a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18205>

Sorry, the good description is below, please ignore the wrong previous one.

On 3/30/06, Marco Costalba <mcostalba@gmail.com> wrote:
> Trying to convert qgit to use the new and cool --boundary option I
> found this one:
>
> From git tree
>
> $ git-rev-list --boundary --topo-order --parents 5aa44d5..ab57c8d |
> grep eb38cc689e8
> -e646de0d14bac20ef6e156c1742b9e62fb0b9020
> eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4
> 4b953cdc04fec8783e2c654a671005492fda9b01
> 5ca5396c9ecba947c8faac7673195d309a6ba2ea
> eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4
>
> and also
>
> $ git-rev-list --boundary --topo-order --parents 5aa44d5..ab57c8d |
> grep c64965750
> 8c0db2f5193153ea8a51bb45b0512c5a3889023b
> 21a02335f821c89a989cf0b533d2ae0adb6da16e
> c649657501bada28794a30102d9c13cc28ca0e5e
>

It seems the lines:
-c649657501bada28794a30102d9c13cc28ca0e5e  .......

and

-eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4 ......

are missing though the two revs are boundary revs.


Marco

 P.S: Sorry for lengthy output but  --abbrev option:

 git-rev-list --boundary --topo-order --abbrev=8 --parents  5aa44d5..ab57c8d

 does seems to work only for prettyprinted parent names, I guess this
from patches log messages because is not documented.
