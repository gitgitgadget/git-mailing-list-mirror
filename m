From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH 3/3] Initialize variables with values
Date: Thu, 09 May 2013 15:49:58 +0200
Message-ID: <518BA986.8060209@cs-ware.de>
References: <518AF79A.5000408@cs-ware.de> <518AF843.6040501@cs-ware.de> <20130509132115.GA3375@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 15:50:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaREV-0005AC-ET
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 15:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab3EINuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 09:50:00 -0400
Received: from srv1.79p.de ([213.239.234.118]:37292 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab3EINuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 09:50:00 -0400
Received: from [139.174.6.11] (vpn11.rz.tu-clausthal.de [139.174.6.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id C3207441075;
	Thu,  9 May 2013 15:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2013; t=1368107397;
	bh=Ndz40+sIiyZqOs2bkzbbaOsoxV4JHc/NHIjAVNk61Lg=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=hPkpmrdp9AJUCJvXnsnwX4TkHuVH4YE26TYmExoxu1c1Wm01ZJshq1gBnHtwi1/2R
	 6anc3dxWTCHl6W2agtzaWkKyUwS097sdqUI/Qk1jU/qWMkpNxEG292Nhq4FU4eGk0P
	 bW5KatYgNev8aj80Aosiix6Ia553LbMBUANnelCE=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130509132115.GA3375@elie>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223733>

Am 09.05.2013 15:21 schrieb Jonathan Nieder:
> Sven Strickroth wrote:
> 
>> With MSVC initializing a variable with "int a=a" causes a warning about
>> using an uninitialized value.
> [...]
>> --- a/builtin/rev-list.c
>> +++ b/builtin/rev-list.c
>> @@ -338,7 +338,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>>  		mark_edges_uninteresting(revs.commits, &revs, show_edge);
>>  
>>  	if (bisect_list) {
>> -		int reaches = reaches, all = all;
>> +		int reaches = 0, all = 0;
> 
> A correct way to spell this is
> 
> 		int reaches, all;
> 
> which, as a bonus, lets the compiler warn if they are used
> uninitialized.  Does that provoke warnings?

This seems to be ok.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
