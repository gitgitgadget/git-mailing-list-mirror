From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 15:36:52 -0400
Message-ID: <9e4733910704211236m7f88aef2r76a1c4a3b72b1c75@mail.gmail.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
	 <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
	 <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
	 <9e4733910704211059h16c06e11k967d0bdd3e4970fc@mail.gmail.com>
	 <e5bfff550704211128i12035947i7597e920a0eca163@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 21:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfLOD-0003xb-VZ
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 21:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbXDUTgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 15:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbXDUTgz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 15:36:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:58588 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbXDUTgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 15:36:54 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1184098wra
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 12:36:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZwQ8zUkApXhPXciZUUGuNqhx28XE/9Nyvd1gVU0BOaji9ZOoWkX1xyxZnVLRZdqeYFsaikO8zrdekBm7kr5u7oWVrBKCOS6vF9k2l2a798hBMrvqyS2OlM9kroJFx3ZeAESco44jF/OtZCVVFFSkdzF8G18difV5UkKgHSE2QwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Guq6VHh2qgo/HqtSCKGJ7LVMY8dehlxiUQWmgNDwM+Bl1ufUS7P0Q4vT7xoMAoo4aWHjRVzTVKTD+YwMwK2sxJxG3MCB0aC8IMXPyZjZNsOiU/4AvJrAYezy44CDtBnxS+Aa/f1bpT6Qwhv9TGlNHf8TzSd3Nu7qu5VneEb1ZZY=
Received: by 10.114.27.20 with SMTP id a20mr1786931waa.1177184212993;
        Sat, 21 Apr 2007 12:36:52 -0700 (PDT)
Received: by 10.114.194.9 with HTTP; Sat, 21 Apr 2007 12:36:52 -0700 (PDT)
In-Reply-To: <e5bfff550704211128i12035947i7597e920a0eca163@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45190>

On 4/21/07, Marco Costalba <mcostalba@gmail.com> wrote:
> I would say this probability is veery veery low in random case (not a
> malicious attack of course, but I think this is not the case with git
> repository as it was with SHA1 designers).

The SHA is also a security signature against tampering. All commits
having an SHA. These SHAs are repeated into a check-in entry, which
then gets an SHA. Releases are identified by publishing an SHA.

You take the release SHA and use it to find/verify the commit record.
Opening the commit record gives you the SHA of all of the pieces of
the commit. (I simplified this by ignoring trees).

This stops some one from altering a file in a git repo as a way of
inserting malicious code. If you alter a file all of the SHAs that
depend on it will change. It is very, very difficult to figure out how
to patch a file and not change the SHA for it.

This is a real problem and people have tried to secretly insert code
into the Linux kernel in the past.

-- 
Jon Smirl
jonsmirl@gmail.com
