From: David Brown <git@davidb.org>
Subject: Re: Removing old data without disturbing tree?
Date: Tue, 27 Nov 2007 13:10:06 -0800
Message-ID: <20071127211006.GA22242@old.davidb.org>
References: <20071127193955.GA16585@old.davidb.org> <alpine.LFD.0.99999.0711271459520.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 22:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix7hM-0000ul-KY
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 22:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759123AbXK0VKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 16:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbXK0VKI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 16:10:08 -0500
Received: from mail.davidb.org ([66.93.32.219]:55924 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758690AbXK0VKH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 16:10:07 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1Ix7h0-0005pG-Hq; Tue, 27 Nov 2007 13:10:06 -0800
Mail-Followup-To: Nicolas Pitre <nico@cam.org>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711271459520.9605@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66260>

On Tue, Nov 27, 2007 at 03:06:45PM -0500, Nicolas Pitre wrote:
>On Tue, 27 Nov 2007, David Brown wrote:
>
>> An upstream tree I'm mirroring with git-p4 has decided to start checking
>> in large tarballs (150MB) periodically.  It's basically a prebuild version
>> of some firmware needed to run the rest of the software.
>> 
>> Git doesn't seem to have any problem with these tarballs (and is using a
>> lot less space than P4), but I have a feeling we might start running into
>> problems when things get real big.  Does anyone have experience with packs
>> growing beyong several GB?
>
>It should just work.  It was tested with artificial data sets but that's 
>about it.
>
>Now if those tarballs are actually multiple revisions of the same 
>package, you might consider storing them uncompressed and let Git delta 
>compress them against each other which will produce an even more 
>significant space saving.

I did manage to talk them into leaving them uncompressed.  But, they are
large, and don't seem to delta compress all that well.  Maybe as more come,
the compression will be better.

I guess this will be a good test case...  It will probably take months or
even a year or so for the repo to get up to several GB.

David
