From: Evgeny <evgeny.zislis@gmail.com>
Subject: Re: git mergetool
Date: Sun, 18 May 2008 00:32:25 +0300
Message-ID: <b6840c770805171432g7d1ea462y7ae09aff733eb6a9@mail.gmail.com>
References: <b6840c770805171021g63df7d0dm4532655ed49209bc@mail.gmail.com>
	 <m3tzgw4r7w.fsf@localhost.localdomain>
	 <402731c90805171347g62197f5diab513e409d7cce25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	tytso@mit.edu
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 23:33:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxU1w-0007Jt-7f
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 23:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759181AbYEQVc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 17:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759611AbYEQVc3
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 17:32:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:11207 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758983AbYEQVc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 17:32:28 -0400
Received: by ug-out-1314.google.com with SMTP id h2so175251ugf.16
        for <git@vger.kernel.org>; Sat, 17 May 2008 14:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=N24oX5DlR2ST53oUnNJgc9yr5ROckRvQ3o4R4bqdp20=;
        b=JlWoJhddTWMP7WHJPQkQcMFkPbQtWk3x+rxLTJMoQFc7C/aTLkE+7LF5ZOmAfP41dSG4Dr2qCykrOu+YV2QKzyeaPtwV6NaQPzvDNsLr4wqJQ7s6Bkzx2/vqeB39IMtkg6zMYIRBxMDJXreD1PaEc/6GnZd5j3bxBuCiTZYm6ZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wn2870iOwlEg9EhcGkfwPMfjBxtHNX+g0Xr8zrQsM2UJUbPv/PrS8ephYd+XHJEiu3Us4sJRgqlfZxvOHcUJIeuPrzKoSt1FE7Iq6vUom49nxOaYkOBtdk0nwRWa0Fs4azLHa7ZoxNvW/rODRpnbcELNVt9tVpluV66fG/K98Og=
Received: by 10.67.97.1 with SMTP id z1mr1510011ugl.11.1211059946054;
        Sat, 17 May 2008 14:32:26 -0700 (PDT)
Received: by 10.67.26.8 with HTTP; Sat, 17 May 2008 14:32:25 -0700 (PDT)
In-Reply-To: <402731c90805171347g62197f5diab513e409d7cce25@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82367>

I was in fact using mergetool.p4merge.cmd ... and the documentation explains
regarding the non-working environment variables.

Hopefully with the new patch it will work okay.

Thanks David!

--
Evgeny

On Sat, May 17, 2008 at 11:47 PM, David Aguilar <davvid@gmail.com> wrote:
> On Sat, May 17, 2008 at 1:21 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Evgeny <evgeny.zislis@gmail.com> writes:
>>
>>> Background:
>>>    I am trying to use a custom mergetool with git.
>>>    The documentation explains that environment variables
>>>    $BASE, $LOCAL, $REMOTE, $MERGED
>>>    are set for the invocation of the mergetool command.
>>>
>>> Problem:
>>>    I wrote a wrapper for P4Merge, and I check for these environment
>>>    variables - but they are not there.   After a closer inspection
>>>    of git-mergetool I see that infact these variables are not being
>>>    sent to the external command at all, and are just in the context
>>>    of the git-mergetool script.
>>
>> From what I know of git-mergetool, you can use one of the predefined
>> merge tools: kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
>> ecmerge, and opendiff (optionally providing path to the tool)
>>
>> To add support for P4Merge you would have either modify
>> git-mergetool.sh (and, optionally, send a patch to git mailing list),
>> or make use of `mergetool.<tool>.cmd` configuration option.
>> Unfortunately there is no example...
>>
>> --
>> Jakub Narebski
>> Poland
>> ShadeHawk on #git
>
> I just sent a patch that exports these variables.
>
> Presumably we do not want to modify git-mergetool.sh every single time
> someone needs to be able to use a new mergetool, hence the patch I
> sent makes sense to me.  Let me know if you think otherwise.
> Thanks,
> --
>  David
>
