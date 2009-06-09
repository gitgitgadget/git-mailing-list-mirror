From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments pack protocol description in "Git Community Book" (second round)
Date: Tue, 9 Jun 2009 11:39:56 +0200
Message-ID: <200906091139.58509.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906062338.02451.jnareb@gmail.com> <20090607200617.GA16497@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 11:35:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDxjn-00016q-7V
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 11:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbZFIJfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 05:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753007AbZFIJfM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 05:35:12 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:65533 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbZFIJfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 05:35:10 -0400
Received: by ewy6 with SMTP id 6so4998617ewy.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4qkb/1+p7uzq5hNRGUokyQ9uxcMftHfyMAzis9L+sfE=;
        b=EY6RuTx7hMiMbA5T113lrt22hJOOi8mTJGLy+DxRybQHXApRdXQhnmGD3OPbUL24LY
         CKOVUc/YL3UJV2ZOElijmaxUeEA2uRY8BhryfGxyI6dsT62NW1XPs9Xe6v/MT9EJl9EC
         ytLSux+cK4lhqt02j6g10LSH0E3q6ajsh40IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IaxzrI6R/uXXmB1B0kctdf+CjDm6ZuQ4H+AiFJBAIZ7/Wy1M81hk6g+HV4qrpZD2V3
         tVl22BGoHGHrG0MvOlliz5HE5/FEuzAJ57Qbu7YpJOQYMgyctTrBg/OFEGvLGe4vIyM/
         nJ7HtzXkdyaZLt/dKt6kC0Zk5a2S+BJbgjUYc=
Received: by 10.210.57.3 with SMTP id f3mr5518405eba.60.1244540110888;
        Tue, 09 Jun 2009 02:35:10 -0700 (PDT)
Received: from ?192.168.1.13? (abvq34.neoplus.adsl.tpnet.pl [83.8.214.34])
        by mx.google.com with ESMTPS id 5sm1434503eyh.30.2009.06.09.02.35.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 02:35:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090607200617.GA16497@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121161>

On Sun, 7 June 2009, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

> > > ### Fetching Data with Upload Pack ###
> ...
> > Although fetching via SSH protocol is, I guess, much more rare than
> > fetching via anonymous unauthenticated git:// protocol,
> 
> Actually, fetching via SSH might be quite common, think about all of
> those companies using Git internally... they are running something
> like Gitosis or Gerrit Code Review, both of which support SSH only
> access to the hosted repositories.

I am blind... I forgot that Git is not only used for F/OSS software,
but also for developing proprietary code in company intranets; here
you have limited number of people you want to have read access to
repository.

> 
> > it _might_ be
> > good idea to tell there that fetching via SSH differs from above
> > sequence that instead of opening TCP connection to port 9418 and
> > sending above packet, and later reading from and writing to socket,
> > "git clone ssh://myserver.com/srv/git/project.git" calls
> > 
> > 	ssh myserver.com git-upload-pack /srv/git/project.git
> > 
> > and later reads from standard output of the above command, and writes
> > to standard input of above command.
> 
> Yes, this should be mentioned.  We actually should document in
> the protocol specifiction how we fork SSH, and what the SSH server
> should then be presenting as the command line.
> 
> I've run into problems with hosting sites like GitHub and Gitoriuous
> not correctly honoring some ssh invokes, because they use the forced
> command execution model and were handling only one case that could
> be presented to them.

Can you offer some details?  Or is it out of scope of git pack protocol
description, and more about correctly implementing SSH protocol and
remote command invocation in it?

> 
> > The rest of exchange is _identical_ for git:// and for ssh:// (and
> > I guess also for file:// pseudoprotocol).
> 
> Yes, the file:// pseduoprotocol works by forking a child to run the
> `git-upload-pack /srv/git/project.git` executable and runs a pair
> of pipes between them, just like ssh:// does when it spawns off
> the ssh client process.

That would be nice information to have for people (re)implementing Git,
I think.

Sidenote: it will be the same for planned "smart" HTTP protocol, but 
for the fact that HTTP is stateless, and additionally some kind of state
information would have to be passed.

> > Footnote: [pkt-line format] somewhat reminds / resembles 'chunked' transfer
> > encoding used in HTTP[1], although there are differences.
> >   http://en.wikipedia.org/wiki/Chunked_transfer_encoding
> 
> This is not worth mentioning.  pkt-line is different enough that
> it may just confuse the reader.

O.K. 

I mentioned it because it also uses hexadecimal for length.

>  
> > Below there is (for completeness) list of git-upload-pack
> > capabilities, with short description of each:
> > 
> >  * multi_ack (for historical reasons not multi-ack)
> ...
> >    See the thread for more details (posts by Shawn O. Pearce and by
> >    Junio C Hamano).
> 
> This really needs a diagram example, like the one I drew, to
> explain the concept.  Its really hard to grasp from just reading
> that paragraph what that implies, especially if you are implementing
> a client or a server.

While I don't think that one would have to describe Git object model,
and Git repository storage model (the Git repository storage model, 
i.e. loose object format, and packfile and packfile index format,
and everything else in .git should be described in separate RFC-like
document, in my opinion), it would be helpful to describe "history DAG"
model Git uses, and a bit about revision walking.  What use would be
describing git pack protocol, if the idea behind it, namely coming up
with optimal packfile to send won't be understood?

> >  * no-progress
> > 
> >    Client should use it if it was started with "git clone -q" or
> >    something, and doesn't want that side brand 2.  We still want
> 
> typo, should be "... side band 2." :-)
> 
> >    sideband 1 with actual data (packfile), and sideband 3 with error
> >    messages.
> 
> Also, this capability really only makes sense if side-band or
> side-band-64k was requested.  IOW, a sane client wouldn't ask
> for this if it doesn't support side-band.

Right. "no-progress" makes sense only in context of sideband, currently
"side-band" and "side-band-64k". For server it means that it MUST send
(currently) only streams 1 (data) and 3 (fatal error); conversely it
MUST NOT send stream 2 (progress).

-- 
Jakub Narebski
Poland
