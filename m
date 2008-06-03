From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 16:14:28 +0200
Message-ID: <200806031614.29161.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806031512.20729.jnareb@gmail.com> <b77c1dce0806030636i434e4716r8a52d6aeb93e9719@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>,
	"Sam Vilain" <sam@vilain.net>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 16:15:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3XIP-0006VZ-4e
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYFCOOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbYFCOOf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:14:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:51946 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYFCOOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 10:14:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1041805fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=+VHHH/Ah9/wSiGuFuDpAlzrDptgpdN7h/HeYXqMtvKs=;
        b=YI1JOCLNcvGjDzRCHD5oU7kzKkeEv5oOlgB6mRlyKRolKmw/SS5fnGm4CIwShWv0WAvqMRrJV7f8c3O4sr0eUH18IkfCGzuWSXIvUyUZZ8+KieQFDuGMjw2NsNRIEZxCwwzSOQL7IPHd0aYDRKSVw5OGZE8mmckd60QsPuBJpiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AbqYtE5dtg/V8c/UKYBl1RbDIuEEEZ/d8ReOOlA0AKo/xN46KzJ3E4y2+ZE78L+scHN7DaKV6jpquJOnW6HqJ2zRhmC74rAkhbeUd9ko3ZJEthcnSYc8rXqMVA0vTdujaAl2+H58SMU0MJqSIB+TlNvojnYFXik4z0svHNNcDIE=
Received: by 10.86.25.17 with SMTP id 17mr3504832fgy.63.1212502473710;
        Tue, 03 Jun 2008 07:14:33 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id 3sm39986fge.3.2008.06.03.07.14.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 07:14:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b77c1dce0806030636i434e4716r8a52d6aeb93e9719@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83662>

On Tue, 3 June 2008, Rafael Garcia-Suarez wrote:
> 2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>>>
>>> OK, I see. That would be nice. Also: currently taking "$full_rev^"
>>> directs the user to the parent commit, but it would be more
>>> user-friendly to point at the previous commit where the selected file
>>> was modified instead.
>>
>> That's what I meant by distinguishing between 'parents' and
>> 'original-parents' (or 'rewritten-parents' and 'parents'): first are
>> rewritten parents in history limited to specified file (with the
>> addition of code movements and copying across files/filenames),
>> second are original parents of a commit.
>>
>> For gitweb we would use the first set (I wonder what to do in the case
>> of merge commit, i.e. more than one parent).
> 
> Currently that takes the left parent. Or something.
> 
> Shameless plug : the sources for perl 5 are currently being kept in a
> perforce repository. There is a rough web interface to it at
> http://public.activestate.com/cgi-bin/perlbrowse with excellent blame
> log navigation features (including navigation against p4
> integrations).

By the way, what is the difference between '<<' links and 'br' link
in the above mentioned annotate/blame interface?

I'd like to say that I prefer gitweb's marking blame by blocks, not by
lines, and extra info on mouseover.  But having blame navigation
capability of perforce web interface would be really nice (I think
"git gui blame" has something like this; I don't know about other
tools like qgit, giggle, or ugit).

> Since we're going to move the official perl 5 vcs to git (many many
> thanks to Sam Vilain for that, BTW),

BTW. how in your opinion Git compares to Perforce, both as a tool
itself, and also about quality of companion tools such like gitweb
or git-gui?

>                                       I'm more or less trying to 
> duplicate this blame log navigation in gitweb. So it might result in a
> few patches here :)

I think it would be really nice.  Will you want to use git-diff-tree
to mark differences from the version we came from (marked by 'hp',
'hpb' and 'fp' URI parameters), or would you rather extend git-blame?

-- 
Jakub Narebski
Poland
