From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 14:48:56 -0400
Message-ID: <9e4733910608141148t636f9874wfcf66b56161352c3@mail.gmail.com>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
	 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>
	 <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910608140915i728004c1p216bf3d74fcc6ab7@mail.gmail.com>
	 <Pine.LNX.4.63.0608140930380.14796@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 20:49:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GChUj-00059s-Ga
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 20:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWHNSs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 14:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWHNSs6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 14:48:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:42352 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751869AbWHNSs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 14:48:57 -0400
Received: by wr-out-0506.google.com with SMTP id i21so197271wra
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 11:48:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K1t1LK8d7qyLJKXYiROtrE/6+bjnBu/lCbQiywM3fZZ31qLweqUwXYmfsvrF250EiXWv9nYgM65F8EwryG+bm3RU1rX+n1gup/E1ipocqJRFOw+2IKlDymU2+tkaG7lChDZwdd2xZ1f1R6CjY8AKV+xkkSwV0aKMzyCWtGz/36g=
Received: by 10.78.183.8 with SMTP id g8mr3432768huf;
        Mon, 14 Aug 2006 11:48:56 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Mon, 14 Aug 2006 11:48:56 -0700 (PDT)
To: "David Lang" <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.63.0608140930380.14796@qynat.qvtvafvgr.pbz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25374>

On 8/14/06, David Lang <dlang@digitalinsight.com> wrote:
> On Mon, 14 Aug 2006, Jon Smirl wrote:
>
> > On 8/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> I still think that this is important to think through: Is it worth a
> >> couple of kilobytes (I doubt that it would be as much as 1MB in _total_),
> >> and be on the unsafe side?
> >
> > The only "unsafe" aspect I see to this is if the global dictionary
> > doesn't contain any of the words in the documents being encoded. In
> > that case the global dictionary will occupy the short huffman keys
> > forcing longer internal keys.  The keys for the words in the document
> > would be longer by a about a bit on average.
>
> the other factor that was mentioned was that a single-bit corruption in the
> dictionary would make the entire pack file useless. if this is really a concern
> then just store multiple copies of the dictionary. on a pack with lots of files
> in it it can still be a significant win.

Bit errors can mess the pack up in lots of ways. If it hits a commit
you won't be able to follow the tree back in time. Packs were never
designed to be error tolerant.

-- 
Jon Smirl
jonsmirl@gmail.com
