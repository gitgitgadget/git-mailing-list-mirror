From: Eric Raible <raible@nextest.com>
Subject: Re: RFH: is the current file available to a custom merge driver?
Date: Tue, 31 Aug 2010 12:07:40 -0700
Message-ID: <4C7D52FC.8000701@nextest.com>
References: <4C7D4F63.2060307@nextest.com> <20100831185708.GS2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:07:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWBY-0004cy-Mp
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab0HaTHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:07:42 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:24827 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751777Ab0HaTHl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:07:41 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Tue, 31 Aug 2010 12:07:40 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20100831185708.GS2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154965>

On 8/31/2010 11:57 AM, Jonathan Nieder wrote:
> Hi Eric,
> 
> Eric Raible wrote:
> 
>> In writing a custom merge driver to support $dayjob
>> requirements I've failed to find a simple way of getting
>> the current file name that the driver is supposed to
>> be merging.
>>
>> I of course have the "ancestor", "ours", and "theirs"
>> temporary files, but for Ui purposes I'd like to know
>> the filename as well.
> 
> It's not available.  You can try modifying ll-merge.c to
> expose it if you have an idea about how that should work.
> .

Thanks Jonathan for the (very!) quick response, but since
time is short I think I'll stick with my current technique
(grepping $(git ls-tree -r HEAD) for $(git hash-object %A))
