From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH 5/9] git-cat-file: Add --separator option
Date: Tue, 23 Oct 2007 21:26:05 -0700
Message-ID: <471EC95D.6050201@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com> <20071024034301.GE24924@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 06:27:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkXph-0003UV-T6
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 06:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbXJXE0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 00:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbXJXE0v
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 00:26:51 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:57786 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbXJXE0u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 00:26:50 -0400
Received: from relay8.apple.com (relay8.apple.com [17.128.113.38])
	by mail-out4.apple.com (Postfix) with ESMTP id A7AF016AB748;
	Tue, 23 Oct 2007 21:26:40 -0700 (PDT)
Received: from relay8.apple.com (unknown [127.0.0.1])
	by relay8.apple.com (Symantec Mail Security) with ESMTP id 8EDDB40023;
	Tue, 23 Oct 2007 21:26:40 -0700 (PDT)
X-AuditID: 11807126-a7b2dbb000000803-70-471ec980c3b0
Received: from [17.203.12.72] (aroben3.apple.com [17.203.12.72])
	by relay8.apple.com (Apple SCV relay) with ESMTP id 751D340018;
	Tue, 23 Oct 2007 21:26:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071024034301.GE24924@lavos.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62186>

Brian Downing wrote:
> On Mon, Oct 22, 2007 at 10:46:33PM -0700, Adam Roben wrote:
>   
>> +--separator::
>> +	A string to print in between the output for each object passed on
>> +	stdin. A newline will be appended to the separator each time it is
>> +	printed.
>>     
>
> Maybe I'm just unreasonably paranoid, but I don't think I could ever
> trust that you'd never find an arbitrary separator in the data.  I
> suppose if you scanned the files beforehand you could come up with
> something guaranteed to be unique, but that seems like a pain (and
> doesn't happen regardless in patch 9/9; it just uses
> "--------------GITCATFILESEPARATOR-----------")  If I were committing to
> SVN, it's sure not something I'd like to bet the integrity of my data
> on.
>   

I had some of the same concerns.

> I think a far more reasonable output format for multiple objects would
> be something like:
>
> <count> LF
> <raw data> LF
>
> Where <count> is the number of bytes in the <raw data> as an ASCII
> decimal integer.
>   

This sounds like a much better solution. I'll implement it that way and 
send out a new patch. Thanks for the suggestion!

-Adam
