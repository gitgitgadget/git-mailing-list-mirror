From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some adhocery
Date: Tue, 27 Jun 2006 10:50:43 +1200
Message-ID: <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
	 <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net, martin@catalyst.net.nz
X-From: git-owner@vger.kernel.org Tue Jun 27 00:53:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuzxM-0007HM-TG
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 00:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933387AbWFZWvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 18:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933329AbWFZWvH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 18:51:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:44585 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933375AbWFZWup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 18:50:45 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2296042ugf
        for <git@vger.kernel.org>; Mon, 26 Jun 2006 15:50:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DQt8AESsDfq3DlUmWSLUFoH7cPstWdzpCIcDO2c2+F7iO5PC3cbIZqcC4jpTtudUQNpQaBzayuAPDZP4jY/HvTtG/F1G3nHVGlv12R75I6la8dfqPmSou3Y7QCFdGU3CkHb+Mq8Ptqs2hzViYCiD+UOFNSwtbRGVBBQVcj3HMHk=
Received: by 10.78.151.3 with SMTP id y3mr2317034hud;
        Mon, 26 Jun 2006 15:50:44 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Mon, 26 Jun 2006 15:50:43 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22687>

On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 27 Jun 2006, Martin Langhoff wrote:
>
> > And it errors out with ignore-if-in-upstream:
> >
> >  $ ./git format-patch --ignore-if-in-upstream -o .patches origin master
> >  fatal: Not a range.
>
> Could you test with "origin..master" instead of "origin master"?

Funny you mention that! Now it works ;-) and it even produces the
patches I would expect. There is something strange though. I have a
repo with ~150 pending patches to push, of which git-cherry spots ~100
as already merged upstream. So the old git-format-patch.sh would spit
50 patches, and the initial C version would do 150.

Now this version gives me 50 patches, regardless of
--ignore-if-in-upstream. Is that expected?

Also, if the two heads are identical, it still says 'Fatal: Not a
range", but that isn't so important.

cheers,


martin
