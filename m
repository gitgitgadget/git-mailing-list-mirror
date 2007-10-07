From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Sun, 7 Oct 2007 18:50:56 +0400
Message-ID: <37fcd2780710070750g23deb2e1q1b9a7e5c555a44bf@mail.gmail.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	 <Pine.LNX.4.64.0710042209410.4174@racer.site>
	 <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
	 <4705FB52.3030208@op5.se>
	 <1191599763.7117.18.camel@hinata.boston.redhat.com>
	 <20071005211011.GB25125@potapov> <470878CB.2010609@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>, andyparkins@gmail.com,
	torvalds@linux-foundation.org
To: "Marko Macek" <Marko.Macek@gmx.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 16:51:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeXTI-0005Jv-5F
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 16:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbXJGOu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 10:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbXJGOu6
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 10:50:58 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:48172 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbXJGOu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 10:50:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so519616rvb
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gtMWoUdkIuA+07iA+QxtOyo3cRfjvbHjz6gzmS/u8qo=;
        b=qrmXLkd5hF6+F7j8SJ4TdujxKG3U8Uey7dRyZr/uaQLYgtf7QXbeimU3fhS942Vq0FCfXBS6hTJT1Mhb9D8CkwZnTVYKa5wsux0IsTcd4FfISa3gOeGfTCC9p9dukcxHLDdf2XdYRguzIVLE+GlZepcsKOUR2rT0JvscE38PzAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XJAZi7OePgeXoRXjbmv2kP3MFYBjT2sM0x8G9QyOWzbZ8hc7Vha+LPCPSSanQlqKGQU4BJVQzGlacYqQ7w3JapTqMPreJb83bWth/0wIleA5fyp4NNKKOVGEinAs+zOK2ybMxN3vr5kEAy9jx8+fwa9WPt3BdnfjFGANryOHPjc=
Received: by 10.143.161.3 with SMTP id n3mr1894100wfo.1191768656812;
        Sun, 07 Oct 2007 07:50:56 -0700 (PDT)
Received: by 10.143.37.15 with HTTP; Sun, 7 Oct 2007 07:50:56 -0700 (PDT)
In-Reply-To: <470878CB.2010609@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60182>

On 10/7/07, Marko Macek <Marko.Macek@gmx.net> wrote:
> Dmitry Potapov wrote:
> > You don't. Even with 'commit -a' there is no guarantee that the
> > result will compile, because you can forget to add a new file.
>
> Actually, it would be a good idea for commit to report an error if there
> are any new files that have not been 'added' or 'ignored'

If it is good for you, you can add this check to your pre-commit hook.
However, I don't like your idea at all. Sometimes, you do want to have
some file that is not 'added' or 'ignored' as a reminder that you have
something else to do. IMHO, git acts in the most reasonable way in this
respect. When you say 'commit -a' and you have some files not added,
it will show you all untracked files in your editor when you type a
commit message. So, it is more difficult to forget to add a new file
with git than with many other version control systems.

> (or even
> if there are missing files that have not been 'deleted'.

Actually, 'commit -a' will automatically delete all missing files.
IMHO, it is the right thing to do.

Dmitry
