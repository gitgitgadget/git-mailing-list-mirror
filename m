From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mercurial on BigTable
Date: Fri, 12 Jun 2009 09:14:14 +0200
Message-ID: <200906120914.16185.jnareb@gmail.com>
References: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com> <m34oun41pz.fsf@localhost.localdomain> <20090612034645.GO16497@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 09:14:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF0y7-0005dS-CU
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 09:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbZFLHOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbZFLHOV
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 03:14:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:40604 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbZFLHOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 03:14:20 -0400
Received: by fg-out-1718.google.com with SMTP id d23so80770fga.17
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gK7E2jVTB8G7cpr8xWhwMmKww7DPCpM6Amuj3MSPWC0=;
        b=PbBSWSsNpSLVpxB3vVmBo2/gB6uoPf4PeXmHmZLS7hayoQfGO6EWlLSpWK7HJw7KVK
         /9Z5/4RFUFyStjdGg9W2CoQoHap5+YhLoDI8CMYoQDcq0rbaxJOwtUPxstwJ0zMumPD5
         HP/61gAY8xIys6ilp0g4MJpHu2q+6N0VicEvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ax0U2awxwxlkhki2krxQT16/J+Z7hI8V/n9LwVTmZMbB0f9RsPn5j1hTlaHlO6nNkO
         oloRP9M520sszKu9phS/wAGt8dmqsE4jyPyUsmFb0biZhh8ipYrl5e0+C5TUdAED/3Yg
         Fdegv3QUAAjhbbLpgOly3ROnf3NyMtcoWaUNI=
Received: by 10.86.57.9 with SMTP id f9mr3315588fga.33.1244790862088;
        Fri, 12 Jun 2009 00:14:22 -0700 (PDT)
Received: from ?192.168.1.13? (abwj246.neoplus.adsl.tpnet.pl [83.8.233.246])
        by mx.google.com with ESMTPS id 4sm2666248fgg.13.2009.06.12.00.14.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Jun 2009 00:14:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090612034645.GO16497@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121395>

On Fri, 12 June 2009, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Andreas Ericsson <ae@op5.se> writes:
> > 
> > > I'm more curious as to why they didn't choose git. The only explanation
> > > that was actually true is that hg works well over HTTP 
> > 
> > Well, Google App Engine was in Python, so it follows that the crew
> > would have it easier understanding Mercurial code (which is written in
> > Python with parts in C for performance), and in moving it to BigTable.
> 
> This has nothing to do with Google AppEngine.  GAE has CPU and
> bandwidth limitations in place that make running a source code server
> like Hg on it impossible.  E.g. the maximum size you could download
> in a single HTTP request was 1 MB, now its up to 10 MB (IIRC).
> The Hg hosting runs in a different cluster than the GAE hosting does,
> and are managed by different teams.
> 
> > Adding Java to Gogle App Engine is, as far as I know, fairly recent;
> 
> True, yes, GAE Java support is fairly new.

I didn't wanted to say that support for Mercurial (or other DVCS) in
Google Code had anything to do with Google AppEngine.  Rather I wanted
to imply that what might have mattered when choosing between Mercurial
and Git was the fact that there was large pool of people who are 
proficient in Python (and later in Java) _and_ with web application(s).

But I don't quite see how lack of good over HTTP support should matter;
if they are rewriting Mercurial[1] (and earlier Subversion) to use 
BigTable, couldn't they add "smart" HTTP protocol support to Git 
(which I think would be easier)?

[1] Mercurial is not AGPLv3 licensed...

> 
> > additionally JGit (git implementation in Java) is not yet full
> > implementation.
> 
> JGit implements sufficient parts of Git to be a full server, and
> could power a hosting site... indeed it powers Gerrit Code Review,
> which some companies do use as their entire Git server solution,
> rather than e.g. Gitosis.

By "not full implementation" I meant here that as far as I know JGit
doesn't have yet support for _creating_ (as opposed to simply reusing)
deltas in packfiles.


P.S. On the other hand, Mercurial support for multiple branches is
not so good[2], and the way tags got implemented seems iffy to me...

[2] http://schacon.github.com/2008/11/24/on-mercurial.html

-- 
Jakub Narebski
Poland
