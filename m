From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Fixed text file auto-detection: treat EOF character 032 at the end of file as printable
Date: Fri, 11 Jul 2008 22:32:25 +0200
Message-ID: <920CBA3F-779D-4861-B447-135690B4E8BD@zib.de>
References: <7vabh0d4t9.fsf@gitster.siamese.dyndns.org> <1215794896-31354-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807111940420.8950@racer>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 22:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHPJt-0000vH-Kf
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 22:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbYGKUcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 16:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759874AbYGKUcu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 16:32:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:50218 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760832AbYGKUct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 16:32:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6BKW4vY019384;
	Fri, 11 Jul 2008 22:32:09 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9309a.pool.einsundeins.de [77.185.48.154])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6BKVx0v025579
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jul 2008 22:31:59 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807111940420.8950@racer>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88169>


On Jul 11, 2008, at 8:42 PM, Johannes Schindelin wrote:

> On Fri, 11 Jul 2008, Steffen Prohaska wrote:
>
>> From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
>>
>> Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>> ---
>> convert.c |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/convert.c b/convert.c
>> index 352b69d..78efed8 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -61,6 +61,10 @@ static void gather_stats(const char *buf,  
>> unsigned long size, struct text_stat *
>> 		else
>> 			stats->printable++;
>> 	}
>> +
>> +	/* If file ends with EOF then don't count this EOF as non- 
>> printable. */
>> +	if (size >= 1 && buf[size-1] == '\032')
>> +		stats->nonprintable--;
>
> This is one of the things that are very specific to Windows and  
> should not
> affect other people.

Does this mean you are opposed to this change?

Junio thinks that "the intention of this change is good" [1].  Hence,
I cleaned up the style and re-send the patch.

[1] http://article.gmane.org/gmane.comp.version-control.git/87122

	Steffen
