From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 1 Nov 2008 13:26:24 +0100
Message-ID: <200811011326.25224.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <m3prlffzk2.fsf@localhost.localdomain> <87abcjpvy2.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:24:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwEaa-0002S5-DM
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYKALXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbYKALXG
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:23:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:26627 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbYKALXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:23:03 -0400
Received: by ey-out-2122.google.com with SMTP id 6so607438eyi.37
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TsN+g8ontWZRdW4jaD0Erkwgxwx2EW28MU6KRYWAW3g=;
        b=Y6QJ+4Xqg8VOo1BYlNRTwaXgGphhzLRVjhUKjR+2rierTDyJFKGSkTzC6mQmy4PARa
         g+JbdsatME3bF+NG3vxfER8ibrJQEeJAVsqTQIY1grIGPAKRv2IromgC57KuU+fv/8b3
         iGrSL/Ob+0py3k95lg1GnAbs8BXFFYZXUdcvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xZoL+jHzdRWdOK2+/DlsCGKc7ztbx5M42mVYTKnaNC/3jjeqUeOtINORXO/1arS4Yj
         ZUhYUhh+hVJFiNvfX4uHXn1dVO/bgFkYG8d3vaLK4Yk0KytPrezAD9mJpxLi+ca0zUyy
         Sb96oDOnGZCVm6dYTAJk74DQ8mY50f9wvTe3k=
Received: by 10.210.37.16 with SMTP id k16mr4560374ebk.75.1225538581740;
        Sat, 01 Nov 2008 04:23:01 -0700 (PDT)
Received: from ?192.168.1.11? (abvc198.neoplus.adsl.tpnet.pl [83.8.200.198])
        by mx.google.com with ESMTPS id 7sm5648205eyg.0.2008.11.01.04.22.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Nov 2008 04:23:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <87abcjpvy2.fsf@mid.deneb.enyo.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99734>

On Sat, 1 Nov 2008, Florian Weimer wrote:
> * Jakub Narebski:
>> Florian Weimer <fw@deneb.enyo.de> writes:
>>> * Theodore Tso:
>>> 
>>>> In the past I've looked at the possibility of creating a
>>>> bi-directional, incremental gateway between hg and git repositories.
>>>> The main thing which makes this difficult is that hg stores tags
>>>> in-band inside the change-controlled .hgtags file.  This means that if
>>>> you cut a release, tag it, and then create a commit to further modify
>>>> the repository, the new commit is descended from the tag commit,
>>>> whereas in git, the tag is a "bookmark" --- perhaps signed via GPG,
>>>> but not part of the revision history.
>>> 
>>> Couldn't you just keep the .hgtags file and have everyone interested
>>> in the tags use special scripts?
>>> 
>>> (Admittedly, I'm horribly totally by Git's behavior in this area.  I
>>> haven't figured out yet under what circumstances tags are pushed and
>>> pulled, so I'm not totally opposed to the Mercurial model. 8-/)

>> Do you agree that global tags should be both non-versioned and
>> trasferable?
> 
> Yes, I do.  In case of Git, I've got trouble with understanding how to
> actually implement the "transferable" part with Git.  The Mercurial
> way is easier to understand, but it means that tags may need some sort
> of "tag at this revision" qualifier to disambiguate, which is rather
> problematic.

In first page of git-fetch(1):

     When <refspec> stores the fetched result in  tracking  branches,  the  tags
     that  point  at  these branches are automatically followed. This is done by
     first fetching from the remote using  the  given  <refspec>s,  and  if  the
     repository has objects that are pointed by remote tags that it does not yet
     have, then fetch those missing tags. If the other end has tags  that  point
     at branches you are not interested in, you will not get them.

You push tags explicitly (using "tag <tagname>" refspec, or specifying
--tags, --all or --mirror, or setting it up in a config) in git.
 
>> Now Mercurial has chosen to use in-tree '.hgtags' file to have global
>> tags transferable.  Never mind the fact that it had to treat this file
>> in special way to have it non-versioned
> 
> Oops, thought this file was versioned.  Things like
> 
>   <http://tycoon.hpl.hp.com/changeset/932:931d181e9f58/.hgtags>
> 
> suggest it was at some point.

It is half-versioned... :-X  From what I remember of discussion on
#revctrl and reading hgbok it is treated in special way: if you
switch branches or rewind to some older version, .hgtags is always
checked out the most recent version.

I don't know how Mercurial deals with situation where one reposityr
added one tag, and other repository add other...

-- 
Jakub Narebski
Poland
