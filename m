From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git push failing, unpacker error
Date: Fri, 9 Nov 2007 13:09:16 -0500
Message-ID: <9e4733910711091009q2c6409fdj75cf8051d073c9c5@mail.gmail.com>
References: <9e4733910711082155t62df9d4by10bd3f546ffbd950@mail.gmail.com>
	 <9e4733910711090637tcf7e837na863a4276578bf3f@mail.gmail.com>
	 <9e4733910711090643t493b0e6fl2a18390a2f9ab842@mail.gmail.com>
	 <7vtznvtii4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYIO-0007Iy-GM
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXKISJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbXKISJS
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:09:18 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:45831 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXKISJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:09:17 -0500
Received: by wa-out-1112.google.com with SMTP id v27so693431wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Jj1wzjlC5PchF5Ie6Doxw9IJJ5CfX7U2d+qW2g2WkYk=;
        b=HlhluwX6jMlgWQZ/JNPtjbrt11w+9OUOULFut/gb1tls0Sz3sut/D1qD6t5lPwJVS4kpEcP/wxJlXkzjw6NByWQcZhmzm1hJCqm5+tkMlvpvbFLlyj3B4bMeKvhx3IJ43mHaGErFcADjKZwX2RFq47bnZGX6NkvWZi5IQSi8nDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L7xHg+7hivb0g/t7HquJIpbQD2IvWOmP1woFZdMLsctP2dMgxX3bWdT3q1/ok6nn1qUeoo+iRWP2HSdUAtsYG73ASjfQiUZJlc2n5XNQuuZSQV9eNfhycsdDAnqa3U4IRxUG4Sd8PEgy36Y41fehZXtXeTBEbJXYmoucyv8R6Zk=
Received: by 10.115.23.12 with SMTP id a12mr141078waj.1194631756779;
        Fri, 09 Nov 2007 10:09:16 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 10:09:16 -0800 (PST)
In-Reply-To: <7vtznvtii4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64238>

On 11/9/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > On 11/9/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> I updated both sides to current git and it still fails. How do I debug this?
> >> What's causing this, "error: pack-objects died with strange error"?
> >
> > My remote host is running 2.4.32, is git ok on that kernel?
>
> No problem that I am aware of.  We are not *that* intimate with
> the kernel.
>
> Do "git-fsck --full" on both repositories pass?

I've just discovered that the hosting company has a mechanism for
killing processes that it believes are consuming too much memory. When
git does it's mmap's it looks like it is using over 512MB of memory
which causes it to get zapped. At least I think this is what is
happening.

-- 
Jon Smirl
jonsmirl@gmail.com
