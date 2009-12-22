From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Where did Documentation/perf_counter disappear from linux-2.6-tip.git
 ?
Date: Tue, 22 Dec 2009 13:23:25 +0100
Message-ID: <4B30BA3D.2080305@gmail.com>
References: <4B3099A5.6040808@gmail.com> <6b08a1ab.3349a908.4b30b80f.ab91f@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Daniel <mjucde@o2.pl>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 13:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN3m4-0007eV-AI
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 13:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZLVMXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2009 07:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbZLVMX3
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 07:23:29 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60863 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbZLVMX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 07:23:29 -0500
Received: by bwz27 with SMTP id 27so4068256bwz.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 04:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=adKMb5eg9+DIjm9vH9rS5bjOAM8+yvJdNDdYTIzQj58=;
        b=TO82aQ9Oqu13+q1fd0ZRxXLYh4T5eC5Sb9EesKnLJMaipacXtJFKx1+jKzyjr+grnP
         dbsl+dymV3mobq4V/HVO+68ejqso9fSgFpkdenI2Y4LkhErmCZNa7NGYDtR+XrUTWE7t
         7/iYeZ8do6/BKh0uqaX06OqmQm9wNvrSBL2bY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=YWv0kITZeJsFnQWJwTEHQXGQdvk6kqfJTCePayXgDE2GRtervlRnAB72HZLkDmRppu
         On5qQCSuNwo4FzTk1ygynf7qjjiDmGG9rtf0zISCzAxQAj5/hbd+hZIOcwjzMxVqNuYl
         PDUpiwpRYLzNbUb1936v2O4pk1OeKjYa69neY=
Received: by 10.204.25.208 with SMTP id a16mr1384358bkc.133.1261484607367;
        Tue, 22 Dec 2009 04:23:27 -0800 (PST)
Received: from calvin.caurea.org (gw.ptr-62-65-141-13.customer.ch.netstream.com [62.65.141.13])
        by mx.google.com with ESMTPS id 13sm1869166bwz.6.2009.12.22.04.23.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 22 Dec 2009 04:23:26 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.3a1pre) Gecko/20091222 Lightning/1.1a1pre Shredder/3.1a1pre
In-Reply-To: <6b08a1ab.3349a908.4b30b80f.ab91f@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135579>

  On 12/22/09 1:14 PM, Daniel wrote:
> Dnia 22 grudnia 2009 11:04 	Tomas Carnecky<tomas.carnecky@gmail.com> =
 napisa=C5=82(a):
>
>>    $ git --version
>> git version 1.6.6.rc4
>>
>> # Documentation/perf_counter is missing from the master branch, so f=
irst
>> let's find
>> # out what the last commit was that touched that subdirectory:
>> $ git log --all -1 -- Documentation/perf_counter
>> commit 436224a6d8bb3e29fe0cc18122f8d1f593da67b8
>> Author: Peter Zijlstra<a.p.zijlstra@chello.nl>
>> Date:   Tue Jun 2 21:02:36 2009 +0200
>> ...
>> M       Documentation/perf_counter/builtin-report.c
>>
>> # Great, let's look in which branch that commit is
>> $ git branch --contains 436224a6d8bb3e29fe0cc18122f8d1f593da67b8
>> * master
>>
>> # So, let's look at the log of master and limit it to that subdirect=
ory:
>> $ git log master -- Documentation/perf_counter
>> $
>>
>> # Damn, that doesn't make any sense. In commit 43622 there were file=
s in
>> that subdirectory, in master they have gone missing and yet log does=
n't
>> show any commit touching that subdirectory?
>> # Let's try something different:
>> $ git log --diff-filter=3DD --name-status --all -- Documentation/per=
f_counter
>> ...
>>
>> # Ah, now we're getting somewhere, but still no sight of a commit wh=
ich
>> removed for example Documentation/perf_counter/.gitignore
>> # I'm sure I'm probably just missing a tiny little switch for git-lo=
g. I
>> also tried other combination of name-status, diff-filter etc, but so=
on
>> after gave up.
>>
>> tom
>> --
> Try
>
> $ git log --follow -- Documentation/perf_counter
>
Ah, that did the trick:
86470930, perf_counter tools: Move from Documentation/perf_counter/ to=20
tools/perf/

However, that still doesn't answer my question why a simple git log=20
doesn't show the commits. There are commits which touch that=20
subdirectory, so why is a list of 'commits which touch that=20
subdirectory' empty? Or am I misunderstanding what 'git log -- dir/' is=
=20
supposed to do? I thought it did exactly that.

tom
