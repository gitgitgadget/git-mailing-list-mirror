From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: How to "pre-populate" a git message
Date: Fri, 03 Dec 2010 20:36:40 +0100
Message-ID: <4CF946C8.6050009@dirk.my1.cc>
References: <AANLkTim=dVxVLL31aEBrjw7OhXpdYOjAO9Sk16gGP3zJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 20:39:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObTJ-0008SM-Sd
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab0LCTjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:39:04 -0500
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:36927 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab0LCTjE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:39:04 -0500
Received: from [84.176.55.82] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1PObQy-0006hE-CN; Fri, 03 Dec 2010 20:36:44 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <AANLkTim=dVxVLL31aEBrjw7OhXpdYOjAO9Sk16gGP3zJ@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162839>

Am 03.12.2010 18:51 schrieb Patrick Doyle:
> Once in a while, I would like to run some scripts that will
> automatically generate some files that I keep maintained in my
> repository.
>
> I also like to review the files before they get committed.
>
> Is there any way I can "pre-populate" the commit message so that I can
> run my "regenerate" command, review the differences, and then commit
> the changes with my prewritten message?
>
> --wpd

You can either commit the changes with the "-m <msg>" or with the
"-F <file>" switch. In your case I'd suggest the latter:

1. regenerate your files and include a step that generates
    a commit message and stores that in a file, say "commit.msg".
2. review the changes
3. add all your files (except for "commit.msg", of course)
4. commit:
      $ git commit -F commit.msg

The other way would be the -m switch, but then you'd have to supply
the message by yourself somehow:
$ git commit -m "These files were generated at ..."


HTH,
     Dirk
