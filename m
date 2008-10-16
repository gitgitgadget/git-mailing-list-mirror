From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Working with remotes; cloning remote references
Date: Thu, 16 Oct 2008 16:45:08 -0400
Message-ID: <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com>
References: <48F7852F.109@xiplink.com>
	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>
	 <48F7A42E.70200@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Marc Branchaud" <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:46:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZji-0007C2-U9
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbYJPUpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbYJPUpK
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:45:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:25526 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYJPUpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:45:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so176446rvb.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=XwWdR7YsvE1wPB7ma7Yc3mhR7GfKwnMXUzGeXZ84VN0=;
        b=ofONFDPTwvUsbJHtE9gZMZ+53d+WlJP6io89U/K0tRPEasz3qJhUGKxgugSq8H/iEA
         lrz4sJVe0JCGUkh8gACa5beR0VJW/FSoPAKyOfBKOC7k4UKPgLnjEBbu2VHqBvE1jypo
         WtrTIxTzqEklQdeeYSRqKsvdm0m+3uW+/vqN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=B0UU8iZv5tMADDH/IV1ehagJPMJn9x0bdH2Ji/vgPQrqflbxsXNga89P+sZt1Aavee
         sqxBZ+OgEXiOskiT5H8xlw1Lv7KE00NBQvjYXFWFNDIn8VjX1pMNWiOaX2eki8Uh0+i9
         NVB9ekk8HmDJt8EKmgyVzhqVDE4sqQ21LApDw=
Received: by 10.141.133.14 with SMTP id k14mr1971841rvn.127.1224189908610;
        Thu, 16 Oct 2008 13:45:08 -0700 (PDT)
Received: by 10.141.97.15 with HTTP; Thu, 16 Oct 2008 13:45:08 -0700 (PDT)
In-Reply-To: <48F7A42E.70200@xiplink.com>
Content-Disposition: inline
X-Google-Sender-Auth: ca90237b6cea44b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98424>

On Thu, Oct 16, 2008 at 4:29 PM, Marc Branchaud wrote:
> Peter Harris wrote:
>>
>> "git clone" doesn't have this option, but you can turn it on
>> immediately after with something similar to:
>> git config --add remote.origin.fetch +refs/remotes/*:refs/remotes/*
>> (which I use for fanning-out my git-svn repos)
>
> Thanks for the pointer (and the quick reply).
>
> That doesn't seem to be what I'm looking for, though -- perhaps I'm missing
> something?  The above puts the remotes in the .git/refs/remotes directory,
> but the .git/config file doesn't have them.

Ah. I believe I misunderstood what you wanted. Perhaps you want "git
remote add", then? Unfortunately, you have to know what your remotes
are outside of git for this. Perhaps a script in the root of your
repository you can run to set this up after the initial clone?

I seem to recall some discussion of allowing a .gitconfig to be in
repositories (similar to .gitignore), but the idea was shot down for
security reasons.

> (As an aside, the above "git config --add" incantation causes problems if
> run inside a clone of a clone:
>
> You did say "something similar" in your reply -- am I not seeing something
> obvious?

I said "something similar" because you probably actually want
git config --add remote.$remote.fetch +refs/remotes/*:refs/remotes/$remote/*
(or other names of your own choosing) so that multiple remote remotes
don't stomp on each other.

Unless you want to be able to address the remotes by name, in which
case you want "git remote add" instead (see above).

Peter Harris
