From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: [PATCH 1/2] compat: introduce stat_to_kilobytes
Date: Tue, 19 Aug 2008 10:39:48 +0200
Message-ID: <3C98B537-7CD6-4575-8196-1706F8DA049C@web.de>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de> <7vy72w6kiv.fsf@gitster.siamese.dyndns.org> <200808182157.16392.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:41:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVMmr-0004CE-8T
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbYHSIkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 04:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYHSIkw
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:40:52 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33625 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYHSIkv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 04:40:51 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5AE19E708876;
	Tue, 19 Aug 2008 10:40:10 +0200 (CEST)
Received: from [91.18.110.246] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KVMl8-0003Go-00; Tue, 19 Aug 2008 10:40:10 +0200
In-Reply-To: <200808182157.16392.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX18kgAeospChfMNYeSasSk8mZzXDJNbVPh4CWF4j
	I2gI1uXfQyv7C3clA+ZcibiVhlCfv51MRbY6nzMOdlH3YPcaOk
	cgfAY6Zu1xNcID55fjpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92832>


Am 18.08.2008 um 21:57 schrieb Johannes Sixt:

> From: Junio C Hamano <gitster@pobox.com>
>
> Some platforms do not have st_blocks member in "struct stat"; mingw
> already emulates it by rounding it up to closest 512-byte blocks (even
> though it could overcount when a file has holes).
>
> The reason to use the member is only to figure out how many  
> kilobytes the
> file occupies on-disk, so give a helper in git-compat-util.h to help  
> these
> platforms.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> On Sonntag, 17. August 2008, Junio C Hamano wrote:
>>   The comment before "struct mingw_stat" suggests that the only  
>> reason
>>   this compatiblity definition exists is to add st_blocks member,  
>> so I
>>   suspect we could remove the definition and simplify the  
>> compatibility
>>   layer a lot more, but I do not know MinGW, so I am CC'ing j6t here.
>
> Makes sense. Here it is again, with the Makefile fixup noted by  
> Andreas.

I have tested this on Haiku, compiles okay and simplifies my patches.

Thanks,
Andreas
