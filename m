From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: stGIT: commit vs export vs mail
Date: Fri, 17 Feb 2006 18:11:34 -0800 (Pacific Standard Time)
Message-ID: <Pine.WNT.4.63.0602171802030.2172@jbrandeb-desk.amr.corp.intel.com>
References: <Pine.WNT.4.63.0602171139020.3052@jbrandeb-desk.amr.corp.intel.com>
 <43F64A51.10607@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 03:11:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAHZV-0005M6-Bs
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 03:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWBRCLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 21:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWBRCLi
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 21:11:38 -0500
Received: from fmr19.intel.com ([134.134.136.18]:48779 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750737AbWBRCLh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 21:11:37 -0500
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k1I2Ba0M000470;
	Sat, 18 Feb 2006 02:11:36 GMT
Received: from nwlxmail01.jf.intel.com (nwlxmail01.jf.intel.com [10.7.171.40])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k1I2BabQ014526;
	Sat, 18 Feb 2006 02:11:36 GMT
Received: from jbrandeb-desk.amr.corp.intel.com (jbrandeb-desk.amr.corp.intel.com [134.134.3.102])
	by nwlxmail01.jf.intel.com (8.12.10/8.12.9/MailSET/Hub) with ESMTP id k1I2BZnn017902;
	Fri, 17 Feb 2006 18:11:35 -0800
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <43F64A51.10607@gmail.com>
ReplyTo: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
X-X-Sender: jbrandeb@orsmsx408.amr.corp.intel.com
X-Scanned-By: MIMEDefang 2.52 on 10.7.209.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16381>

On Fri, 17 Feb 2006, Catalin Marinas wrote:
> Jesse Brandeburg wrote:
>> So I am using stgit .8 right now, and I'm having a hard time figuring
>> out what the correct workflow should be for using stg and then
>> committing a change
>>
>> Here is what I've been doing:
>> stg new test
>>  enter my short description on first line
>>  enter my long description on next lines.
>> vi file
>> stg refresh
>> stg mail <blah blah blah>
>> or
>> stg commit
>
> There is no "or" above but only "and maybe". The 'commit' command is
> only used to permanently store a set of patches into the repository.
> After that, you should not be able to change them anymore (well, someone
> just sent me a patch for an uncommit command). I only use this command
> when I work in the "maintainer" mode on StGIT. For contributing patches,
> you shouldn't need it since the base of the stack should usually be
> identical to the HEAD of the remote repository.

I'm trying to commit changes to a local repository so that the maintainer 
can do a "pull" off of my repository.

>> Problem that I'm having right now is that the templates do the right
>> thing for mail, but, the commit only puts in the "enter my..." text.
>
> I don't fully understand this. Where does commit put the "enter my..." text?

so I used stgit to commit this change.  It puts it in the git log of 
checkins for the repository.

[jbrandeb@lindenhurst-2 e1000]$ git log | head -n 20

commit fb16b7111dae51b9a928aa7706d1cc022df8741d
Author: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date:   Fri Feb 17 11:29:19 2006 -0800

     e1000: update readme
     Update the e1000 text to the latest version

     Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

>> Is there a template based way to automatically append the author in the
>> Signed-off-by: line when i do stg commit?
>
> This can only be done when creating a patch. Commit doesn't modify the
> patches. I think you slightly misunderstood the commit command.

the stgit command stg commit freezes patches that I've made into my 
repository.  I think I get that, but I've been wrong before.  Its just 
that I can template the Signed-off-by: line for emails, but when I do a 
stg commit I want the thing to have the Signed-off-by: line in the commit 
text (like above where I added it by hand)

I guess I'll just change my templates to not auto add the Signed-off-by 
line and then things will work okay, as I'll just add the line during stg 
new ...

Thanks for your reply, and the cool tool!

Jesse
