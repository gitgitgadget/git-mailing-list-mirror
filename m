From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Problem with git-svn
Date: Sat, 22 Dec 2007 15:38:40 +0100
Organization: Home - http://www.obry.net
Message-ID: <476D2170.70902@obry.net>
References: <4764FE2C.1010103@obry.net> <20071219082751.GA17787@muzzle> <47690031.7090409@obry.net> <20071220183007.GA26767@untitled> <476AD1AB.8040406@gmail.com> <20071222042924.GA18812@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pascal Obry <pascal.obry@gmail.com>, git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 15:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J65VV-000070-PR
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 15:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXLVOiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 09:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbXLVOiv
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 09:38:51 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:20749 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXLVOiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 09:38:50 -0500
Received: by fk-out-0910.google.com with SMTP id z23so926181fkz.5
        for <git@vger.kernel.org>; Sat, 22 Dec 2007 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=py+5NMuJ0CQSZ5HDF6a/BXPLXLdyXZ9W96dLuFUsSp4=;
        b=rClT9VInhDIdeiJoS1cnMrO5ttANH/ThId1I1R9RkXcdjBgmMAtxhH2X93oupnLSDukicmyOvPF9dC/1lKYWZ16EASouuAJ8zcFpiQHJTWIN4LBccsleiLlWK38QZudcUGX9NTeuCX6lECuft+y9Y4dOCLXN0jQPoH4DIi3OXdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=b1WcftgCmGAnr8qQmuNT1cq1cFGlnctjnhNKjrUyxqlQsCmo3Pc/58HzLMKsGor1jU8xiVxpovopgt8jQyCXXSbBHJ1EB4uDXMEqrdpiyoD3pq4u/uAXBC2euHTbrJJbrbnKJnHUj+VYaHiNzCdbR3DVqEXvmUKZDNBkQOP8MWk=
Received: by 10.78.201.2 with SMTP id y2mr3188308huf.56.1198334328788;
        Sat, 22 Dec 2007 06:38:48 -0800 (PST)
Received: from ?192.168.1.10? ( [90.51.151.191])
        by mx.google.com with ESMTPS id g8sm6381407muf.10.2007.12.22.06.38.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Dec 2007 06:38:44 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071222042924.GA18812@soma>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69136>

Eric,

> Since r48468 was where /importfromcvs/trunk got renamed into /trunk/PROJ
> (from your previous message http://mid.gmane.org/4764FE2C.1010103@obry.net)
> 
> /importfromcvs/trunk exists at r45775, but /trunk/PROJ does not; and
> git-svn at least follows that (which is what I suppose everybody wants).

Right.

> However...
> 
> Did /importfromcvs/trunk exist all the way between r9458 and r48468?  Or
> was that directory replaced entirely by something else along the way?

It was replaced along the way. This very same tree /importfromcvs/trunk
was used to import completely unrelated projects. Then moved, so it did
not exist all the way.

In my case the previous version on this tree was 45546. There is nothing
in between 45546 and 45775 for example. So looking at any revision in
between return an error:

$ svn log -v svn+ssh://myserver/importfromcvs/trunk@45760
svn: File not found: revision 45760, path '/importfromcvs/trunk'

> git-svn may be following copy history too aggressively, in this case.

Looks like it is the case. Hence the reported errors:

W: Ignoring error from SVN, path probably does not exist: (160013):
Filesystem has no item: File not found: revision 100, path '/trunk/PROJ'

and

W: Ignoring error from SVN, path probably does not exist: (160013):
Filesystem has no item: File not found: revision 101, path
'/importfromcvs/trunk'

For sure there was no revision 101 on /importfromcvs/trunk:

$ svn log -v svn+ssh://myserver/importfromcvs/trunk@101
svn: File not found: revision 101, path '/importfromcvs/trunk'

> On the other hand, this was somewhat intended because it could also
> be a way to track merges as "moving" tags[1].
> 
>>    $ git svn clone svn+ssh://myserver/trunk/PROJ --revision=45775:HEAD
>>
>> But it would be lot cleaner to have git-svn handling this properly I think.
> 
> Does --no-follow-parent work in your case?  Or does it go too far
> in stopping at r48468 (probably).

No it works on my case. That's what I'm using to import the directory in
two steps. I just want to go to the bottom of this to see if we can
somehow improve git-svn.

> Maybe another switch should be added (--merge-foster-parent?)

I'm not sure to understand what you are proposing here. To look only at
parents that are directly "related" to the current branch ?

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
