From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Rename handling
Date: Tue, 20 Mar 2007 08:19:11 +1200
Message-ID: <46a038f90703191319y54251f63ldc6060ffbc89deea@mail.gmail.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
	 <45FED31B.8070307@midwinter.com>
	 <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
	 <Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
	 <45FEEB0C.3080602@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Nicolas Pitre" <nico@cam.org>,
	"John Goerzen" <jgoerzen@complete.org>, git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:19:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOKF-0002EQ-Vm
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbXCSUTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbXCSUTY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:19:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:39337 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbXCSUTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:19:24 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1406664wxd
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 13:19:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RoOPLc1RJlhrB/tafVa6R+ywstlLHVLQzOd2C8s8me89N+HAXoDM42bvO61WUtawWAu9Lqt5Xia7B1Tp3OGYu27H5ATNvGrIrvUoyJ6MUNLV75kv4MhD/euUksQzNba7JAxK0qgMY6ZamdsS6BASle1ERd1J6p9eiA4v8tXUnEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fKgQ72HEnCTS0HyoSFA6WHdaOl2KtW0nWxQZXFiIcIV0sTmY6Ye6o4TGbhLY5FUdEWmwHtqLQvVHPPltXFLVvHsORXypzXffn2DOy9XuS+OCOplTLrSl3ssB3Mjxz3UJyzydScT7gv7M2QXl5JLHCZKbGYhvveacT+5alzTJYe8=
Received: by 10.90.66.9 with SMTP id o9mr4686187aga.1174335551833;
        Mon, 19 Mar 2007 13:19:11 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Mon, 19 Mar 2007 13:19:11 -0700 (PDT)
In-Reply-To: <45FEEB0C.3080602@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42665>

On 3/20/07, Steven Grimm <koreth@midwinter.com> wrote:
> However, "Should we keep the existing rename detection?" is not the same
> question as, "Should the user be able to tell the system he's renaming
> something?"

How is a $SCM-mv that remembers useful in any _interesting_ scenario?
You don't move it just because, you refactor and re-architect
something.

In that area, git's mergers still have a bit to go -- I do hope for a
day when I can say git-merge -s refactor or just git-merge -s
tryharder so that it if hunks don't apply, git will try and trace
where the block of code the hunk applies to has gone.

So recording mv doesn't solve anything other than 1% of the cases --
those full file moves that git will discover anyway even if the file
changed a bit. And recording the mv gives you a false sense of being
useful. It's not.

There's more work in having
go-slow-and-really-try-to-merge-across-a-refactor mergers that could
at least hint at where the hunk is likely to belong now.

> Until someone comes up with a way to make content-based rename detection
> 100% foolproof in the face of things like frequent self-references

Well, if code changes, there are no guarantees. Patching is a
best-effort-but-not-too-smart thing. But in the end, a human needs to
look at it if it's tricky. Wiggle users know ;-)

And, at the end of the day, hitting programmers that move sh*t around
needlessly in the head works too. You wouldn't let them change
projectwide function/method name conventions willy nilly either.

cheers,


martin
