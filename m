From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Mon, 4 Aug 2008 20:06:30 +0400
Message-ID: <20080804160630.GW7008@dpotapov.dyndns.org>
References: <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org> <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no> <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de> <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com> <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de> <905315640808030954j7487a010p136c73406298ee29@mail.gmail.com> <20080803173339.GQ7008@dpotapov.dyndns.org> <905315640808031154j28778cd6pee75e6b008304941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 18:08:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ2bS-0008UJ-3F
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 18:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758688AbYHDQGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 12:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754623AbYHDQGj
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 12:06:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:24508 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758667AbYHDQGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 12:06:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1024460fgg.17
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SJNKYtCfnNLR5PypCamM6ljIVXF1koVdyV3CHp8kTYY=;
        b=PorH9G7agOjyiQW/09hHGlz2s2DqkOqCBIhBZ8LpHe97FFZYLJCPqgYh53/08VZwsW
         QKRBjkS2EBrXxNE7xc0sz0Y4eK/HdmOfBslDyTna/EfK7nMGLxYBJTkpK7ffeqFA9/M3
         onqEpxV/0LR8eFJMDbF23qA6AfQmkSuqA5ITU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HblBaYI0pHhArnb2wjobbEdhrcEB8bZ3CQSgic73B3fLeHfHTRaEBCGUIEY38URSjw
         7d1OwMNSom/u3fplw4mf+fjgk5cVdzlzxxx0eW4tj+P7ENYBjwqP3CqH8Y8pYVUVbiRX
         jeyL5YWvvqgGaAdhzJqIqbGgnlDF6dkC+CMeU=
Received: by 10.86.26.11 with SMTP id 11mr10520760fgz.12.1217865995221;
        Mon, 04 Aug 2008 09:06:35 -0700 (PDT)
Received: from localhost ( [85.141.237.93])
        by mx.google.com with ESMTPS id 4sm150382fge.5.2008.08.04.09.06.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 09:06:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <905315640808031154j28778cd6pee75e6b008304941@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91378>

On Sun, Aug 03, 2008 at 11:54:34AM -0700, Tarmigan wrote:
> On Sun, Aug 3, 2008 at 10:33 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > On Sun, Aug 03, 2008 at 09:54:42AM -0700, Tarmigan wrote:
> >>
> >> For all I care, git can consider the files as binary, but by *default*
> >> I should get back the same as I put in.
> >
> > Sorry, but Git is a source control system,
> 
> I think this is the heart of the disagreement.

I guess so... Because for me it is very important that most of files I
store are text files. In fact, such operations as diff and merge would
not make much sense for binary files, would they? IOW, Git is a revision
control system, not a versioning file system.

> What I love about git
> is that git trusts me, the user, and it trusts my files.

Sure, git trusts you. You can always turn off some features if you don't
like them; but the issue having the right defaults. autocrlf=true is the
right default if you want to have CRLF in your work directory. And as
long as text heuristic is right (and it works pretty damn good), you get
exactly what you put in it. In very very rare cases where the heuristic
is wrong, it will warn you about that you are not going to have back what
you put. So, you can tell Git explicitly that you want this file stored
as binary. But this situation is very unlikely unless you store in it
something like svndump files, but storying such files in not the main
purpose of Git.

So, I don't think that this CRLF conversion is a real issue, except that
the fact that changing the global autocrlf value should not have changed
autocrlf in already existing repositories. Because autocrlf is not just
a preference, but also determines in what format your files in the working
directory are stored. So, I believe it should be corrected. But even in
this case, you do not really lose anything.

> It doesn't change the encoding of my filenames by default.

And not by default? Currently, does not support encoding filenames
from your local encoding to UTF-8. And that will be a problem at
some point if you store file names in non UTF-8 encoding. But it is
a separate issue connected to i18n support. I don't think it makes
sense to go into it right now as it is completely irrelevant to the
problem we discuss.

What is relevant is that Git *does* change filename representation.
For instance, if you try to add a file with a name 'foo\bar', Git
will actually add 'foo/bar'. You see, on check-in, Git converts the
directory separator from its Windows form ('\') to the format it uses
internally ('/').

So, it is logical to do the same text files, because text files are
sequences of lines separated by line-separator, which is CRLF on
Windows, but its internal representation in Git is LF.

> It doesn't do keyword expansion by default.

Because keyword expansion is almost always meaningless thing to do
in your working directory. It just makes things slower and you do
not win *anything*. Arguably, there are some cases when you may
want some expansion during export your sources to archive, but even
that is very uncommon.

> It doesn't change the case of filenames by default.

Change case? Would it not be a completely insane thing to do? People put
some meaning in what registry of letters when wrote names, why would you
want Git (or any source control system) to mess up with that?

> If git is not willing to change the encoding/case of file*names* by
> default, how is it acceptable to change the *content* of the files
> themselves?

It does not change the content, it changes the EOL marker from its
external to internal representation. It does the same thing as what C
library on Windows does when you read or write files in the text mode.
This should be completely transparent to users as long as autocrlf is
not changed.


Dmitry
