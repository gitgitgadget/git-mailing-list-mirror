From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git-archive and unwanted .gitattributes
Date: Sat, 7 Jun 2008 23:19:20 +0700
Message-ID: <fcaeb9bf0806070919k105263c8ybc9c04ffd11e3224@mail.gmail.com>
References: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com>
	 <m33anpxn63.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 18:20:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K519N-0003Ie-SE
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 18:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760247AbYFGQTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 12:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759027AbYFGQTW
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 12:19:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:30720 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758866AbYFGQTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 12:19:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so997131fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SHiv2kT7kBLKebhcVXNbjkIWlLMSMPBHd+6ZmVbCTGs=;
        b=lvUodYyvKvnJH5mTLraFUrEO+BWybGF21FGH3HaVIxlhbsXYaJ3cUU93H1Hv4sb2un
         YGshU+h3ZXD8gp98ZTe45aREhizTdnkzJOeaIiDmREYA8zOaWUeyyYo2XNUrmlIxkJaR
         8r43zMJhgw0mQDFil1qCCa1oWgHloy/LoIsnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fi6KtF6fRsBgna9/LDvP5RyYDYJOlZ9WayqkmbfUlY3kpILOlA6vcFqfnUEqMbHwQQ
         s6lZIWVE4ILrlWwMPoXVtYVLY4R6NtNBglCqeO+fot/CY4QZSkIo35mNUUBKuq8bdMHx
         IpH/QeT9ojXumiE0bdLjOVknAUdySi8Bt8EGg=
Received: by 10.86.80.17 with SMTP id d17mr794796fgb.33.1212855560478;
        Sat, 07 Jun 2008 09:19:20 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Sat, 7 Jun 2008 09:19:20 -0700 (PDT)
In-Reply-To: <m33anpxn63.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84212>

On Sat, Jun 7, 2008 at 10:47 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
>> Currently attr.c will read .gitattributes on disk no matter there is a
>> real worktree or not.
>
> Currently .gitattributes are read _only_ from the work tree.
> There isn't even infrastructure to read .gitattributes for commit
> (from a tree); git-check-attr, and I guess also internal git API,
> deals only with in-tree .gitattribute file.

I saw it read from index but forgot that index != tree :( So
git-archive + export-subst just does not work as expected.

-- 
Duy
