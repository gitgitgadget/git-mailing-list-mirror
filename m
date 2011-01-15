From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] svndump.c: Fix a printf format compiler warning
Date: Sat, 15 Jan 2011 18:06:27 +0000
Message-ID: <4D31E223.3080001@ramsay1.demon.co.uk>
References: <4D2C9EB1.2050100@ramsay1.demon.co.uk> <20110111183927.GF15133@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 19:15:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeAf0-0006iP-Hb
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 19:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab1AOSHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 13:07:43 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:49853 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752145Ab1AOSHm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jan 2011 13:07:42 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PeAWv-0006lJ-fJ; Sat, 15 Jan 2011 18:07:41 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110111183927.GF15133@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165148>

Jonathan Nieder wrote:
> Ramsay Jones wrote:
> 
>> --- a/vcs-svn/svndump.c
>> +++ b/vcs-svn/svndump.c
>> @@ -211,7 +211,7 @@ void svndump_read(const char *url)
>>  		if (key == keys.svn_fs_dump_format_version) {
>>  			dump_ctx.version = atoi(val);
>>  			if (dump_ctx.version > 2)
>> -				die("expected svn dump format version <= 2, found %d",
>> +				die("expected svn dump format version <= 2, found %"PRIu32,
>>  				    dump_ctx.version);
> 
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks!

> I think we should just use "int", but that is a wider sweeping change
> for another time.  Thanks.
> 
> Does gcc or sparse provide a warning that could have caught this
> mistake?

None that I know of, no ... :(

ATB,
Ramsay Jones
