From: =?ISO-8859-1?Q?Gabriel_Salda=F1a?= <gsaldana@gmail.com>
Subject: Re: msgmft segfaulting on tiger
Date: Thu, 28 Feb 2008 12:40:12 -0600
Message-ID: <47C7000C.1000809@gmail.com>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com> <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com> <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site> <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site> <7vablmqc7q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 19:39:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUnej-0005Gp-Gu
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 19:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbYB1Shm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 13:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYB1Shm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 13:37:42 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:44893 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbYB1Shl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 13:37:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2246289rvb.1
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 10:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=8uE0v3oWjznNs+/r3iSNmwKSccFP9ofr+h+dkMI24Z8=;
        b=UYkvjUB1bzcuhr1EPyshQ9bSVJUdYvP8laj7FcJGtVAsMSkTk1xg8bvIcBZFBrFZJ/z7scY5hh6yj5nDGzqg9LMcEy6rpp6e3MyGVK8QZTkwj1MT3faQHunp6iVFuQ2G3zG+pPIaOekpFnJ2/b6ZkamB3N5gewzt+BzCOgkyeTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=bmQdQ9PmAGySt0Ieru/p3Rz9zVWi2wp/JohJMXYh0lHr8uzqDMqkE5/ge9Fu4AiT09ES+Px5RE3qPa3J7i7ni6NoQdMHL42PTKBwtYjRaddDqzgQpSci1gHy+bn6lmKZNd9QJtXvV1ElgfZO9qLcYx6Onsos17bPkyV4sw+ivZ8=
Received: by 10.141.113.6 with SMTP id q6mr5781878rvm.135.1204223860486;
        Thu, 28 Feb 2008 10:37:40 -0800 (PST)
Received: from ?192.168.1.107? ( [200.67.17.70])
        by mx.google.com with ESMTPS id g6sm21108032rvb.25.2008.02.28.10.37.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Feb 2008 10:37:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <7vablmqc7q.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75433>

Here's the output, hope it helps:

$ msgfmt --tcl -l C -d . /dev/null; echo $?
msgfmt: unrecognized option `--tcl'
Try `msgfmt --help' for more information.
1

somehow msgfmt doesn't recognize the --tcl flag.

Gabriel Saldana

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> $ msgfmt --tcl; echo $?
>>> msgfmt: unrecognized option `--tcl'
>>> Try `msgfmt --help' for more information.
>>> 1
>> Darn.  I think that's the same exit code as for any other invocation 
>> without filename.
>>
>> So it seems that there is no easy way to tell a --tcl aware msgfmt from 
>> the other.
> 
> How about...
> 
>     $ msgfmt --tcl -l C -d . /dev/null; echo $?
> 
