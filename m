From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within
 transactions
Date: Tue, 12 May 2015 10:45:08 +0200
Message-ID: <5551BD94.4050200@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>	<1431357920-25090-2-git-send-email-mhagger@alum.mit.edu> <xmqqpp672bh2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 10:45:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys5oh-0001Q3-TE
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 10:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbbELIp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 04:45:27 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42791 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932160AbbELIpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2015 04:45:25 -0400
X-AuditID: 12074414-f797f6d000004084-e9-5551bd96b8bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 48.EE.16516.69DB1555; Tue, 12 May 2015 04:45:10 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C91.dip0.t-ipconnect.de [93.219.28.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4C8j82H019619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 12 May 2015 04:45:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqpp672bh2.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqDttb2CowYNedYuuK91MFg29V5gt
	frT0MFts3tzOYnHmTSOjA6vHgk2lHs969zB6XLyk7LH4gZfH501yAaxR3DZJiSVlwZnpefp2
	CdwZNzY0sxU84qh4uMC0gfErWxcjJ4eEgInEk8krGSFsMYkL99aDxYUELjNK3Nno1cXIBWSf
	Z5LofbqfvYuRg4NXQFviyCJWkBoWAVWJ+/9bmEFsNgFdiUU9zUwgtqhAkETrtalgM3kFBCVO
	znzCAmKLCKhJTGw7xAIyk1lgIqPE3rU7wBqEBSIlbs/8zwixbA2jxJHHN8ASnALWEg/ebwXb
	xiygJ7Hj+i8oW16ieets5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JS
	i3Qt9HIzS/RSU0o3MULCW2QH45GTcocYBTgYlXh4DS74hwqxJpYVV+YeYpTkYFIS5a1aERgq
	xJeUn1KZkVicEV9UmpNafIhRgoNZSYS3thQox5uSWFmVWpQPk5LmYFES5/22WN1PSCA9sSQ1
	OzW1ILUIJivDwaEkwSu9B6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXA
	WAVJ8QDtbQZp5y0uSMwFikK0nmJUlBLn1QZJCIAkMkrz4MbCktYrRnGgL4V5g0CqeIAJD677
	FdBgJqDBjnEBIINLEhFSUg2M3mvDp1mn2GzKXjE5lPOcsbLrZ8OgU3/FlJIn3eS+m/UtRO35
	b4Gp+1Yp5l16az+/oEBHY8kvmTfLNHcb7DYVX2QkV2jm1fDIZGZu3YSibfdvPPhx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268847>

On 05/11/2015 08:52 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>  t/t1404-update-ref-df-conflicts.sh | 107 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>  create mode 100755 t/t1404-update-ref-df-conflicts.sh
>>
>> diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
>> new file mode 100755
>> index 0000000..ed1b93e
>> --- /dev/null
>> +++ b/t/t1404-update-ref-df-conflicts.sh
>> @@ -0,1 +1,107 @@
> 
> Where does this "-0,1" come from???

Good question. I had forgotten to insert the space in

        test_update_rejected () {
                            ^ space was missing when I ran format-patch

so I edited the email file in emacs. Emacs detected that the file
contained a patch, so when I edited the hunk, it tried to adjust the
hunk line numbers to keep them in agreement with the patch. Obviously,
it screwed up. So the incorrect line numbers were caused by a bug in
emacs diff-mode.

Sorry for the confusion.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
