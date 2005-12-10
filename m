From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 0/25] Usage message clean-up
Date: Sat, 10 Dec 2005 14:13:57 -0800
Message-ID: <439B5325.8000504@gmail.com>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 23:15:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElCz4-0003AL-TQ
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 23:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVLJWOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVLJWOH
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 17:14:07 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:28718 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750708AbVLJWOF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 17:14:05 -0500
Received: by xproxy.gmail.com with SMTP id t4so796923wxc
        for <git@vger.kernel.org>; Sat, 10 Dec 2005 14:14:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RArsviqPYYF1+v4w4G2BPX/YpWzb1jWaWmzIcn14Hyy2b4tIbQcihNEeVlqC7kAJ6mlTUUlzmbvv/jvsS8a6yNtzvANVnMzUR3WqvvxuAvdUGYy6o51+792Xczthg45xn6ScuZwFm2J8YGw652w1I/tTIA8htqiVJCMLuMvGmbY=
Received: by 10.70.46.17 with SMTP id t17mr7209802wxt;
        Sat, 10 Dec 2005 14:14:05 -0800 (PST)
Received: from ?10.0.0.6? ( [69.175.239.194])
        by mx.gmail.com with ESMTP id h14sm7442057wxd.2005.12.10.14.14.04;
        Sat, 10 Dec 2005 14:14:05 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: freku045@student.liu.se
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13473>

freku045@student.liu.se wrote:
...
> I have tried to follow the following rules:
> 
> * Any unrecognised options should make the script die with the usage
>   message.

Good.

> * -h and --help makes the script die with the usage message.

This should not be an error. The user was asking for the usage message.

> * The message is printed to stderr.

Good unless the message was printed due to -h or --help, then it should 
go to stdout.

> * The message is of the form "usage: $0 options"
> 
> I am not convinced that the last bullet point is the best way to do
> things. Using "$0" is probably best for Git developers but using "git
> program-name" is probably least confusing for users, especially if we
> are going to move the git-* binaries away from /usr/bin. Another
> option is "basename $0". What do you think?

Not using $0 can make it _extremely_ annoying to determine exactly which 
program printed the usage message. It may look prettier without the path 
but if I have more that one $(basename $0) it may not be trivial to 
determine the one that issued the message. Also keep in mind that is it 
possible to have spaces in names of executables. So, "foo-bar" and "foo 
bar" may be two different executables.
