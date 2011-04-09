From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Sat, 9 Apr 2011 11:09:22 +0200
Message-ID: <BANLkTim5DPjGjJ=SfnNfXpzCd6=PKnSs6g@mail.gmail.com>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org> <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
 <4D9EDCEA.9010903@drmicha.warpmail.net> <20110408185924.GA25840@elie>
 <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org> <20110408194548.GA26094@elie>
 <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org> <BANLkTi=3LPRzohnZStAogddpL5ZLehb97Q@mail.gmail.com>
 <20110409081108.GE13750@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thorsten Glaser <tg@mirbsd.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 11:10:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8UB6-0006FV-L0
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 11:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1DIJJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 05:09:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61687 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab1DIJJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 05:09:42 -0400
Received: by iwn34 with SMTP id 34so4122434iwn.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=QjySDc5LYJHhXu7nbNaToLU+9cxlJ6v4Lo43DCoJkG8=;
        b=Wz2G5FKn2xLKVAByqHZmW7WmdZJUyDEuaJIHR9JerN/sqvzL36qRVwFsHSBIiVlLiY
         gUEAGpYE+BVLqtWFdsDgI28XidSqYumoh+J4yFowfv5QJAj6u3cmclW8oJfTiz5pW7NV
         Qj8EtlhajsdxYgDWJh++jUbgudGu0fImOCZ3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=puhvag2K2YHqsRCbDlh3ohdK1Mpce2SPoKvT9erVy9O0+asljDBvdcFhxDlc7n0QF0
         cnCLj2/VaMTQw03AUXKASQMrXmu3fQdf6j5SETDkgkOicRQ2wYl+aZXGwrLuHXTqJa6P
         aiUX6anz1VKpFHO4bZGxmHy+9uLowk9cRaMCY=
Received: by 10.231.210.148 with SMTP id gk20mr3202323ibb.110.1302340182203;
 Sat, 09 Apr 2011 02:09:42 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Sat, 9 Apr 2011 02:09:22 -0700 (PDT)
In-Reply-To: <20110409081108.GE13750@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171188>

On Sat, Apr 9, 2011 at 10:11, Chris Webb <chris@arachsys.com> wrote:

> (Disclaimer: I've never tried using smudge filters; maybe they can't be used
> in the way I describe!)

Smudge filters are on my half-read list of New Cool Stuff so I can't
really comment on this.

Another idea would be to simply tack all metadata into the same place
as the existing chmod stuff.

While one large text file would be nice in case one wanted to make
manual changes, attaching versioned, binary information to every
object directly is a lot more efficient. I think I am convinced the
latter would be the cleaner approach, now. With a clean layout, this
would not need to be a huge code drop supporting every metadata type
in existence; it could be extended as needed.

As noted above, .gitattributes could be used to manage what kind of
metadata should be stored.


One large question in my mind is if anyone who's familiar enough with
the codebase and has the time would be interested in actually
implementing this.


Thanks,
Richard
