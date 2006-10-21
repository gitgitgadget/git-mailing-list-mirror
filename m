From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] separate .git from working directory
Date: Sun, 22 Oct 2006 00:08:00 +0700
Message-ID: <fcaeb9bf0610211008t9da13a5m71105d0ddd031bae@mail.gmail.com>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 19:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbKKj-0007kd-ST
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 19:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993160AbWJURIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993163AbWJURIH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 13:08:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:9508 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2993160AbWJURIC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 13:08:02 -0400
Received: by ug-out-1314.google.com with SMTP id o38so957508ugd
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 10:08:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HrfSdvLaphYjFW1WjnAIvnoFLTgNTVnU7A6YBVwTJWLEoCFhhYCcWxaohAS0zxva4+8e/QCDBTaPkotlRvdQJCM3/ZunXiIc2Y2dc0UUXzOxyp4Ok+4/6HjzdM8kqiwob/al4+6mUFcYJvyHbRd7tjfX+uXMV1713Dctpaj5MME=
Received: by 10.78.200.3 with SMTP id x3mr4127564huf;
        Sat, 21 Oct 2006 10:08:01 -0700 (PDT)
Received: by 10.78.100.8 with HTTP; Sat, 21 Oct 2006 10:08:00 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29639>

Hi,
After reading a post in VCS comparison thread mentioning /etc example.
I think some of my patches might be useful for some users. They are
two patches, tp/gitlink~1 and tp/gitlink~2 in git-pclouds.git on
repo.or.cz.
The implementation is a bit differerent from what I proposed. The
.gitdir file (I named it .gitlink  though) contains an alternative
name for .git dir. It would be more obvious with the following
example:

The standard layout:

a/.git
a/file
a/b/.git
a/b/file

The new layout:

a/.git
a/.git-b (it is actually a/b/.git)
a/file
a/b/.gitlink (whose content is ".git-b")
a/b/file

With this I can move all .git directories to the top directory (or
just parent directories). In /etc example, it can create a less
cluttered directory structure. I do not submit these patches to git.
It needs more work IMO.
-- 
Duy
