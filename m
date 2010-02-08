From: =?UTF-8?B?Sm/Do28gQ2FybG9zIE1lbmRlcyBMdcOtcw==?= 
	<jonny@jonny.eng.br>
Subject: Re: Unix root dir as a work tree
Date: Mon, 08 Feb 2010 10:17:11 -0200
Message-ID: <4B7000C7.30507@jonny.eng.br>
References: <4B6F6971.6000106@jonny.eng.br> <fcaeb9bf1002071803o343bed87u2e1df2ef77db607f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 13:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeSYM-0002B9-5k
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 13:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab0BHMRQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 07:17:16 -0500
Received: from roma.coe.ufrj.br ([146.164.53.65]:59683 "EHLO coe.ufrj.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab0BHMRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 07:17:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by coe.ufrj.br (Postfix) with ESMTP id 6E3531FA034;
	Mon,  8 Feb 2010 10:17:14 -0200 (BRST)
X-Virus-Scanned: amavisd-new at coe.ufrj.br
Received: from coe.ufrj.br ([146.164.53.65])
	by localhost (roma.coe.ufrj.br [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXTmZ3NWLM-4; Mon,  8 Feb 2010 10:17:11 -0200 (BRST)
Received: from home.jonny.eng.br (unknown [187.14.9.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coe.ufrj.br (Postfix) with ESMTPSA id CE5A41FA029;
	Mon,  8 Feb 2010 10:17:11 -0200 (BRST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090625)
In-Reply-To: <fcaeb9bf1002071803o343bed87u2e1df2ef77db607f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139287>



Nguyen Thai Ngoc Duy wrote:
> 2010/2/8 Jo=C3=A3o Carlos Mendes Lu=C3=ADs <jonny@jonny.eng.br>:
>  =20
>> Hi,
>>
>>   Sorry if this is a FAQ, but I could not find any reference.
>>
>>   I have been using CVS as a version control system for unix configu=
ration
>> files for a long time.  I know it has some limitations, and I know g=
it also
>> has its.  But I expect to work around all of them using etckeeper.
>>
>>   The problem is that etckeeper was created with /etc only in mind, =
and I
>> want to keep track of important files everywhere, not only below /et=
c (think
>> /opt, /usr/local).  The obvious solution appear to create the reposi=
tory at
>> the system root, and not at /etc, but it did not work.  I think, bec=
ause of
>> a bug.
>>
>>  Now, I have a patch that appears to work, but since I am a beginner=
 to git,
>> I don't know if this is the best way to implement it, if it has any =
side
>> effects, or even if it works for other operating systems (probably t=
hey
>> don't even have the bug).  Would any git wizard care to look at it, =
check if
>> it is ok, and maybe commit in HEAD or give me any advice against my =
patch?
>>    =20
>
> How did you set GIT_DIR and GIT_WORK_TREE? What command failed?
>  =20
Did not set any env special variable.  I expect git to find those=20
automatically.

Any command which needs a work tree fails.  git-add, git-status, etc.

It thinks that its root is "/.git", instead of "/".  Easy to repeat.

cd /
git init
git add etc/motd        # this works
cd etc
git add resolv.conf    # this does not work without my patch
