From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/2 v4] Git.pm: add test suite
Date: Wed, 18 Jun 2008 20:04:50 +0200
Message-ID: <48594E42.2050402@gmail.com>
References: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com> <4db23d5b625de1aa026cf4630d49b57fd3a09d07.1213685306.git.LeWiemann@gmail.com> <7v63s7301m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:06:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K922k-0004ap-Pf
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 20:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbYFRSFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYFRSFA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 14:05:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:51208 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbYFRSEx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 14:04:53 -0400
Received: by wr-out-0506.google.com with SMTP id 69so271647wri.5
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=QyvqUzQCnf3hCPSF5GX1CO5tS5uWXzionrHam6COIw8=;
        b=FvY3hglwWjhcaXr7CPKdpZ7uSApQI+1NOQCJwg75vsARplG5P3nrbc7UKVib05sGf/
         qXDTCTmR3HRj4H4k1Rjodvw7koxAPXBjYFRv/DCdv36AWUQsshR71XES/RRmelWYSqWO
         65xNTdhlXIFPdMAgLIXidedtRJwrv72u8TWVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=f4OFh4kgeaLCGH8DwVdW9APuWm06hhceeU4Cpp8ngXHuDYLr1P1pc+gLhrtE6E16QC
         jsAzAELWbp/gFdyl3QxfWdksPDgHPT5LCWllyXHOrmXvw5l1CnWOKIeqRoxJS62yPsmS
         MVt9VFIdF0qlHinCWOhi+jArr9TFiKERZL7Yg=
Received: by 10.90.52.1 with SMTP id z1mr129446agz.119.1213812292558;
        Wed, 18 Jun 2008 11:04:52 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.248.220])
        by mx.google.com with ESMTPS id b45sm8148302hsa.6.2008.06.18.11.04.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 11:04:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7v63s7301m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85395>

Junio C Hamano wrote:
> The system I first tried this did not have IO::String installed.

My bad, I should've checked this before sending it off.  I guess we'll 
solve this in Michael's patch thread; don't expect a reply from me in 
the next 12h though, I'm way tired and utterly unproductive right now.

> [test_external:] Can it become a bit easier to tell such a basic
> problem apart from real test errors?  I needed to look into
> /tmp/* to see where it is failing

Hm, is your test output somehow different from the following?  It states 
the error quite clearly at the bottom.

$ ./t9700-perl-git.sh -v
* expecting success: echo "test file 1" > file1 &&
      echo "test file 2" > file2 &&
      [...]
      git-config --add test.int 2k

*   ok 1: set up test repository
[...]
*  run 2: Perl API (perl ../t9700/test.pl)
* FAIL 2: Perl API
	perl ../t9700/test.pl
* expecting no stderr from previous command
* FAIL 3: no stderr: Perl API
	perl ../t9700/test.pl
	Stderr is:
	Can't locate IO/String.pm in @INC (@INC contains: 
/home/lea/G/t/../perl/blib/lib /home/lea/G/t/../perl/blib/arch/auto/Git 
/home/lea/.perl/lib /etc/perl /usr/local/lib/perl/5.10.0 
/usr/local/share/perl/5.10.0 /usr/lib/perl5 /usr/share/perl5 
/usr/lib/perl/5.10 /usr/share/perl/5.10 /usr/local/lib/site_perl .) at 
../t9700/test.pl line 12.
	BEGIN failed--compilation aborted at ../t9700/test.pl line 12.
	# Looks like your test died before it could output anything.
* failed 2 among 3 test(s)

-- Lea
