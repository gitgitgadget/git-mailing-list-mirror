From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 11:41:58 -0400
Message-ID: <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 17:42:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G91oM-0003tg-Rp
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 17:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbWHDPmB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 11:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWHDPmB
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 11:42:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:38078 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161255AbWHDPmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 11:42:00 -0400
Received: by wx-out-0506.google.com with SMTP id s14so130429wxc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 08:41:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jEmL1Rp9KyM4K5R1jFIV/M7lhgpOQmqcw/LV4Q0CVG+K2KPL51QSkVEN07PC1IHwzEJYhJTVmuTKLny7Pwg1JKkeUtKvWgrp1S8YOGsfnw/tPmCkoCHJjB0vgOj5RdsWzOFjKLgZ0InxTiMO5vPvS9x6zMr+QUVsIMPTUuogF4U=
Received: by 10.78.142.14 with SMTP id p14mr1588118hud;
        Fri, 04 Aug 2006 08:41:58 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 08:41:58 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24794>

On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> I'd suggest against it, but you can (and should) just repack often enough
> that you shouldn't ever have gigabytes of objects "in flight". I'd have
> expected that with a repack every few ten thousand files, and most files
> being on the order of a few kB, you'd have been more than ok, but
> especially if you have large files, you may want to make things "every <n>
> bytes" rather than "every <n> files".

How about forking off a pack-objects and handing it one file name at a
time over a pipe. When I hand it the next file name I delete the first
file. Does pack-objects make multiple passes over the files? This
model would let me hand it all 1M files.

-- 
Jon Smirl
jonsmirl@gmail.com
