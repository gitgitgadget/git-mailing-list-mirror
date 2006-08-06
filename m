From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: fast-import and unique objects.
Date: Sun, 6 Aug 2006 11:53:43 -0400
Message-ID: <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 17:53:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9kwn-0003wf-7R
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 17:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWHFPxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHFPxp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 11:53:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:16992 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932488AbWHFPxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 11:53:45 -0400
Received: by nf-out-0910.google.com with SMTP id p46so180714nfa
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 08:53:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BMc4Iv7DrwoKH1PRd7gArdOdjufjPgkPXUgOqszBxy0IzXqvXMsWxyQYrqCyYdoB5KTak+kbsqBXnOUI7xPzI9VjDCU2FChKbCYA1y9QY2yvHMzBwRlUwkCI8Wm9JxPENkykaSv0ejuzsmy/IeKXdjeiUf43rlieD4SFgbGwNXs=
Received: by 10.78.117.10 with SMTP id p10mr2153611huc;
        Sun, 06 Aug 2006 08:53:43 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sun, 6 Aug 2006 08:53:43 -0700 (PDT)
To: git <git@vger.kernel.org>, "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24980>

On 8/6/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> This model has a lot of object duplication. I generated 949,305
> revisions, but only 754,165 are unique. I'll modify my code to build a
> hash of the objects it has seen and then not send the duplicates to
> fast-import. Those 195,140 duplicated objects may be what is tripping
> index-pack up.

New run is finished with duplicate removal.

Time to run is unchanged, still 2hrs. Run time is IO bound not CPU.
Pack file is 845MB instead of 934MB.
git-index-pack works now, it takes 4 CPU minutes to run.
Index file is 18MB.

So it looks like the first stage code is working. Next I need to
modify cvs2svn to keep track of the sha-1 through it's sorting process
instead of file:revision.

-- 
Jon Smirl
jonsmirl@gmail.com
