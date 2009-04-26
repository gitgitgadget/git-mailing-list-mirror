From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and Mercurial
Date: Sun, 26 Apr 2009 13:33:36 -0400
Message-ID: <49F49AF0.1020301@gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org> <m363grq13i.fsf@localhost.localdomain> <49F475B8.20903@gmail.com> <alpine.DEB.1.00.0904261854460.10279@pacific.mpi-cbg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:41:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly8G4-0000YZ-H0
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 19:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbZDZRdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 13:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbZDZRdk
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 13:33:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:41961 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbZDZRdk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 13:33:40 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1161029ywb.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EEKz65Hon+ZwmeSJqSUkuJDKheXiQZE1aTOg3z3yd9o=;
        b=m/ip86Ajx8Yb9ITvNWodeQs6PMVFo8HFnK4ZXzm8nioWBMVS9ZIxxuyZWtO8zZx4mh
         ntPH99hi/j7DwuTSNKOFatSvL+3UtzQ9+QlncBKIsoty0Yuy04xMRsLF2RCUOfUohV24
         DItLpUk4d+O/IhKHRNh28egxH2d7CaPG1wDqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=XQUuDxR8gxJ200RNnTBZgIPgUQyKND4G4VXvt2zwokDUGXfn/ohpe4QUQonR1iFj+6
         9nV4fO2AcsMrzKdY0RB7f7N8i3fzsG5QakyMoRopJT3dAfN9kD+sZ2t74vNxvZOUq0v2
         FHb03U6Yd0cfvSCrH2GY0/i3eqZ3cq7lXtOhs=
Received: by 10.100.33.15 with SMTP id g15mr7091953ang.103.1240767218912;
        Sun, 26 Apr 2009 10:33:38 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id d12sm7151455and.3.2009.04.26.10.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 10:33:38 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0904261854460.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117633>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 26 Apr 2009, A Large Angry SCM wrote:
> 
>> Another important criteria was which, both or neither of Git and Hg 
>> would actually work and perform well on top of Google Code's underling 
>> storage system and except to mention they would be using Bigtable, the 
>> report did not discuss this. Git on top of Bigtable will not perform 
>> well.
> 
> Actually, did we not arrive at the conclusion that it could perform well 
> at least with the filesystem layer on top of big table, but even better if 
> the big tables stored certain chunks (not really all that different from 
> the chunks needed for mirror-sync!)?
> 
> Back when I discussed this with a Googler, it was all too obvious that 
> they are not interested (and in the meantime I understand why, see my 
> other mail).
> 

I don't remember the mirror-sync discussion. But I do remember that when 
the discussion turned to implementing a filesystem on top of Bigtable 
that would not cause performance problems for Git, my response was that 
you'd still be much better off going to GFS directly instead of faking a 
filesystem on top of Bigtable without all of the Bigtable limitations.

Bigtable _is_ appealing to implement the Git object store on. It's too 
bad the latency in Bigtable would make it horribly slow.
