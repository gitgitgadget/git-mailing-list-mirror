From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 2/2] config: clear the executable bits (if any) on
 $GIT_DIR/config
Date: Mon, 17 Nov 2014 10:03:58 +0100
Message-ID: <5469B9FE.5070001@alum.mit.edu>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu> <1416122508-30654-3-git-send-email-mhagger@alum.mit.edu> <54685B05.90007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?ISO-8859-15?Q?Torsten_B=F6ge?= =?ISO-8859-15?Q?rshausen?= 
	<tboegi@web.de>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 10:04:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqIEH-0005cn-7o
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 10:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbaKQJEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 04:04:08 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60663 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489AbaKQJEG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2014 04:04:06 -0500
X-AuditID: 1207440d-f79676d0000046cb-3f-5469ba027193
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E8.36.18123.20AB9645; Mon, 17 Nov 2014 04:04:02 -0500 (EST)
Received: from [192.168.69.130] (p5DDB383E.dip0.t-ipconnect.de [93.219.56.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAH93x9r026553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Nov 2014 04:04:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <54685B05.90007@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsUixO6iqMu0KzPE4MUzTYuuK91MFg29V5gt
	nsy9y2yx8N9Rdov/OxawWOxvSrJY072DyaKz4yujA4fHzll32T2OHWtl9nj4qovd4+IlZY/P
	m+Q8bj/bxuLRPOU8awB7FLdNUmJJWXBmep6+XQJ3xsztO1kL1vBVPD1xg72BcQJ3FyMnh4SA
	iUTb1EY2CFtM4sK99UA2F4eQwGVGifN3FkM555gkVnVPYQep4hXQlpjWtZUFxGYRUJWY9vsg
	mM0moCuxqKeZCcQWFQiSOLnnOlS9oMTJmU/AakQEXCT+Lf0ONpRZYBYTUOIO2GphgWiJ/sYt
	rBDbpjNKbHrQxwiS4BRQk5i6+grQVA6gDl2JtjUyIGFmAXmJ5q2zmScwCsxCsmMWQtUsJFUL
	GJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVmluilppRuYoREBe8Oxv/rZA4xCnAwKvHw
	7sjODBFiTSwrrsw9xCjJwaQkyjt9B1CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCK/yNqAcb0pi
	ZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC1xVkqGBRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoVuOLgdEKkuIB2rsRpJ23uCAxFygK0XqKUVFKnLcOJCEAksgo
	zYMbC0t1rxjFgb4U5l0JUsUDTJNw3a+ABjMBDZ6zAWxwSSJCSqqBcWp5ZvRDzQ3LVmx5b/V/
	jsJ81XRusV/TLy68zf/84r661IfHj7Yl88hejEnxvTRj1lkdywsxFn8sFnPMNX+6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/16/2014 09:06 AM, Johannes Sixt wrote:
> Am 16.11.2014 um 08:21 schrieb Michael Haggerty:
>> @@ -559,9 +562,21 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>>  		if (given_config_source.blob)
>>  			die("editing blobs is not supported");
>>  		git_config(git_default_config, NULL);
>> -		launch_editor(given_config_source.file ?
>> -			      given_config_source.file : git_path("config"),
>> -			      NULL, NULL);
>> +		config_file = xstrdup(given_config_source.file ?
>> +				      given_config_source.file : git_path("config"));
>> +		launch_editor(config_file, NULL, NULL);
>> +
>> +		/*
>> +		 * In git 2.1, there was a bug in "git init" that left
>> +		 * the u+x bit set on the config file. To clean up any
>> +		 * repositories affected by that bug, and just because
>> +		 * it doesn't make sense for a config file to be
>> +		 * executable anyway, clear any executable bits from
>> +		 * the file (on a "best effort" basis):
>> +		 */
>> +		if (!lstat(config_file, &st) && (st.st_mode & 0111))
> 
> At this point we cannot be sure that config_file is a regular file, can
> we? It could also be a symbolic link. Wouldn't plain stat() be more
> correct then?

You make a good point. But I'm a little nervous about following symlinks
and changing permissions on some distant file. Also, the bug that we are
trying clean up after would not have created a symlink in this place, so
I think the cleanup is not so important if "config" is a symlink.

So I suggest that we stick with lstat(), but add S_ISREG(st.st_mode) to
the && chain above. Does that sound reasonable?

>> +			chmod(config_file, st.st_mode & 07666);
>> +		free(config_file);
>>  	}
>>  	else if (actions == ACTION_SET) {
>>  		int ret;

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
