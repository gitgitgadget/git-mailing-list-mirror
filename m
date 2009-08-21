From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: [PATCH 03/14] Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual
   C++
Date: Fri, 21 Aug 2009 23:18:40 +0200
Message-ID: <4A8F0F30.3020002@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com> <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com> <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com> <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com> <7vr5v4dgz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:18:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebVh-0007hN-BE
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbZHUVSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbZHUVSo
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:18:44 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55603 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbZHUVSo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:18:44 -0400
Received: by ewy3 with SMTP id 3so978256ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ajXyxIkRTdt+nvuKCk/JAlP7dwrdMyQTNXufFKTCzyc=;
        b=nXPNaImGwHHN5zwvlGQ+zxOaQC2/ukrE9VlD5G/7puBKI4zXJ8Z8AuaIxkBvPjNu7f
         bm6V3mEALdxiDNi5Iu0jqnOwhn2K8NnbVpwtpPm/0dK44fUiLqVkQE2vSs+/mrrV2XyC
         yaGecUIYeOTPHqBvwAy63mmR/FFcBYBNhg5pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=yAxczF5jh8Plzu1UENbtYeb7AlLlT+SC2amiI/0yVhHGMiQCJH/sNJdVTpcuHGbIe6
         G8ACWsqTsipLWfHT9pokUarvhCGSGvCDHSjPN9hnCsca5XMDdvw8IFJQayOoRqDUmNPA
         SvJM0yPJrI3+riiYrtVwYKxgva+utcQSv6RyM=
Received: by 10.211.200.7 with SMTP id c7mr2009441ebq.54.1250889524996;
        Fri, 21 Aug 2009 14:18:44 -0700 (PDT)
Received: from ?192.168.2.100? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 5sm3856631eyh.16.2009.08.21.14.18.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 14:18:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <7vr5v4dgz0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126758>

Junio C Hamano schreef:
> Marius Storm-Olsen <mstormo@gmail.com> writes:
> 
>> From: Frank Li <lznuaa@gmail.com>
>>
>> The Microsoft C runtime's vsnprintf function does not add NUL at
>> the end of the buffer.

> So if my reading is correct, it is not about "does not add NUL at the end"
> at all; it is "adds NUL beyond the end of given output buffer."
> 

As far as I know, the windows implementation does not add a terminating 
NUL when the string to write is greater or equal to the given buffer 
size. Otherwise it does add the NUL.
Same as for strncpy() on windows.
In my experience the windows implementation does never write behind the 
given buffer, not even a terminating zero.
