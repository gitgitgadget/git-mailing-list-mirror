From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] t3032 - make compatible with systems using \r\n as a
 line ending
Date: Thu, 18 Jul 2013 20:19:03 +0100
Message-ID: <51E83FA7.5080706@ramsay1.demon.co.uk>
References: <51E591FF.7030600@gmail.com> <1374000592-31845-1-git-send-email-mlevedahl@gmail.com> <20130716185933.GO14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:28:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzuoi-0004E6-9i
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934141Ab3GRU2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:28:42 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:50026 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933027Ab3GRU2l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:28:41 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 365681280B6;
	Thu, 18 Jul 2013 21:28:40 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 97A971280B5;
	Thu, 18 Jul 2013 21:28:39 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Thu, 18 Jul 2013 21:28:38 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130716185933.GO14690@google.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230735>

Jonathan Nieder wrote:
> Mark Levedahl wrote:
> 
>> Subtests 6, 7, and 9 rely test that merge-recursive correctly
>> ignores whitespace when so directed. Change the particular whitespace
>> sequences to be ones that are not known line endings so the whitespace
>> is not changed when being extracted by line oriented grep.
> 
> merge-recursive needs to be able to deal with \r at EOL, too, so if at
> all possible I would prefer to see the test fixed to pass on Cygwin
> some other way.

Maybe use -U/--binary option to grep? Indeed, if you look at the top of
that test file, you will see:

    test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
    test_have_prereq MINGW && export GREP_OPTIONS=-U

which may explain why it works for me on MinGW, but not why it works on
cygwin 1.5.

ATB,
Ramsay Jones
