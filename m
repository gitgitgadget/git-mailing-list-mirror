From: Bernd Ahlers <bernd@ba-net.org>
Subject: Re: [PATCH] 64-bit fix for date.c.
Date: Mon, 4 May 2009 16:26:14 +0200
Message-ID: <20090504142614.GE8658@jenna.bytemine.net>
References: <20090406172637.GA17437@jenna.bytemine.net> <20090406190657.GC28120@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 04 16:26:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0z83-0000l9-Qd
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 16:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbZEDO0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 10:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbZEDO0i
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 10:26:38 -0400
Received: from alk.gottorp.bytemine.net ([62.153.215.156]:46790 "EHLO
	mail4.bytemine.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbZEDO0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 10:26:38 -0400
Received: from andor.bytemine.net ([134.106.146.206]:50779 helo=jenna.bytemine.net)
	by mail4.bytemine.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <bernd@ba-net.org>)
	id 1M0z7n-0007kt-Pu; Mon, 04 May 2009 16:26:34 +0200
Received: from jenna.bytemine.net (bernd@localhost [127.0.0.1])
	by jenna.bytemine.net (8.14.3/8.14.3) with ESMTP id n44EQFPp003638
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Mon, 4 May 2009 16:26:16 +0200 (CEST)
Received: (from bernd@localhost)
	by jenna.bytemine.net (8.14.3/8.14.3/Submit) id n44EQEtL006423;
	Mon, 4 May 2009 16:26:14 +0200 (CEST)
X-Authentication-Warning: jenna.bytemine.net: bernd set sender to bernd@ba-net.org using -f
Content-Disposition: inline
In-Reply-To: <20090406190657.GC28120@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118241>

Jeff King [Mon, Apr 06, 2009 at 03:06:58PM -0400] wrote:
>On Mon, Apr 06, 2009 at 07:26:37PM +0200, Bernd Ahlers wrote:
>
>> @@ -871,13 +871,15 @@ unsigned long approxidate(const char *date)
>>  	struct timeval tv;
>> +	time_t time_sec;
>> [...]
>>  	gettimeofday(&tv, NULL);
>> -	localtime_r(&tv.tv_sec, &tm);
>> +	time_sec = tv.tv_sec;
>> +	localtime_r(&time_sec, &tm);
>
>Hmph. According to POSIX, tv_sec _is_ a time_t. But I see on FreeBSD,
>also, it is actually a "long". So I think this fix makes sense.
>
Okay. So what's the next step to get this committed? :)

Bernd
