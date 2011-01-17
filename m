From: "Aaron S. Meurer" <asmeurer@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Mon, 17 Jan 2011 11:27:20 -0700
Message-ID: <DFADB509-B086-4BF3-AB3B-B19CB68FA113@gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com> <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com> <20110117115133.GA29207@burratino>
Mime-Version: 1.0 (iPod Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 17 19:28:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PetoM-0004jU-2g
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 19:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab1AQS2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jan 2011 13:28:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44271 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1AQS2I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 13:28:08 -0500
Received: by ywl5 with SMTP id 5so1772642ywl.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:message-id:from:to:in-reply-to
         :content-type:content-transfer-encoding:x-mailer:mime-version
         :subject:date:cc;
        bh=/Fm8wIftSXlaDoSawUhsGCDxd1VdmAs+QyU2/7WUUyI=;
        b=BGap7juA2PYaREYTrKD4jvnDrOvl/8LrMluSE2ryctmbj2KMR0cPyOf8tUwRowAJkA
         YdOxEjnF1FcqGIyhMzKkH5P9hUJ3235VeMkWY3s2l9eLoFW1HtBOsv1t6zCgZnrdzlMC
         nZxA+YLvQc5UH+iGGqGvPuNNoiDEVey9Uo8no=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=tJs4VZd63qiPP8mF1dyx8bypleAFpgZ1Q3SEHAX91RlJipGXOdyctftbv7WIpP/gMP
         72bENAg40FgFNtuXJmK7doHf/En2fWNhCKa8xVqbI78YHvYsQRzWrGCIavuE5JRYDu5i
         nDPw1pJISPYwx1RjMev/hEoBTidaq1Kw6aNj4=
Received: by 10.147.136.16 with SMTP id o16mr6183908yan.35.1295288886794;
        Mon, 17 Jan 2011 10:28:06 -0800 (PST)
Received: from [192.168.1.131] (c-68-42-39-41.hsd1.nm.comcast.net [68.42.39.41])
        by mx.google.com with ESMTPS id h68sm2830918yha.31.2011.01.17.10.28.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Jan 2011 10:28:05 -0800 (PST)
In-Reply-To: <20110117115133.GA29207@burratino>
X-Mailer: iPod Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165176>

On Jan 17, 2011, at 4:51 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi,
>
>> Aaron S. Meurer wrote:
>
>>> 90% of the time I do not
>>> want to go back to where I started bisecting.  I would much prefer  
>>> to just
>>> have a git bisect stop command
> [which does "git bisect reset HEAD"]
>
> FWIW I like the idea.  I end up using "git bisect reset" by accident
> from time to time and it is almost never what I want, especially
> after working on something else for a few days[1].
>

Things never get quite that bad for me brcause I gave the git_ps1 in  
my $PS1, so it tells me when I am bisecting and so I never forget to  
reset soon after I am done.  Ditto for am.

Aaron Meurer

> My only worry is that it could be confusing --- what if a person,
> intending to run "git bisect reset", runs "git bisect stop" instead?
> To mitigate that, the stop subcommand could print the name of the
> start commit so such a user knows what to check out to get back to
> a familiar state.
>
> Christian Couder wrote:
>
>> Yeah, many people find it difficult to reverse the meaning of "bad"
>> and "good" when looking for a fix. There were some suggestions at  
>> some
>> points to do something about it. Some of the suggestions were to use
>> some aliases for "good" and "bad", but there was no agreement. Other
>> suggestions had a patch attached but the patch was not good enough or
>> something.
>
> Any pointers to such a discussion or patch?  Maybe whatever small
> detail caused it to be forgotten could be fixed...
>
> Ciao,
> Jonathan
>
> [1] compare am --abort:
> http://thread.gmane.org/gmane.comp.version-control.git/164002
