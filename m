From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Sat, 15 Aug 2009 06:39:58 +0900
Message-ID: <20090815063958.6117@nanako3.lavabit.com>
References: <200908121726.52121.luke-jr@utopios.org>
	<200908132306.37947.trast@student.ethz.ch>
	<7vws56i35q.fsf@alter.siamese.dyndns.org>
	<200908141539.18087.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Luke Dashjr <luke-jr+git@utopios.org>, git@vger.kernel.org
To: "Luke-Jr" <luke@dashjr.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:40:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc4Vo-0003to-H1
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 23:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716AbZHNVka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 17:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756670AbZHNVka
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 17:40:30 -0400
Received: from karen.lavabit.com ([72.249.41.33]:32856 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756642AbZHNVk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 17:40:29 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 28BA011B8FA;
	Fri, 14 Aug 2009 16:40:31 -0500 (CDT)
Received: from 3486.lavabit.com (195.116.69.252)
	by lavabit.com with ESMTP id X19MI6MAZVLG; Fri, 14 Aug 2009 16:40:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=sn4kV/2jY1SAwRVJSSjlaTXqsrq6K6th9l012yxkHYYYJcyZ0eZsBs6vreQib6R5PwQZgOKoUW4d55cZJ1HLLfnPBhLvso+fZIkBY8+cFN6RqEAl/MMt72HFAjkwhAW9Wbku0i3HKnXqHcTHlYDXRWRHAosDB5quK602Me4U34s=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <200908141539.18087.luke@dashjr.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125958>

Quoting "Luke-Jr" <luke@dashjr.org>

> On Friday 14 August 2009 02:52:33 pm Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>> > Junio C Hamano wrote:
>> >> Chould you refresh my memory a bit?
>> >>
>> >> In what circumstance is "rm --ignore-unmatch" useful to begin with?
>> >
>> > Not sure about add --ignore-unmatch myself, but there's even an
>> > example of rm --ignore-unmatch in man git-filter-branch, along the
>> > lines of
>> >
>> >   git filter-branch --index-filter '
>> >     rm --ignore-unmach some_file_that_shouldnt_be_in_history
>> >   ' -- --all
>>
>> Ah, that makes sense.  I am not sure about "add --ignore-unmatch" myself
>> either, and an example similar to the above filter-branch would not apply
>> very easily (i.e. "add a file that should have been in history" would not
>> need --ignore-unmatch).
>
> The purpose of "add --ignore-unmatch" is to ignore race conditions where one 
> of the files to be added has been deleted after git is executed, but before 
> git scans it.

First of all, it should have been mentioned as part of your proposed commit log message.

Second of all, if a race condition makes an "add" fail, isn't it a good thing? If your "add" ignored such a failure, you'd be recording an inconsistent or incomplete state.

IMHO, fixing your racy script is a much cleaner solution to your problem than forcing "git add" to ignore errors.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
