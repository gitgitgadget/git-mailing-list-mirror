From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 19:15:22 -0400
Message-ID: <4E6E928A.6080003@sunshineco.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7vk49d5t8u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Boaz Harrosh <bharrosh@panasas.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fit-0000hb-9N
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717Ab1ILXP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:15:26 -0400
Received: from mail-vw0-f52.google.com ([209.85.212.52]:64858 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611Ab1ILXP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:15:26 -0400
Received: by vws16 with SMTP id 16so5578319vws.11
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iKt0XlWB+5NrN7s+PtBcM4Swjgdx8x7p0ay/jVOP2p4=;
        b=XBEOER5tnECrryqu5cdcpqmMzzZ5wuMyy/ifcbETY7zR/SnmFY7qwBcVa4P1APmqaO
         8AjVYI7iOhBCm13LYcWiJR9NhAFNZSmjXBzvgwSwFeSTEQRZOhsjUcjp23RIHhCaydeB
         KQ7ooLHJ5MKTT2KbgUUNq4fRZx8xK30f1m6p4=
Received: by 10.52.100.8 with SMTP id eu8mr2233806vdb.494.1315869325434;
        Mon, 12 Sep 2011 16:15:25 -0700 (PDT)
Received: from [192.168.1.1] (user-0c936tj.cable.mindspring.com [24.145.155.179])
        by mx.google.com with ESMTPS id ch2sm11300039vdc.19.2011.09.12.16.15.23
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 16:15:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.0; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <7vk49d5t8u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181253>

On 9/12/2011 5:46 PM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> [Stalled]
>>
>> * jk/default-attr (2011-08-26) 1 commit
>>   - attr: map builtin userdiff drivers to well-known extensions
>>
>> Not urgent; I fixed up the test breakage just for fun.
>
> Could people who participated in the discussion make sure what is queued
> includes their favorite extensions they proposed?

The following extensions I mentioned are missing from jk/default-attr:

	"*.htm diff=html",
	"*.cpp diff=cpp",
	"*.mm diff=objc",

On Windows, .htm is common, and .cpp is required by several Windows C++ 
compilers. On Mac OS X, .mm is used for Objective-C++. The other 
extensions I mentioned (.cs, .hpp, .m) are present in jk/default-attr.

Peff also asked if uppercase extensions are common on Windows. They are, 
so one often sees .HTM, .HTML, etc. Should this issue be handled by 
jk/default-attr?

By the way, there appears to be an error in 1ff2bcf79b (attr: map 
builtin userdiff drivers to well-known extensions, 2011-08-25):

> static const char *builtin_attr[] = {
>  	"[attr]binary -diff -text",
> +	"*.html diff=html",
> 	...omitted...
> +	"*.f[0-9][0-9] diff=fortran",
> +	"*.m objc",
>  	NULL,

Shouldn't the last entry be?

	"*.m diff=objc",

(note the missing 'diff=')

-- ES
