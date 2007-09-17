From: "Mike Dalessio" <mike@csa.net>
Subject: Re: [PATCH] instaweb: support for Ruby's WEBrick server
Date: Mon, 17 Sep 2007 09:55:35 -0400
Message-ID: <618c07250709170655p649a71fdwcfaaa4d5bfcd06ff@mail.gmail.com>
References: <618c07250709161935g333f0536q31b453bd58f2d75d@mail.gmail.com>
	 <20070917115518.GA26815@soma>
	 <18071eea0709170502s397331c5j7d77aa9531f73704@mail.gmail.com>
	 <823axd32dz.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Thomas Adam" <thomas.adam22@gmail.com>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Florian Weimer" <fweimer@bfk.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:55:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXH4g-0002Yg-0X
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbXIQNzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbXIQNzi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:55:38 -0400
Received: from el-out-1112.google.com ([209.85.162.180]:30424 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbXIQNzh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 09:55:37 -0400
Received: by el-out-1112.google.com with SMTP id v27so281501ele
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=L1Ykm3mfnLrsrtiF/LShrGqSCMd0r3ONxWQH3sb6SaI=;
        b=Rdol3DgAB2qUgNau7NErjEFIf/09klhEL8mA0+f5Y8+wKOKlFRaSfR26Q29kqIOcf5qgCmOWtzxHpaMcrVOlXsMdyiKJcn2aB6OMVykGbToWHd8E+50Eu33m4QxZRJxIV4hyNuPCFWKk0DMeAEUczQ8Y4kjrKukzS7JJR6OM8cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=WZV8ZFb+Qk4xQ4w05veSq26n97//mo601YAju54UZSSi01Y/xiOs91EGZydXAVJcWYtl9fADmVKWFyT8uW3u2qXzJHva22z+qwL9czUbtpc3GaYCnBC7xaUcocMlSLrtAlVINoRx9S0Pokhr1aoYTe1GMPw7jWrP6yzxLEqHKgE=
Received: by 10.142.131.18 with SMTP id e18mr863038wfd.1190037335408;
        Mon, 17 Sep 2007 06:55:35 -0700 (PDT)
Received: by 10.142.111.16 with HTTP; Mon, 17 Sep 2007 06:55:35 -0700 (PDT)
In-Reply-To: <823axd32dz.fsf@mid.bfk.de>
Content-Disposition: inline
X-Google-Sender-Auth: c20dc7b0145997f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58445>

I could generate a second /bin/sh script to run
  "ruby .../webrick.rb"
This would assume that 'ruby' was in the user's $PATH, but that seems
like a reasonable expectation.

The drawback is that we'd be generating TWO scripts, one ruby script
to invoke the server, and one shell script to run the ruby
script. This seems a little ... circuitous.

Another idea is to hack the $httpd variable to contain a command
string like "ruby .../webrick.rb", with the drawback then being a lack
of obviousness, since the convention is that the variable contains the
same command as the --httpd argument, and is named the same as
the <webserver>_conf() functions.

On 9/17/07, Florian Weimer <fweimer@bfk.de> wrote:
> * Thomas Adam:
>
> > This is what /usr/bin/env is useful for, but it's not that portable=
=2E
>
> Yeah, it's /bin/env exclusively on some systems. 8-(
>
> --
> Florian Weimer                <fweimer@bfk.de>
> BFK edv-consulting GmbH       http://www.bfk.de/
> Kriegsstra=DFe 100              tel: +49-721-96201-1
> D-76133 Karlsruhe             fax: +49-721-96201-99
>


--=20
mike dalessio
mike@csa.net
