From: Daniel Corbe <corbe@corbe.net>
Subject: Re: Location of git config on Windows
Date: Mon, 18 Aug 2014 11:14:08 -0400
Message-ID: <ygflhqlvni7.fsf@corbe.net>
References: <ygfvbpqooog.fsf@corbe.net>
	<CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
	<53F135F8.60508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: kusmabite@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:47:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJQ5s-0007y4-5I
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 18:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbaHRQre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 12:47:34 -0400
Received: from port80.smtpcorp.com ([207.58.147.67]:46203 "EHLO
	port80.smtpcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaHRQrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 12:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=smtpcorp.com; s=a0_1;
	h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:Cc:To:From; bh=6cslvzEAWcp060Gk2IERO0/WHCtJ/J/C8P+pQrn7R+U=;
	b=i42Qh5RGQlsD5Zt7dPMhSJFd6rEULPdp08PoZ8Abe5VmYM9S1vctFlLIlBJT48RbLTyYAGeueES5JJtIBm9cwzuG1uP79vupOjwPfz7uCtTBCN/2J/R8uqdaQs48GVRYC8NcWXzC854XBCURj+pO6p4aLG2Mljw4sAEsfD7LdTs=;
In-Reply-To: <53F135F8.60508@gmail.com> (Karsten Blees's message of "Mon, 18
	Aug 2014 01:08:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (berkeley-unix)
X-Smtpcorp-Track: 1bJOdT4gfNgPDJ.8hhGg1QRr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255397>


Karsten Blees <karsten.blees@gmail.com> writes:

> Am 18.08.2014 00:01, schrieb Erik Faye-Lund:
>> On Sun, Aug 17, 2014 at 10:18 PM, Daniel Corbe <corbe@corbe.net> wrote:
>>>
>>> I installed git on my Windows machine while it was connected to my
>>> corporate network.  It picked up on that fact and used a mapped drive to
>>> store its configuration file.
>>>
>>> As a result, I cannot currently use git when disconnected from my
>>> network.  It throws the following error message: fatal: unable to access
>>> 'Z:\/.config/git/config': Invalid argument
>>>
>>> Obviously this value is stored in the registry somewhere because I made
>>> an attempt to uninstall and reinstall git with the same results.
>>>
>>> Can someone give me some guidance here?
>> 
>> Git looks for the per-user configuration in $HOME/.gitconfig, and if
>> $HOME is not set, it falls back to $HOMEDIR/$HOMEPATH/.gitconfig. My
>> guess would be some of these environment variables are incorrectly set
>> on your system.
>
> To be precise, git checks if %HOME% is set _and_ the directory exists before
> falling back to %HOMEDRIVE%%HOMEPATH%.
>
> If %HOMEDRIVE%%HOMEPATH% isn't set or the directory doesn't exist either, it
> falls back to %USERPROFILE%, which is always local (C:/Users/<yourname>), even
> if disconnected from the network (at least that's how its supposed to be).
>
>

Awesome!  Thanks for the advice. 

%HOMEDRIVE% and %HOMEPATH% are indeed set by my system and point to an
 (often disconnected) network drive.  I manually forced %HOME% to
 %USERPROFILE% and it works like a charm now.  

I would argue that on Windows %USERPROFILE% should be checked first (or
at least after %HOME%).

Best,
Daniel
