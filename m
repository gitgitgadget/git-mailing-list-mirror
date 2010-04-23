From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:14:31 +0200
Message-ID: <87mxwutts8.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:14:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Ey9-0006pg-DA
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0DWJOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 05:14:36 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54951 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab0DWJOf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:14:35 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 98D3F14E1667C;
	Fri, 23 Apr 2010 11:14:33 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5Exz-0000JC-00; Fri, 23 Apr 2010 11:14:31 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5Exz-0003TB-Fp; Fri, 23 Apr 2010 11:14:31 +0200
In-Reply-To: <x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
	(Adam Brewster's message of "Thu, 22 Apr 2010 17:48:34 -0400")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX1+UWIrqONe6LD+B3bzo2FF1o/43KU+NcHBjTxx9
	nMS7cZKHH8CmWI81tQu8aj3SOVU9AqfhFMwG+6Uo5rmMGzlvNb
	25WcO5DMA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145598>

Adam Brewster <adambrewster@gmail.com> writes:

>>> What _you_ can do though, is this:
>>>
>>> =A0 =A0 =A0 git config --global alias.ci "commit -a"
>>
>> But then when I accidentally use 'git ci' while having an index the
>> index gets ignored and all changed files get commited in one big mes=
s.
>> Given how seldom I need an index (so far never) the risk of using 'g=
it
>> ci' accidentally is way to high. Same with typing -a. I do it so oft=
en
>> that when I actualy don't want it I will probably type it anyway out=
 of
>> habbit.
>>
>> My way would be safe in that it will never ignore an index if there =
is
>> one. And if it is a new option then it would not alter the existing
>> semantic, just add to it. Call the option --smart-a or --a-if-empty.
>>
>
> Consider
>
> $ echo -e '#!/bin/bash\nif git diff-tree --quiet HEAD; then git commi=
t
> -a; else git commit; fi' > `git --exec-path`/git-ci
> $ chmod 555 `git --exec-path`/git-ci
>
> Adam

% if git diff-tree --quiet HEAD; then git commit -a; else git commit; f=
i
7a15ef233c9ea900c9176f4a09260bb64a7e40cb
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   debian/changelog
#       modified:   debian/control
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       debian/files
no changes added to commit (use "git add" and/or "git commit -a")


That does not do the right thing but I was thinking along the same line=
s
for a personal fix.

MfG
        Goswin
