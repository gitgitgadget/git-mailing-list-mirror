From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/14] imap-send.c: remove some unused fields from struct
 store
Date: Mon, 14 Jan 2013 10:25:36 +0100
Message-ID: <50F3CF10.3000602@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu> <1358141566-26081-7-git-send-email-mhagger@alum.mit.edu> <20130114061920.GE3125@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 10:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TugIr-0006iE-VE
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 10:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab3ANJZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 04:25:41 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:45547 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756726Ab3ANJZk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 04:25:40 -0500
X-AuditID: 1207440d-b7f306d0000008b7-b3-50f3cf13b8e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.73.02231.31FC3F05; Mon, 14 Jan 2013 04:25:39 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E9PaoB002774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 04:25:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130114061920.GE3125@elie.Belkin>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqCt8/nOAwePV8hZdV7qZLBp6rzBb
	vL25hNHiR0sPswOLx85Zd9k9nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujP7m06wF
	bwQrfj5fy97A+IS3i5GTQ0LARGL228fsELaYxIV769m6GLk4hAQuM0osnPMByjnOJHGk+z8r
	SBWvgLZE/6GrjCA2i4CqxLs/F5lBbDYBXYlFPc1MILaoQIDE4iXn2CHqBSVOznzCAmKLCGhI
	PP/0jQ3EZhaIl9g0eQJYr7BAqMTd1Q+YIZYtZJT4Or8bbBCngIHE2493WSAadCTe9T1ghrDl
	Jba/ncM8gVFgFpIds5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK
	6SZGSEjz7mD8v07mEKMAB6MSD++mks8BQqyJZcWVuYcYJTmYlER5i88AhfiS8lMqMxKLM+KL
	SnNSiw8xSnAwK4nwTjsNlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAo
	SfDKngNqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFa3wxMF5BUjxAe4PPguwt
	LkjMBYpCtJ5i1OXY/rv9OaMQS15+XqqUOO9pkCIBkKKM0jy4FbAE9opRHOhjYV5+kEt4gMkP
	btIroCVMQEs27QVbUpKIkJJqYDRc9dbzZyt/U672yekXfgqsX+PreprLL8KrbWPAofZTu4qj
	xTTP7P9WtGrCwr3/Zkpr33M5eeq/hISfgseiaW/8jyaa7GkTl86cGvrupo3v378u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213477>

On 01/14/2013 07:19 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> --- a/imap-send.c
>> +++ b/imap-send.c
> [...]
>> @@ -772,13 +767,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>>  				   !strcmp("NO", arg) || !strcmp("BYE", arg)) {
>>  				if ((resp = parse_response_code(ctx, NULL, cmd)) != RESP_OK)
>>  					return resp;
>> -			} else if (!strcmp("CAPABILITY", arg))
>> +			} else if (!strcmp("CAPABILITY", arg)) {
>>  				parse_capability(imap, cmd);
>> -			else if ((arg1 = next_arg(&cmd))) {
>> -				if (!strcmp("EXISTS", arg1))
>> -					ctx->gen.count = atoi(arg);
>> -				else if (!strcmp("RECENT", arg1))
>> -					ctx->gen.recent = atoi(arg);
>> +			} else if ((arg1 = next_arg(&cmd))) {
>> +				/* unused */
> 
> Neat.  Let me try to understand what was going on here:
> 
> When opening a mailbox with the SELECT command, an IMAP server
> responds with tagged data indicating how many messages exist and how
> many are marked Recent.  But git imap-send never reads mailboxes and
> in particular never uses the SELECT command, so there is no need for
> us to parse or record such responses.
> 
> Out of paranoia we are keeping the parsing for now, but the parsed
> response is unused, hence the comment above.
> 
> If I've understood correctly so far (a big assumption), I still am not
> sure what it would mean if we hit this ((arg1 = next_arg(&cmd))) case.
> Does it mean:
> 
>  A. The server has gone haywire and given a tagged response where
>     one is not allowed, but let's tolerate it because we always have
>     done so?  Or
> 
>  B. This is a perfectly normal response to some of the commands we
>     send, and we have always been deliberately ignoring it because it
>     is not important for what imap-send does?

Honestly, I didn't bother to look into this.  I was just doing some
brainless elimination of obviously unused code.

No doubt a deeper analysis (like yours) could find more code to discard,
but I didn't want to invest that much time and this code has absolutely
no tests, so I stuck to the obvious (and even then you found a mistake
in my changes :-( ).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
