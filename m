From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 17:27:19 -0400
Message-ID: <6dbd4d000806101427p338b52bate470f6f8b68221df@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <m3abhtp42o.fsf@localhost.localdomain>
	 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
	 <200806102159.02875.jnareb@gmail.com>
	 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
	 <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
	 <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:28:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6BO6-00032N-Fy
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 23:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbYFJV1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 17:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755479AbYFJV1Y
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 17:27:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:53219 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759224AbYFJV1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 17:27:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1919959fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0KLy0MTiyVcapotpHfjZ1gHN0Jylgu/9BsBAEsa4l20=;
        b=p6TA67FYxoPDGzOcrglKjxxfBLTWrhp1rT9WChzln6oVIBopSAlBlZRko54Gxe6yWR
         +Wu1K4krl4pEvS7d5XwoeoEEEsZmfYweQBJ1VXe1x/61vKoV5/2NSKnSKxeKsB64rDPm
         EDlUn8Pv9GfZz47esUHDehUscQbxUvAPyviFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FuIQTAsr/3TcUahDRIiJx/A7v7Hn1Pl+h/ud38n222zAwZZMO/YmzP8hN5uK18zT6E
         +qSry9ICqqYUZG4wBKoyiFerjkvM+EEhFnkA9svV5cbhy8it2Lb6QtPBBjJcUCaxeEKp
         gP7+09EBbavj2wcjstf1pYXL2cq92hbHMj9SY=
Received: by 10.86.80.17 with SMTP id d17mr6268893fgb.47.1213133239842;
        Tue, 10 Jun 2008 14:27:19 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 14:27:19 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84550>

On Tue, Jun 10, 2008 at 17:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Ahh, ok. Yes, we should probably re-think our 'grafts' file thing, or at
> least not document it, because it's actually a wondeful way to just cause
> more corruption by hiding things (ie if you clone a repo with a grafts
> file, the result will now have neither the grafts file _nor_ the state
> that was hidden by it, so the result is guaranteed to be corrupt).

I'd argue in favor of documenting it, even if it's dangerous, unless
there's some other mechanism (rebase?) that would let me do what I
did?  That is, to recover from corruption in a way that lets me
regenerate or ignore inexact, corrupted commits.

-- 
 Denis
