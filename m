From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git Feature Request - show current branch
Date: Fri, 20 Feb 2015 11:16:39 +0100
Message-ID: <54E70987.4060904@drmicha.warpmail.net>
References: <13b.3lxh{.41MsIT3sthY.1KvU6v@seznam.cz>	<001801d04c48$732f9980$598ecc80$@nexbridge.com>	<54E60D71.6050906@drmicha.warpmail.net> <xmqqr3tlzsao.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>, mdconf@seznam.cz,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:16:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkdi-0004YH-KL
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbbBTKQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:16:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58584 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754189AbbBTKQl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 05:16:41 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 43E3120729
	for <git@vger.kernel.org>; Fri, 20 Feb 2015 05:16:40 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 20 Feb 2015 05:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=c6nDr9LiGS5BVHCbJrHjKH
	mgP2U=; b=Ov2/HoB93YqTucV0hBvrbhi9yL9nOAPP3ox1ceDIoW8SMjKgrbSaZ2
	cVG2hsILWmhWQWaAZjxn05Ck/1kDR1O3baUfUwc6zDhNkf/f5/zN20JfkH3udcxa
	ArHGbH/6gUBeyt+2W1Ktu+xbfg1iPRvxJG0MTmK1uhKgp9VE39lJ0=
X-Sasl-enc: 29NpC+9plIY9LcXzgPtIp5tSA34u3Pi/N87jew6Lr2fQ 1424427400
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1ADA06800FB;
	Fri, 20 Feb 2015 05:16:40 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqr3tlzsao.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264147>

Junio C Hamano venit, vidit, dixit 19.02.2015 19:10:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Randall S. Becker venit, vidit, dixit 19.02.2015 14:32:
>>> git symbolic-ref --short HEAD
>>
>> That errors out when HEAD is detached.
> 
> Isn't that what you would want to happen anyway?
> 
> 	if current=$(that command)
>         then
>         	you know $current is checked out
> 	else
>         	you know HEAD is detached
> 	fi
> 
> If you used another command that gives either the name of the
> current branch or 4-letter H-E-A-D without any other indication, you
> cannot tell if you checked out the "HEAD" branch aka refs/heads/HEAD
> or you are not on any branch.  The former would happen after doing
> this:
> 
>     $ git update-ref refs/heads/HEAD HEAD
>     $ git checkout HEAD
> 
> Of course, this is not a recommended practice, and "git branch"
> these days refuses to create refs/heads/HEAD to discourage you from
> doing so by mistake, but there is no guarantee that the repository
> whatever script you are writing to work in was created and used by
> sane people ;-) so you would want to be defensive, no?
> 

If you want to be defenive, don't use --abbrev-ref, just git rev-parse
--symbolic-full-name  HEAD

The original request was for a one-liner, I think.

Michael
