From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/3] git-submodule: New subcommand 'summary' (2) - hard work
Date: Fri, 07 Mar 2008 08:59:30 -0800 (PST)
Message-ID: <m34pbih3m9.fsf@localhost.localdomain>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	<80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	<d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
	<7vabli7vhr.fsf@gitster.siamese.dyndns.org>
	<46dff0320803070850w290bfbe6hcdf74b20fcd7d8a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 18:00:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXfva-0000hL-02
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 18:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbYCGQ7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 11:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbYCGQ7f
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 11:59:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:26393 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531AbYCGQ7e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 11:59:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4400668ugc.16
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 08:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=TJjd78tapPNjLQvk9+fNKJJgt/oh0TUooLyPOOevozQ=;
        b=O/gsiAo2Gw1oS6IVjNRGdbI7Ch2+Q8984g4EHey4pJjtHkO4jf8AuYl+FRM0SwTHrZCh/Z774Kc6Cehx8h06lFsyYqWSp86OiJRXL3RZBsI+uN/4IWP9cZFKLqiVtFNVRicUgNtViNrb+pMPKgtEMjC8TXoY3vtckxy5BpCaHaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=AnihiIY636drR49JZWqvSw8guo0ddC17WZAGAGlwSx6oLVcoXM0RtggOJLGt/3yEDueO1ecWLBtXi3Va+bmiwNM4PvRzLEalIvFkAM0LkU2TNfoGGe5BNOkUNgYZF4BvmxRkGNCM86vWUcyvRxMI59iUvHHnaxIwODX6h2Mq49o=
Received: by 10.78.130.6 with SMTP id c6mr4552266hud.7.1204909172477;
        Fri, 07 Mar 2008 08:59:32 -0800 (PST)
Received: from localhost.localdomain ( [83.8.252.126])
        by mx.google.com with ESMTPS id 4sm2371325hue.17.2008.03.07.08.59.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 08:59:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m27GxRf9003984;
	Fri, 7 Mar 2008 17:59:27 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m27GxQKG003981;
	Fri, 7 Mar 2008 17:59:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <46dff0320803070850w290bfbe6hcdf74b20fcd7d8a4@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76502>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Sat, Mar 1, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ping Yin <pkufranky@gmail.com> writes:
>>
>>> +             test -z "$check_src" ||
>>> +             GIT_DIR="$name/.git" git-rev-parse --verify $sha1_src^0 >/dev/null 2>&1 ||
>>> +             unfound_src=t
>>
>>  You do not want to do ^0; you will not be bind a non-commit in gitlink
>>  entry anyway.
>>
> Actually, I need ^0. "git-rev-parse --verify sha1" will always
> succeed if sha1 is an valid name with lenght 40 even if the sha1
> doesn't belong to the repository.
>
> But what I want to verify is that the sha1 is not just valid/unique
> but also belongs to the submodule repository.

Don't you want "git cat-file -e <sha1>" then, unless you are checking
more than one sha1?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
