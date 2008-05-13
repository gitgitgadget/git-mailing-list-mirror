From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] instaweb: make it compatible with Mac OS X 10.5's apache installation.
Date: Tue, 13 May 2008 05:30:19 -0700 (PDT)
Message-ID: <m37idy5qvz.fsf@localhost.localdomain>
References: <1210534569-48466-1-git-send-email-nathans@gmail.com>
	<B3990C52-0AF9-490C-86E1-B311144C6661@gmail.com>
	<200805121952.55492.chriscool@tuxfamily.org>
	<7v7idzz7no.fsf@gitster.siamese.dyndns.org>
	<21CA1226-223D-4347-A119-1D5A2CEA003E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: nathan spindel <nathans@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 14:31:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvtf3-0001TU-JO
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 14:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759415AbYEMMa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 08:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759289AbYEMMa0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 08:30:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:3029 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757209AbYEMMaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 08:30:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2134879fgg.17
        for <git@vger.kernel.org>; Tue, 13 May 2008 05:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=mANhICZ3R7xdmlFfmJRdBay7gJJpRUms+sk+KRrvcgU=;
        b=rDmSZ6XlOFNdNwhsW+veEzdbDfkUqAgwyFACzUbZq6LBgV78AweBB0JCNKLYfSE0OJLleFufEDrss7JmZrz1AMfRBr1p/cWpTyPSTJmy5xkL7KQGzGg8WW7NaL5BbK2Gr6CjNLqqxzoKmdTojYpcuCUr1i4FVF9VFYKJlxVy410=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=RvIXu4JxMPPMOY8+h8/uFBd4GwT2EY9iQDhGrkuvM32q0f300KYqAawDVUOfZPWW2Jqiqr5ttPNm4Io7npSvUH4sJMiim7hswbwLyHcBbhnLhm2H8hXmjAeFqbp2U0y+9hB1nwhjKf3AqjAgRM6U/r9z9WB7phXbCI5vXGR/6A0=
Received: by 10.86.100.19 with SMTP id x19mr16440096fgb.12.1210681821648;
        Tue, 13 May 2008 05:30:21 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.214])
        by mx.google.com with ESMTPS id 4sm7016868fge.5.2008.05.13.05.30.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 May 2008 05:30:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4DCTiaU020816;
	Tue, 13 May 2008 14:29:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4DCTKIg020806;
	Tue, 13 May 2008 14:29:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <21CA1226-223D-4347-A119-1D5A2CEA003E@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82025>

nathan spindel <nathans@gmail.com> writes:

> On May 12, 2008, at 11:42 AM, Junio C Hamano wrote:
> 
>> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>>> Maybe you can use a function like this not tested one:
>>>
>>> check_cmd() {
>>> 	cmd="$1"
>>>
>>> 	if type "$cmd"> /dev/null 2>&1; then
>>> 		if "$cmd" -v | grep Apache> /dev/null 2>&1; then
>>> 			httpd=$(echo "$cmd" | sed "s/apache2/httpd/")
>>> 		fi
>>> 	fi
>>> }
>>
>> One worry I have with that approach is if any and all random
>> implementations of "httpd" that live somewhere in path do not do
>> any harm when started with "-v" option.  Namely, they should exit
>> without becoming a daemon and/or start the service.
>>
>> I am not convinced that would be the case.

By the way, it is a bit strange that Apache doesn't understand long
equivalent of -v, namely --version.

> I agree with that worry. Solving that in the general case is pretty
> difficult, so I think we could instead look for other clues in the
> system. Some ideas:
> 
> - Use $HTTPD as defined in apachectl. (How portable is that?)

You mean what apachectl returns in Usage: (first line)?

  1014:jnareb@roke:~> /usr/sbin/apachectl          
  Usage: /usr/sbin/httpd [-D name] [-d directory] [-f file]

> - Inspect the text of 'man httpd' to determine if it's Apache or not.

Manpages might be not installed.  I think 'httpd -v' is less error
prone...

> - Only fallback on the httpd command on Mac OS X 10.5? That's pretty
> safe.

Not only MacOS X has Apache installed as httpd binary.  Some Linux
distributions do that too.


P.S. I wonder if it would be possible, as absolutely last resort
fallback, to make git-instaweb to create/use very simple web server in
Perl, using HTTP::Daemon module (if it is installed), which comes from
libwww-perl.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
