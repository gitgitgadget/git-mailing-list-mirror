From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb.cgi: Teach tree->raw to not require the hash of the blob
Date: Wed, 12 Jul 2006 11:02:04 -0700 (PDT)
Message-ID: <20060712180204.23953.qmail@web31801.mail.mud.yahoo.com>
References: <e92c1e$lvk$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 20:02:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0j2I-0000SW-Ne
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 20:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWGLSCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 14:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWGLSCG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 14:02:06 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:56243 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932262AbWGLSCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 14:02:05 -0400
Received: (qmail 23955 invoked by uid 60001); 12 Jul 2006 18:02:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rgIdnq60V1MmJwFLBc4kUeXNDJncpagzIpRAeVriR9rKAcNTqejm6CEBKum8/SamNm0X8nyIbUo+u8MbD+he/fzH8uK1jP5PNamC3hNA710m5tfUlE1ezkhMf5aVITM4Vjl9wITrSPCvmLeA58Gj6A3cnYnelh5JSFRGnhKYQHc=  ;
Received: from [68.186.50.195] by web31801.mail.mud.yahoo.com via HTTP; Wed, 12 Jul 2006 11:02:04 PDT
To: Jakub Narebski <jnareb@gmail.com>, junkio@cox.net
In-Reply-To: <e92c1e$lvk$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23794>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> > 
> >> Teach tree->raw to not require the hash of the blob, but to
> >> figure it out from the file name.  This allows to externally
> >> link to files into the repository, such that the hash is not
> >> required.  I.e. the file obtained would be as of the HEAD
> >> commit.
> >>
> >> In contrast tree->blob for binary files passes the hash, as
> >> does tree->blob->plain for "text/*" files.
> 
> > I think _allowing_ to accept filename not hash is a sane change,
> > and would be useful if you want to allow linking to always the
> > HEAD version from external sites, but I do not think listing the
> > raw link in the tree view without the hash is a good idea.  It
> > makes things quite confusing that "blob" link in its
> > neighbourhood gives the blob from that specific version, but
> > "raw" gives the version from HEAD, even when you are browsing
> > something other than HEAD.
> > 
> > BTW, can somebody volunteer to be a gitweb/ "subsystem
> > maintainer"?
> 
> I think the change to raw aka. blob_plain and not to plain is because in
> plain view you have this HEAD link which takes us to HEAD revision of the
> file (even if we are on different branch IIRC).
> 
> Workaround for either format is to remove 'h' (hash) parameter entirely, and  
> put in 'hb' (hashbase aka headref aka branch) the branch name. Gitweb then
> shows the contents of latest version of the file.
> 
> BTW. sometimes you want to link to specific version of the file, and
> sometimes to newest. I think it would be best (if possible, feasible, and
> not too much resource consuming) that links from tree specified by hash be
> to specified by hash version of file, while links from tree specified by
> headref and name only would have links to latest version of the file.

You seem to have hand-edited the mail headers to remove
Junio and myself from the CC/To headers list, but leave git@vger.

Please don't do that.  Just click Reply-All and continue with your
message.

Thanks,
    Luben

P.S. Restored.
