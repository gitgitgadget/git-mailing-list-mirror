From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Bug/problem with 1.6.0 on UnixWare
Date: Fri, 22 Aug 2008 08:58:39 +0100
Message-ID: <e2b179460808220058o24f9b15bo74c2abcdd70abaab@mail.gmail.com>
References: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com>
	 <e2b179460808210435w31b911a5ie6059b5628db8138@mail.gmail.com>
	 <alpine.LNX.1.10.0808210610440.29396@xenau.zenez.com>
	 <e2b179460808210541lfd7dcaeoea8554a2a76f8825@mail.gmail.com>
	 <20080821130816.GB22453@coredump.intra.peff.net>
	 <e2b179460808210738y9ca6e3fka113128fb1e6e024@mail.gmail.com>
	 <20080821204522.GA29361@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Boyd Lynn Gerber" <gerberb@zenez.com>,
	"Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 10:00:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRZB-0007Ps-Li
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 10:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbYHVH6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 03:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755400AbYHVH6l
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 03:58:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:6532 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYHVH6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 03:58:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so322059rvb.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OQAYvSoD94vG9EI1oGFmerGjb7ePr/5oL08F3oaWXLQ=;
        b=NieczkaJpdiHRC8pi6+ptcuAr1kqsO/nR0aYCCmoXXRyxF00Dzu7KApgtYa/sJnyic
         XlgvGHqVEyQPKBPpwEZtu6UOL+PE2GSSQVfB81VyV2nyVwEhcHxRe1X+YHENhtex93Nl
         /jkI3eHwkWHXjZ7Msx4VWbwrMUYlB14QhCMxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pqftLk0Pw+dtWqFJC6OXw32ElezZJPMhlYfITo4gYMQKX0airY9YYHSCvwu6L+E4Yp
         XawITL6Oe0k8I7VHv7exjvU/S3RGZoV3bg+HHUhdA9iCoRT+EQXgsv+t3Cf6k5VZRe4z
         PGe6WSoFNBpasO3YkxNawxpyRVkMontru8XwU=
Received: by 10.140.191.14 with SMTP id o14mr393816rvf.78.1219391919834;
        Fri, 22 Aug 2008 00:58:39 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Fri, 22 Aug 2008 00:58:39 -0700 (PDT)
In-Reply-To: <20080821204522.GA29361@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93268>

2008/8/21 Jeff King <peff@peff.net>:
> On Thu, Aug 21, 2008 at 03:38:32PM +0100, Mike Ralphson wrote:
>
>> Great stuff. Though I think it might provoke some patches to improve
>> the display of multiple long tag names for the same commit in gitweb!
>
> Heh. Can you pass along the final version of your build script? I want
> to make sure we are doing the same things.

http://repo.or.cz/w/git/gitbuild.git?a=blob;f=gitbuild.sh;h=d06fbef3c7aa54ea3beab4b3eed4d73387f3b136;hb=2da51f87b94ef564691a656f91b97472bf6d8c53

The setting of the PATH and GIT_SKIP_TESTS are obviously env. specific.

At the moment there's still a bit of manual faffing around when next
is rewound after a release.

> Yes, in theory, last minute code changes could cause a portability
> breakage. However, any changes from the last -rc to the release version
> tend to be extremely conservative (as judged by Junio), so in practice
> I don't think it happens. For example, I think this git-shell bug made
> it into master over a month before release.

True, this instance isn't a last minute breakage.

Mike
