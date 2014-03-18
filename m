From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] fsck.c:fsck_commit() use starts_with() and skip_prefix()
Date: Wed, 19 Mar 2014 00:16:16 +0100
Message-ID: <5328D3C0.5080009@alum.mit.edu>
References: <1395182512-17179-1-git-send-email-darrazo16@gmail.com> <CAPig+cRoRzZKjW3cY86iQxz9iZ_TKT-yyu=6Va5aV_DsCAQquA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Othman Darraz <darrazo16@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 00:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ3FA-0006Rn-Sr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 00:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212AbaCRXQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 19:16:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54512 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757255AbaCRXQT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Mar 2014 19:16:19 -0400
X-AuditID: 1207440e-f79c76d000003e2c-80-5328d3c375be
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 8B.2E.15916.3C3D8235; Tue, 18 Mar 2014 19:16:19 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD44F0.dip0.t-ipconnect.de [79.221.68.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2INGGXT008385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 18 Mar 2014 19:16:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAPig+cRoRzZKjW3cY86iQxz9iZ_TKT-yyu=6Va5aV_DsCAQquA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqHv4skawwcf37Bannuxktei60s1k
	ceZNI6MDs8fOWXfZPRY/8PL4vEkugDmK2yYpsaQsODM9T98ugTtj5a8OtoLNfBVz775ja2Bc
	wN3FyMkhIWAicXbzGyYIW0ziwr31bCC2kMBlRokdH6y7GLmA7PNMEu0HNjKDJHgFtCVazt8F
	a2ARUJWYd6uDBcRmE9CVWNTTDBYXFQiWWH35AQtEvaDEyZlPwGwRoN4PGzYxgtjMAu4SK149
	BLOFBXwl7n97wA6xrINRYnX3L3aQBKdAoMTlVY+ALuIAuk5coqcxCKJXR+Jd3wNmCFteYvvb
	OcwTGAVnIVk3C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKE
	hDTfDsb29TKHGAU4GJV4eA9EaQQLsSaWFVfmHmKU5GBSEuUtvQgU4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJMJ7eiJQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwcsA
	jF0hwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAExxcDYxgkxQO099wlkL3FBYm5
	QFGI1lOMuhwbtq1pZBJiycvPS5US5z0JUiQAUpRRmge3ApbAXjGKA30szHsfpIoHmPzgJr0C
	WsIEtGTRdDWQJSWJCCmpBsayhFdvxHttD533uS+0zudbfsK2sM2vr5uwCF//WGLBHilyZ5J5
	rPsj01VdE9P+R3jrKpYzbomz0vowRzj7j9UWgfdWanWe10qePDxyqs1a8gGXD2vX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244396>

On 03/19/2014 12:09 AM, Eric Sunshine wrote:
> Thanks for the submission. Comments below to give you a taste of the
> Git review process...
> 
> On Tue, Mar 18, 2014 at 6:41 PM, Othman Darraz <darrazo16@gmail.com> wrote:
>> use of starts_with() instead of memcmp()
>>
>> use of skip_prefix instead of memcmp() and strlen()
> 
> Write proper sentences to explain and justify the change; not sentence
> fragments.
> 
>> Signed-off-by: Othman Darraz <darrazo16@gmail.com>
>> ---
>>
>> I am planning to apply to GSOC 214
> 
> Your logic in these changes is rather severely flawed. Running the
> test suite (t1450, in particular), as the GSoC microproject page
> suggests, would have clued you in that something was amiss.
> 
>>  fsck.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fsck.c b/fsck.c
>> index 64bf279..5eae856 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -290,7 +290,7 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>>         int parents = 0;
>>         int err;
>>
>> -       if (memcmp(buffer, "tree ", 5))
>> +       if (starts_with(buffer, "tree "))
>>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>>         if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
> 
> One of the reasons for using starts_with() rather than memcmp() is
> that it allows you to eliminate magic numbers, such as 5. However, if
> you look closely at this code fragment, you will see that the magic
> number is still present in the expression 'buffer+5'. starts_with(),
> might be a better fit.

Eric, I think you meant to say that *skip_prefix()* might be a better fit.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
