From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 21:23:47 -0500
Message-ID: <20091031022347.GA5569@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091031013934.GD5160@progeny.tock>
 <7vk4yccodl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 03:22:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N43bO-0001PX-6J
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 03:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbZJaCVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 22:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757638AbZJaCVo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 22:21:44 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:55705 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757628AbZJaCVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 22:21:44 -0400
Received: by ywh40 with SMTP id 40so3231968ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JoaptZ2+Q66eMmYzDGKKNAwRXCBkyMqJzFk7kzZp7Ic=;
        b=Y70y+oyzaXQgUhXs7WlU6fqiH/akccwoAM/IUaacOc9CG+n+OX5wL7gzynrnjFcbhR
         f4e5DZMBp+uYzKdSy/fC8sC5280g0P0KvOZT2ds+DiR1ntlbh/HnZ4FxKqy7TwWeSGm7
         Z3dMtRNt93NRNtn6N060Y3tz0is50Xgu7ARFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MD+pdp81PY07hFTZe6cpjyfJFFSUbCbFAbSdcLZMjgam/4cTt0HBlrpJt7n1gzNCTq
         eFXfrIqUlxBbiAKjhlcLoFexl24Z+NrfwhAQ6JIKYTtaeP4XA83o/Yg5dPLbRF7w1N0p
         t2ieEviAwJ4ghqewWuUkCiNgqPGhpS0PIbXK0=
Received: by 10.91.148.16 with SMTP id a16mr6118016ago.119.1256955212179;
        Fri, 30 Oct 2009 19:13:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm1611768yxg.6.2009.10.30.19.13.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 19:13:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk4yccodl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131826>

Junio C Hamano wrote:

>> 	core.logallrefupdates=3Dtrue
>>
>> 	*** Please tell me who you are.
>>
>> 	Run
>>
>> 	  git config --global user.email "you@example.com"
>> 	  git config --global user.name "Your Name"
>>
>> 	to set your account's default identity.
>> 	Omit --global to set the identity only in this repository.
>>
>> 	GIT_COMMITTER_IDENT=3Duser <user@domain> 1256952739 -0500
>> 	GIT_AUTHOR_IDENT=3Duser <user@domain> 1256952739 -0500
>> 	warning: GIT_EDITOR: terminal is dumb, but EDITOR unset
>=20
> Sorry, I cannot grok this example.  Is it supposed to be a transcript
> of a user session?  What did the user type?

Oh, sorry about that.  The user typed 'git var -l', and that is all
output from that.  More realistic examples:

$ # what scripts see
$ git var -l 2>/dev/null
gc.auto=3D0
rerere.enabled
merge.log
merge.conflictstyle=3Ddiff3
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
remote.origin.url=3Dgit://repo.or.cz/git
branch.master.remote=3Dorigin
branch.master.merge=3Drefs/heads/master
GIT_COMMITTER_IDENT=3Duser <user@domain> 1256952739 -0500
GIT_AUTHOR_IDENT=3Duser <user@domain> 1256952739 -0500
$
$ # what scripts pass on to the user
$ git var -l >/dev/null

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

warning: GIT_EDITOR: terminal is dumb, but EDITOR unset
$=20

At least, that is what I was imagining (that=E2=80=99s one way to use g=
it var,
anyway).

Would a more friendly message be helpful here?  I am not sure how 'git
var -l' gets used.  I never liked using it directly myself, mostly
because the long list of configuration items can be overwhelming.

Jonathan
