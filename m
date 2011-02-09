From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Advices to imlement update hook
Date: Wed, 9 Feb 2011 17:51:24 +0100
Message-ID: <AANLkTik=Xw3b1i-AranJtfngOsfLvEDSzrMq3jKTy-Yy@mail.gmail.com>
References: <AANLkTimdsCgNBAnJmnzGj3M3Q4RPb==fiWu1+ZQhWenO@mail.gmail.com>
	<4D52C2FA.2030103@viscovery.net>
	<4D52C403.30501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 09 17:51:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnDGN-0002rq-Bp
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 17:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab1BIQv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 11:51:26 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38279 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab1BIQvZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 11:51:25 -0500
Received: by pva4 with SMTP id 4so62789pva.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 08:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WtEh07IGdMGqq7WdE7M8E0zNF+21iuLvuA+/ztA7f5o=;
        b=J+i1SAHIDVrM9IXlt3IgNQ3VJkLW5Xb04pOyV3bzqLduhPKNMqPTTyFsMqRpVCOCeZ
         Dag8pWcMLNmuhwA+a7E09RYHcsAT9GoLovwcElM/IDj3g9BeNni1PWFWufzu6Ujs3qVA
         fd8hdAt4wedEwkoUIQx58Uy12D46m/HiSjtyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PhYikBfdTZhvN9c8S7lesQEX7heEiJSVK8C+qL7JPI7I8ZqS2Y5FETOYK/oZwcZrig
         sThivu3CNxnoDcacOyV5Z1KxcAXxVGvez/oGLRXdXl0Mw/fNnuihp0IbLmfct5dZii7L
         9OVgFhskTF8/pcNG90ST9rY1x4BFg48d0CCjU=
Received: by 10.142.185.17 with SMTP id i17mr935342wff.353.1297270284693; Wed,
 09 Feb 2011 08:51:24 -0800 (PST)
Received: by 10.142.44.3 with HTTP; Wed, 9 Feb 2011 08:51:24 -0800 (PST)
In-Reply-To: <4D52C403.30501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166431>

On Wed, Feb 9, 2011 at 5:42 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> [Sorry, sent too early - fat fingers :-(]
>
> Am 2/9/2011 17:38, schrieb Johannes Sixt:
>> Am 2/9/2011 17:27, schrieb Francis Moreau:
>>> Hi !
>>>
>>> I'd like to restrict access to one of my repos: the project tracked=
 by
>>> it has several directories: a/ b/ c/ and I'd like to allow only
>>> modifications happen in b/ directory.
>>>
>>> I'm planning to use git hooks, not sure which one I should use: if =
the
>>> check should happen at the commit or push time or both.
> ...
>>> I also tried:
>>>
>>> =A0 =A0git diff-tree <oldref> <newref> -- ^b || exit 1
>>>
>>> but it doesn't work.
>>
>> =A0 git diff-tree --quiet <oldref> <newref> -- b
>
> should do it; it sets the exit code.

but does that work if a commit modify b/ and another directory ?

> But don't you also want to inspect all commits between oldref and new=
ref?

Yes I want to inspect all commits in the range.

> Someone could have modified the directory, and then reverted the
> modification in a later commit. If these commits arrive in a single p=
ush,
> the above code wouldn't notice this.

I agree but I thought that git diff-tree would list all changes made
between the 2 refs.

Thanks
--=20
=46rancis
