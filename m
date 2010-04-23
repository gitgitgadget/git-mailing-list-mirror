From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:25:39 +0200
Message-ID: <87eii6tt9o.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
	<x2l2cfc40321004221538qade3dd4dkc149f2748b94ef81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Brewster <adambrewster@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:25:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5F8t-0005SX-8Z
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab0DWJZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 05:25:42 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:37050 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388Ab0DWJZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:25:41 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3D3A614E165EF;
	Fri, 23 Apr 2010 11:25:40 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5F8l-0002CD-00; Fri, 23 Apr 2010 11:25:39 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5F8l-0003XO-5o; Fri, 23 Apr 2010 11:25:39 +0200
In-Reply-To: <x2l2cfc40321004221538qade3dd4dkc149f2748b94ef81@mail.gmail.com>
	(Jon Seymour's message of "Fri, 23 Apr 2010 08:38:21 +1000")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX19iR4HysQZOP+xtJprHcYewMgqWdnoaM8HM0Hzu
	uK27dIQd4Krr7hcfzSNg6ClUchBYlVB5YEzOwBEMkNwBWvkcTm
	kfHYTGqhM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145602>

Jon Seymour <jon.seymour@gmail.com> writes:

> On Fri, Apr 23, 2010 at 7:48 AM, Adam Brewster <adambrewster@gmail.com> wrote:
>
>> Consider
>>
>> $ echo -e '#!/bin/bash\nif git diff-tree --quiet HEAD; then git commit
>> -a; else git commit; fi' > `git --exec-path`/git-ci
>> $ chmod 555 `git --exec-path`/git-ci
>>
>> Adam
>
> Perhaps I am missing something, but I would have thought git
> diff-files --quiet would be more useful in this context...
>
> jon.

% git diff-files; git diff-files --quiet; echo $?
:100644 100644 09f06ca1503da57f89331ddc44f0a3c60313c531 0000000000000000000000000000000000000000 M      debian/changelog
:100644 100644 978b107709d1e45b5240a86960587d2a61d8afe6 0000000000000000000000000000000000000000 M      debian/control
1

% git add debian/control

% git diff-files; git diff-files --quiet; echo $?
:100644 100644 09f06ca1503da57f89331ddc44f0a3c60313c531 0000000000000000000000000000000000000000 M      debian/changelog
1

% git add debian/changelog 

% git diff-files; echo $? 
0

Doesn't tell me if there is an index prepared alraedy or not. Only tells
me if there are changes that are not in the index.

MfG
        Goswin
