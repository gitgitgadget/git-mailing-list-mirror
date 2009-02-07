From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 7 Feb 2009 10:25:01 +0100
Message-ID: <200902071025.02491.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <200902070934.50555.jnareb@gmail.com> <7v7i42y6ms.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 10:25:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVjRQ-0001Rj-FD
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 10:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbZBGJYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 04:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbZBGJYH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 04:24:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:57204 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbZBGJYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 04:24:04 -0500
Received: by fg-out-1718.google.com with SMTP id 16so704205fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 01:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UAFRWObvcVc+349b3uitld+ywkYEYrGgg6Bj1epDb9Y=;
        b=tZwimhg7m6UGjtTFIFwlAgcjac74wCMAr8v2Rgp3IsJwTlgMyUS/zsVgZMRIxjsZ2C
         +Xrc6MoMfZVJ/eGangDRr3SZLaJftQ4xRhEKLFEvHoqwQQ0jJOE8lXujhDms3AMHc5e9
         3LosXzCRVy415Gt2zKjeFTosWiN4qfL5SAsUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AwXkky65pjyBUF4t2TOQjHCimKi+fDzgyt0BFJzQobfQOVYvpmalUohkvNbG/Z04b6
         V5MptEjfAxYwSPfgOFsvTshVE4UzV/hhEC42ZExytsHFvLxfWjwX6rOYKrovIFyqL/Du
         jpY/tnxpc5K6fF/Mfm82acT1RnW+0/Z/Yu3fc=
Received: by 10.86.59.2 with SMTP id h2mr1494905fga.73.1233998642479;
        Sat, 07 Feb 2009 01:24:02 -0800 (PST)
Received: from ?192.168.1.13? (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id l19sm1455794fgb.57.2009.02.07.01.24.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 01:24:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7i42y6ms.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108835>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > It would unfortunately falsely match... but we cannot eliminate this
> > case (well, at least not checking if hexnumber is followed by dot),
> > because of totally legitimate
> >
> >    ... at commit 8457bb9e.
> >
> > So even with that we would have still false matches...
> 
> Yeah, so what's the value in v2 over v1?  It is still wrong but it is less
> wrong than it used to be?  I think the word-boundary one made a good
> sense.  I do not see the @lookahead adding much value at all.

Right. So v2 is less useful that I thought it to be; and adding further
"exceptions" doesn't seem like a good idea.  The 'msgid' committag
when/if it gets implemented would help there...

So please take v1, as it is sane improvement and generic enough.
-- 
Jakub Narebski
Poland
