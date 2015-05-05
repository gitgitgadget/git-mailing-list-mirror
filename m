From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/18] is_refname_available(): explain the reason for
 an early exit
Date: Tue, 05 May 2015 17:03:54 +0200
Message-ID: <5548DBDA.1000009@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>	<1430483158-14349-3-git-send-email-mhagger@alum.mit.edu> <CAGZ79kZDCMj1P1H3+LiW-Lk8S8TS91yJ_G4scmVSvg++3n7dvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 05 19:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpgpL-0006ND-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993855AbbEEQGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 12:06:35 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:46891 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993297AbbEEPEH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 11:04:07 -0400
X-AuditID: 1207440e-f79bc6d000000c43-ed-5548dbdd2137
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.E4.03139.DDBD8455; Tue,  5 May 2015 11:03:57 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97BF5.dip0.t-ipconnect.de [79.201.123.245])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t45F3tLM021568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 5 May 2015 11:03:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAGZ79kZDCMj1P1H3+LiW-Lk8S8TS91yJ_G4scmVSvg++3n7dvw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqHv3tkeoQcMRQYuuK91MFg29V5gt
	frT0MFts3tzO4sDisWBTqcez3j2MHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ0x7+lv1oK5
	ohX/F09na2BcytfFyMkhIWAicfnAeSYIW0ziwr31bF2MXBxCApcZJS7v+sMOkhASOM8ksXCf
	TxcjBwevgLZEw9t6kDCLgKrEi85/jCA2m4CuxKKeZrA5ogJBEq3XpoLFeQUEJU7OfMICYosI
	qEnMXDWbDcRmFiiX+HN5ETvISGGBSIlV5+Ig1h5ilHj48RTYWk6BQIn+D8dYIerVJf7Mu8QM
	YctLbH87h3kCo8AsJCtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdY73czBK9
	1JTSTYyQUObbwdi+XuYQowAHoxIPbwSXR6gQa2JZcWXuIUZJDiYlUV7GW0AhvqT8lMqMxOKM
	+KLSnNRioJM5mJVEePdcAMrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4
	lCR4Y0CGChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiNL4YGKkgKR6gvXNB2nmL
	CxJzgaIQracYFaXEebtBEgIgiYzSPLixsAT1ilEc6Eth3uMgVTzA5AbX/QpoMBPQ4FWFYINL
	EhFSUg2MgmI3NlyRnLZRq5/zUW5xDK+y/oEJwQE93DyrU+Z06jM4rv8rGKO/Wd+//Io6w/0H
	oU+DctqVL536mvDzyvq0L9bX1z8RveLlxvY9IshasnObxesa97PnZ+kluJU2ftzd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268405>

On 05/01/2015 07:21 PM, Stefan Beller wrote:
> On Fri, May 1, 2015 at 5:25 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> The reason why we can exit early if we find a reference in skip whose
>> name is a prefix of refname is a bit subtle, so explain it in a
>> comment.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 2bdd93c..ab438a5 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -907,8 +907,20 @@ static int is_refname_available(const char *refname,
>>                 pos = search_ref_dir(dir, refname, slash - refname);
>>                 if (pos >= 0) {
>>                         struct ref_entry *entry = dir->entries[pos];
>> -                       if (entry_matches(entry, skip))
>> +                       if (entry_matches(entry, skip)) {
>> +                               /*
>> +                                * The fact that entry is a ref whose
>> +                                * name is a prefix of refname means
>> +                                * that there cannot be any other ref
>> +                                * whose name starts with that prefix
>> +                                * (because it would have been a D/F
>> +                                * conflict with entry). So, since we
>> +                                * don't care about entry (because it
>> +                                * is in skip), we can stop looking
>> +                                * now and return true.
> 
> At first I thought this is not true, what about:
> refs/heads/foo
> refs/heads/foobar
> They go well together and one is a prefix of the other.
> What is crucial is the existence of a '/' just between the
> prefix and the ending part, so
> refs/heads/foo/bar doesn't fly here.
> 
> The assumption may be the case if the prefix itself always
> ends with a /, which is probably the case here?
> I don't know if that is worth noting as well.

Yes, this is all rather subtle. Here we have found a reference whose
name is *exactly* a proper prefix of refname; for example, refname is
"refs/foo/bar" and we just found "refs/foo". But "refs/foo" is in skip,
so it is not a conflict. Moreover, its existence means that there cannot
be any other references in the "refs/foo/*" namespace (e.g.,
"refs/foo/bar/banana") because such a reference would have conflicted
with "refs/foo".

If it's any consolation, this logic will be simplified a bit later in
the patch series. Nevertheless, I will try to explain this better in v2.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
