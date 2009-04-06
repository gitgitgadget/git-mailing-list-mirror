From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 5 Apr 2009 22:53:01 -0700
Message-ID: <20090406055301.GA17080@gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> <200904052358.53028.markus.heidelberg@web.de> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com> <200904060117.24810.markus.heidelberg@web.de> <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com> <20090406032457.GA14758@gmail.com> <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 07:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqhnA-0000J7-Kh
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 07:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbZDFFxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 01:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbZDFFxN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 01:53:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:17238 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbZDFFxN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 01:53:13 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1603172wah.21
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 22:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=S1xFArUTHacXNj0NQ2AdbiwFiRLmTdpcGF12qkWb9HQ=;
        b=QdYbjXipzTDv8j42li/n0Y8/maD8LUVTmmlt+TPu/RzR1v1Ht8TPYsEYXNyrTH581V
         tfKFbuprNues8rZW49KTR0eBqH86V4y/x+52iHN6MqgB8jnPCKdB4YsqPB55C1errFYz
         gznSz4/0lX+TR8pQuK9sSrFEpzi/qJz56y9kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cI4+UlmBksIwslaZkcJAABJ4moYB0MH7PYErmOt3sa5AOgsWo5tV0Vtv9EcWbWpKEL
         CansORAg9vsrelXOg+QJjcSUARkl8xSwBvi0pOXIiOp6UrKLxL3D9RiURZoMCr5DNa3C
         TdrcoOSXTPtcw36lXOZ5tKUdmT1tupkHWvjz8=
Received: by 10.115.89.18 with SMTP id r18mr2079800wal.111.1238997190361;
        Sun, 05 Apr 2009 22:53:10 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j31sm5075458waf.26.2009.04.05.22.53.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 22:53:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115768>

On  0, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > On  0, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> >> Heya,
> >> 
> >> On Mon, Apr 6, 2009 at 01:17, Markus Heidelberg
> >> <markus.heidelberg@web.de> wrote:
> >> > Felipe Contreras, 06.04.2009:
> >> >> But actually, "git diff --cached" is a
> >> >> different action; you can't do "git diff --cached HEAD^.." for
> >> >> example.
> >> >
> >> > And I neither could I do "git stage diff HEAD^.."
> >> 
> >> I rest my case ;). That's the whole point Felipe is trying to make here.
> >> $ git diff --cached
> >> $ git diff HEAD^..
> >> 
> >> That's two different modes of operation with the only difference being
> >> a switch ('--cached'), which changes what is, and what is not valid
> >> after that.
> >> 
> >> Whereas with
> >> $ git stage diff
> >> 
> >> There is no confusion that 'HEAD^..' is not a valid argument, as there
> >> is no command in 'git stage diff' to which it _is_ a valid argument.
> >
> > Here's an interesting email from a while back:
> >
> > http://kerneltrap.org/mailarchive/git/2008/10/29/3857134
> >
> > The above mentions the following suggestion:
> >
> >     git diff STAGE WORKTREE   (like "git diff" today)
> >     git diff HEAD WORKTREE    (like "git diff HEAD" today)
> >     git diff WORKTREE HEAD    (like "git diff -R HEAD" today)
> >     git diff HEAD STAGE       (like "git diff --cached" today)
> >     git diff commit STAGE     (like "git diff --cached commit" today)
> >
> > From a consistency and usability perspective, the above
> > example seems very appealing because:
> > ...
> > All we'd have to do is teach git-diff to special-case
> > 'STAGE' and 'WORKTREE'.  Now, whether we'd want to do
> > that is a completely different discussion, but I figured I'd
> > throw the old thread out there.
> 
> How would you express operations the current --index option does in such a
> scheme?  Yet another WORKTREEANDTHEINDEX token?


Is it a trick question?
git-diff doesn't have an --index option, only --staged.

Ah, I know the answer:

http://kerneltrap.org/mailarchive/git/2008/11/12/4072144
http://kerneltrap.org/mailarchive/git/2008/11/12/4067114
http://kerneltrap.org/mailarchive/git/2008/11/2/3896104

I did say it *seemed* appealing, not that it actually was ;)


Alrighty.. my only purpose was to bring up the old thread
since I think many ideas were fleshed out back when
'git diff --staged' was introduced.

How useful it is in the context of this discussion about a
new 'stage' command is questionable, so I'll shut up now =)

-- 

	David
