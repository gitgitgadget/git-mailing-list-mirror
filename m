From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: ia64 git pull
Date: Thu, 21 Apr 2005 23:30:18 -0400
Message-ID: <42686FCA.2010605@dwheeler.com>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com>	<Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org>	<200504212155.j3LLtho04949@unix-os.sc.intel.com>	<200504212301.j3LN1Do05507@unix-os.sc.intel.com>	<20050422012546.GD1474@pasky.ji.cz>	<17000.22515.170455.192374@sodium.jf.intel.com>	<20050422015340.GD7443@pasky.ji.cz> <17000.23588.462823.574142@sodium.jf.intel.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, tony.luck@intel.com,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: linux-ia64-owner@vger.kernel.org Fri Apr 22 05:24:05 2005
Return-path: <linux-ia64-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOolw-0001LE-UD
	for glpi-linux-ia64-2@gmane.org; Fri, 22 Apr 2005 05:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVDVD2V (ORCPT <rfc822;glpi-linux-ia64-2@m.gmane.org>);
	Thu, 21 Apr 2005 23:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVDVD2V
	(ORCPT <rfc822;linux-ia64-outgoing>);
	Thu, 21 Apr 2005 23:28:21 -0400
Received: from cujo.runbox.com ([193.71.199.138]:62154 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261931AbVDVD2N (ORCPT
	<rfc822;linux-ia64@vger.kernel.org>);
	Thu, 21 Apr 2005 23:28:13 -0400
Received: from [10.9.9.1] (helo=bolivar.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DOopu-0002mX-7L; Fri, 22 Apr 2005 05:28:10 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by bolivar.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DOopt-0006bP-Oy; Fri, 22 Apr 2005 05:28:10 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
In-Reply-To: <17000.23588.462823.574142@sodium.jf.intel.com>
X-Sender: 258406@vger.kernel.org
Sender: linux-ia64-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ia64@vger.kernel.org

Petr Baudis <pasky@ucw.cz> writes:
>>Still, why would you escape it? My shell will not take # as a
>>comment start if it is immediately after an alphanumeric character.

I guess there MIGHT be some command shell implementation
that stupidly _DID_ accept "#" as a comment character,
even immediately after an alphanumeric.
If that's true, then using # there would be a pain for portability.

But I think that's highly improbable.  A quick peek
at the Single Unix Specification as posted by the Open Group
seems to say that, according to the standards, that's NOT okay:
http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02
Basically, the command shell is supposed to tokenize, and "#"
only means comment if it's at the beginning of a token.

And as far as I can tell, it's not an issue in practice either.
I did a few quick tests on Fedora Core 3 and OpenBSD.
On Fedora Core 3, I can say that bash, ash & csh all do NOT
consider "#" as a comment start if an alpha precedes it.
The same is true for OpenBSD /bin/sh, /bin/csh, and /bin/rksh.
If such different shells do the same thing (this stuff isn't even
legal C-shell text!), it's likely others do too.

--- David A. Wheeler
