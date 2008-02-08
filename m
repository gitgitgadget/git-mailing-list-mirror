From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 08 Feb 2008 12:19:39 -0800
Message-ID: <1202502007.12966.30.camel@brick>
References: <200802081828.43849.kendy@suse.cz>
	 <m3ejbngtnn.fsf@localhost.localdomain>
	 <9e4733910802081126r5bf19c95rec817a1b6648ee4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, gitster@pobox.com
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:21:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZiR-0006jR-Fx
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761679AbYBHUUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761544AbYBHUUS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:20:18 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:43588 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760976AbYBHUUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:20:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2643379rvb.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 12:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=jDVnVhrIVlKr8AXLrKne2Up4rQi2WOyxohPF2VQi+j4=;
        b=SJ7zfK5Sei5B8OZR9pk7tAJidm1OPB0oc5eTX2N5W5qwWeH+s8WLZ//MEpi9RGrEni+9gn0h5WIjqrJIe7q/yFRP8jEoPUz+ea7vWTT0GKmu79EqWmF61hSKE5oLaXyki4+DKt+J3abC4zo/bKqcmtvocQPBgcFtcOHKez5MPIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=OvGOJ7MqGjNBq2HkAHafNLW5aoZ58RPmgB/AnhvpqQWDTMOYcxMrRMkx1S0IwqSP565I4LXmunJrptP8/6nzPfTYQyZbJ1kNJ2z8scXoY+L2/gY0AOBzXLdgF68rjT4QWpFWjMirx8afB/x0ejyr3h33yOUbGTaB0HJQxKl0pUw=
Received: by 10.141.190.9 with SMTP id s9mr8808096rvp.125.1202502015022;
        Fri, 08 Feb 2008 12:20:15 -0800 (PST)
Received: from ?128.189.216.15? ( [128.189.216.15])
        by mx.google.com with ESMTPS id g22sm14386824rvb.5.2008.02.08.12.20.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Feb 2008 12:20:14 -0800 (PST)
In-Reply-To: <9e4733910802081126r5bf19c95rec817a1b6648ee4d@mail.gmail.com>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73133>

On Fri, 2008-02-08 at 14:26 -0500, Jon Smirl wrote:
> On 2/8/08, Jakub Narebski <jnareb@gmail.com> wrote:
> > Jan Holesovsky <kendy@suse.cz> writes:
> > One of the reasons why 'lazy clone' was not implemented was the fact
> > that by using large enough window, and larger than default delta
> > length you can repack "archive pack" (and keep it from trying to
> > repack using .keep files, see git-config(1)) much tighter than with
> > default (time and CPU conserving) options, and much, much tighter than
> > pack which is result of fast-import driven import.
> >
> > Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
> > you would need machine with large amount of memory to repack it
> > tightly in sensible time!
> 
> A lot of memory is 2-4GB. Without this much memory you will trigger
> swapping and the pack process will finish in about a month. 

Well, my modest little Celeron M laptop w/ 1GB of ram did the full
repack overnight on the gcc repo, so a month is a bit of an
exaggeration.

Cheers,

Harvey
