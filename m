From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: checkout extra files
Date: Tue, 4 Sep 2012 23:53:47 +0100
Organization: OPDS
Message-ID: <53AE674D81CD4B9CB013C1DE846240B2@PhilipOakley>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com> <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com> <7vsjayew50.fsf@alter.siamese.dyndns.org> <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com> <7vd322ebsz.fsf@alter.siamese.dyndns.org> <CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com> <CAB9Jk9CNYr6LfWvyVqXvHjh7dzhUAuzkufqO9YMeOXg08D2cJw@mail.gmail.com> <CACsJy8AUYigHVKjzE-0NT0hnOrQWdufN+COmkk=2Q8L1Rimytw@mail.gmail.com> <CAB9Jk9D0DHBJEpVq=Z=12TV=+Av0oFVZ0yO1svLh1wyuP+9r1Q@mail.gmail.com> <7v4nndd98g.fsf@alter.siamese.dyndns.org> <CAB9Jk9DVcG14mS3HaGE4JEY0AwExvjqrnQqzTEZxHLjEQ6UObg@mail.gmail.com> <7vobll8qn2.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Angelo Borsotti" <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 00:53:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9203-0007vj-CU
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 00:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896Ab2IDWxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 18:53:32 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:57793 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752880Ab2IDWxb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 18:53:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar4OADGFRlBZ8rU+/2dsb2JhbABFi0SuWgEBgQOBCIIbBQEBBQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQIEgYHCQENBgESCAIBAgMBh20DELE5DYlSiiZjghgeGgWBEIJtYAOIG4VDhieMZoUIgmQ
X-IronPort-AV: E=Sophos;i="4.80,369,1344207600"; 
   d="scan'208";a="402832537"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip01ir2.opaltelecom.net with SMTP; 04 Sep 2012 23:53:29 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204791>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, September 04, 2012 9:44 PM
> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
>> The issue here is that the paths must denote filenames that are
>> present in the index
>> or tree-ish, so, wildcards are misleading since they would instead be
>> interpreted
>> with respect to the working directory.
>
> When you are talking to a shell (and you almost never directly talk
> to Git), wildcards are always interpreted with respect to the
> working directory by the shell.  And that is not specific to Git.
>
>> A possible way to make this clear is to warn the user to quote paths
>> that contain
>> wildcards. Something like, e.g.:
>>
>>   "Note that <paths> that contain wildcards must be quoted in order 
>> to
>> denote files that
>>    belong to the index or <tree-ish>. Otherwise, they are interpreted
>> by the shell with
>>    respect to the current directory, with a result that may depend on
>> the shell."
>
> Perhaps, if you drop ", with a result..." from that sentence.
>
> Even though that description is a bit too much on the side of "shell
> primer" than "git documentation" for my taste, I could see it may
> help some people, so I wouldn't reject such a phrasing out of hand.
>
> Let's see what others feel.
>

A comment about the need to quote wild cards would certainly be of 
advantage to many Windows users who won't have used a shell in that way 
before.

Plus I suspect that a large fraction of basic unix/linux users will have 
never really considered the difference between shell expansion and git 
expansion in this case where there are two diifferent 'file systems', as 
demonstrated by the initial query. 
