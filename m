From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Submodules: Add the new "fetch" config option for
 fetch and pull
Date: Sat, 9 Oct 2010 14:54:46 -0500
Message-ID: <20101009195446.GA19064@burratino>
References: <4C935D77.3080008@web.de>
 <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org>
 <4C953DE5.6020900@web.de>
 <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>
 <4C963D00.9050207@web.de>
 <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>
 <4CAB8DDF.8080004@web.de>
 <4CAB8E33.1030208@web.de>
 <AANLkTikUdNdDDK9-+AjuSO_RJHNBZEp5mHPRnsV0Fo0v@mail.gmail.com>
 <4CB0C0DC.40108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 21:58:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4fYb-0003vP-3d
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 21:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760498Ab0JIT6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 15:58:02 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39955 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891Ab0JIT6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 15:58:01 -0400
Received: by iwn6 with SMTP id 6so1705550iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yyWW+UxTQRpXhiO03nX8tKRDT4wkggyxFuwaZ1AQYZY=;
        b=HnRFGRofMlcx8iSC7pEVzKEzwcZEroC0n9f5V5WL4CGX8mZc6cWbIyC08iuv+6SIuG
         uPPCLo288MAYNNzWu6ceCSVa6r2lbP+ID1RnvBN+m4VjUrlWH3s5O6uPG0T094F0E2Nn
         S90clzxMywGOMN8P1umOxm2HNB8SGEeAGPM9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CORFSA8q0lJXK4Kwb6mI+St2bImuNlFXXjxj7JsUC8L2hx6zyZwb9jfAdT9Q+WW83q
         WqiWuD+3q6ykNe54KduI2sKYyM+k9eNccQ7peG1h+242y735KUB8wjD0OUdCnYteQQjT
         AWyGfAExm9ufhRTnXwx707KOM9ZZFhlytV/qo=
Received: by 10.231.160.205 with SMTP id o13mr3524979ibx.15.1286654277800;
        Sat, 09 Oct 2010 12:57:57 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x10sm5120973iba.4.2010.10.09.12.57.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 12:57:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CB0C0DC.40108@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158601>

Jens Lehmann wrote:
> Am 07.10.2010 15:33, schrieb Jon Seymour:

>> I wonder if the name is a little too general for the function of this
>> configuration variable and if it might not be better to qualify it a
>> little further, perhaps
>> with the recursive suffix, e.g.:
>> 
>>     submodule.<name>.fetch.recursive
>> 
>> This would allow us to define other attributes that configure fetch on
>> a per submodule basis later should the need arise.
>
> I think that's a valid point (especially as we might add the --recursive
> option to other commands too). I will change the option name as proposed
> in the next version.

That would look like

	[submodule "<name>"]
		fetch.recursive = ...

in files with .git/config syntax.  Maybe fetchRecursive or similar
would be more consistent with existing variables?

I'm not personally invested in any name; just thought that reminder
might be useful.
