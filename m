From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: utf8 BOM
Date: Sun, 16 May 2010 17:32:59 +0400
Message-ID: <20100516133259.GC17200@dpotapov.dyndns.org>
References: <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
 <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
 <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com>
 <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com>
 <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com>
 <20100514101648.GB6212@dpotapov.dyndns.org>
 <61355CFC-EB9E-4B76-9450-F2DF1B2903C0@gmail.com>
 <20100516051927.GA17200@dpotapov.dyndns.org>
 <00E0B9AC-2A2E-4F95-9B35-F3F63EBC3CF3@gmail.com>
 <20100516112612.GV2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Sun May 16 15:33:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODdxy-00006c-Ii
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 15:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742Ab0EPNdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 09:33:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:60304 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab0EPNdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 09:33:04 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2328446fga.1
        for <git@vger.kernel.org>; Sun, 16 May 2010 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=m/XXV/IVm8sm3mY4v6LMpWdc3PgT4lDBE7Qsi+BBWYs=;
        b=e4nme9JzHyr5JuU7JGUrbeK2Ky/jDvfAycDdt94cGwqFgjVaUabPiuskLh+8gGakgh
         fHMEMZUFXSYg4dO/BZHGx1RZFNZHtbhJ1znFNSHYbeMc+6y7rpMRBOYw5PP5AzdqucLe
         q6ux6J1EpcZNnGXDYW2TUWyCJm2ftXaxc+aWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ecY/Mn+d/5XisxNjowI9bmG8xRef//C/9jTzzu0nrAAz0hwvWxYJlXit/1u+Be0hxu
         dgX+8PYbSlROpaBLo+ww2ZN1MvBEBN4EhP/xC6IkDm5dbkfa9Op78ImBaikYbhpMK9cl
         HhSEb2/kl3Z/hMUYVcK5J/RmK9Cxy42Zt1oyY=
Received: by 10.87.71.21 with SMTP id y21mr6482236fgk.69.1274016783215;
        Sun, 16 May 2010 06:33:03 -0700 (PDT)
Received: from localhost (ppp85-140-167-233.pppoe.mtu-net.ru [85.140.167.233])
        by mx.google.com with ESMTPS id e17sm6132631fke.27.2010.05.16.06.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 06:33:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100516112612.GV2480@ece.pdx.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147189>

On Sun, May 16, 2010 at 04:26:12AM -0700, Tait wrote:
> > Okay, so something that checks text files to see if they're utf...
> > "core.autoutf", anyone?
> 
> This (and crlf-conversion, for that matter) strikes me as something best 
> handled outside of git core, such as through checkout/commit hooks. Perhaps 
> examples of such hooks could be provided and adapted by each project and 
> user as that user/project sees fit for their specific choice of repository 
> format and development environment.

There are a few problems with using filters for crlf conversion:

1. It is a way too slow... Running a script for each file is in a repo
is even slow on Linux, and on Windows, it is going to be horrible slow.

2. You have to install this filter in every clone, and by the time when
you install it, your repository is already checked out with the wrong
ending. So, you need to fix it.

While using scripts is good where you need flexibility, it is not the
case with crlf conversion.  Users want it to just work, and they want
simple and easy to understand rules how to mark what files should and
should not be converted. If every project is going with itw own rules
and scripts, it is going to be a big mess.

Now, when we speak about charset encoding, it could make sense to try
this new feature as a filter, but if it is something that is to be used
widely, it should be eventually re-written in C.


Dmitry
