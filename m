From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Tue, 24 Jun 2008 04:01:19 +0200
Message-ID: <4860556F.5060206@gmail.com>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com> <200806231531.13082.jnareb@gmail.com> <485FE3F7.4040102@gmail.com> <200806240018.20820.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxrR-0003wj-Lo
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbYFXCB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbYFXCB0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:01:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:35405 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYFXCBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:01:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1095642fgg.17
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 19:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=3RB0/iGKFIPI8laLAnXj5uEXtVyMAX445lEib3gIoRM=;
        b=LQ+d8+dsHmEka6kTGxwhYN/p2DZYNJ/m3h7XiFIIuluqWdzX4P4/NIJhIppS7Qjbm8
         hmubySJRkNuwM0YqISDJrV8pFGJly+4kzvxrZVE0reT7rBbyict4JXQTePdrfm0b+jYw
         WnCOvo9UbW5wKG0qwafSCMRHvEzJgnpswl50M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=XY/kYiIYwLDqTBCtj/OAatxTLztSjgMXfzYAwvCRVkiJs5Xx80xl5ZUdSfS0JumEHR
         QyR7ZAJOoCaJQB61K8wbeezmhGsp9Rb7ebClD08WbV/YY0280nua9EpiRGUkGB0dxkz4
         nhAHk90nbhfDXed1cg9QpZQOdQpNsDryzNiJE=
Received: by 10.86.23.17 with SMTP id 17mr8242444fgw.32.1214272883446;
        Mon, 23 Jun 2008 19:01:23 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.198.167])
        by mx.google.com with ESMTPS id l12sm10081172fgb.6.2008.06.23.19.01.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 19:01:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806240018.20820.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85965>

Jakub Narebski wrote:
> Although I guess it would be nice to have link to the ticket to the bug
> (report) in WWW::Mechanize::CGI, so we could use cgi_application()
> "again" if it gets fixed...

Sure, I've added a link to 
http://rt.cpan.org/Ticket/Display.html?id=36654 for completeness, though 
we won't be able to use it if it gets fixed, since we can't break 
compatibility to older versions.  Btw, you may want to add a reply to 
the bug report (if that's possible -- haven't used CPAN's ticket system 
before) that "system $application $application" would be a better 
solution, since it doesn't suffer from quoting issues.

>> Right -- here's my new version (which still fails if the feeds die or 
>> are not well-formed XML -- I'll want that when I change gitweb):
>>
>> [snip code]
> 
> Does it make t9503-gitweb.Mechanize.sh fail?

No, my point was that it will fail *in case* it breaks (which is good). 
  Putting everything into a TODO block would silently ignore issues with 
the feeds.

>>>> +GITPERL=${GITPERL:-perl}
>>>> +export GITPERL

Breaking the indecisiveness, I've ripped it out. ;-)  We can still test 
gitweb under different Perl versions by make'ing it with different 
PERL_PATHs, so I think it'll be fine.

-- Lea
