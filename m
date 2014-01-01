From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/5] safe_create_leading_directories(): reduce scope of
 local variable
Date: Wed, 01 Jan 2014 13:39:55 +0100
Message-ID: <52C40C9B.2040001@alum.mit.edu>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu> <1387696451-32224-3-git-send-email-mhagger@alum.mit.edu> <20131226215559.GX20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 01 13:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyLCs-0001uG-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jan 2014 13:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbaAAMrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jan 2014 07:47:03 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64073 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753588AbaAAMrC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jan 2014 07:47:02 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jan 2014 07:47:02 EST
X-AuditID: 12074411-b7f426d000005455-78-52c40c9fb9a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BA.D0.21589.F9C04C25; Wed,  1 Jan 2014 07:39:59 -0500 (EST)
Received: from [192.168.69.148] (p57A256B4.dip0.t-ipconnect.de [87.162.86.180])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s01Cduqj016465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Jan 2014 07:39:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <20131226215559.GX20443@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqDuf50iQQfdyRYuuK91MFg29V5gt
	3t5cwujA7LFz1l12j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6YcfIfe8EF9orJHdvZGxh7
	2LoYOTkkBEwkFv36AmWLSVy4tx7I5uIQErjMKDH/bjOUc45JYv+TlSwgVbwC2hLf7y8Gs1kE
	VCXaDrUyg9hsAroSi3qamUBsUYEgiUeHHrJD1AtKnJz5BKxeREBD4vmnb2DbmAWsJVa8PgxW
	LywQI3H93Q5GEFtIYCGjxO11RiA2p4CBxKH9t4BqOICuE5foaQyCaNWReNf3gBnClpfY/nYO
	8wRGwVlIts1CUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCEh
	LbiDccZJuUOMAhyMSjy8Cx4cChJiTSwrrsw9xCjJwaQkynuY80iQEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRFezobDQUK8KYmVValF+TApaQ4WJXFeviXqfkIC6YklqdmpqQWpRTBZGQ4OJQne
	P9xAQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBERxfDIxhkBQP0F4uYOIQ4i0u
	SMwFikK0nmLU5Zj35cM3RiGWvPy8VClx3usgOwRAijJK8+BWwBLYK0ZxoI+Fed+CVPEAkx/c
	pFdAS5iAloiUHAJZUpKIkJJqYNQ5WpYxx7Du3dKra3nO9Hpdn733w8QG5oVsi9tYO/Xn2J9e
	aLzn9tq3zGdrWtY+m9Cfx5rPtrh9vVtXZd2/+Dl/9gdFzfs8ac9W7j9HbUOOOwkp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239845>

On 12/26/2013 10:55 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  sha1_file.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index c9245a6..cc9957e 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -108,9 +108,10 @@ int mkdir_in_gitdir(const char *path)
>>  int safe_create_leading_directories(char *path)
>>  {
>>  	char *pos = path + offset_1st_component(path);
>> -	struct stat st;
>>  
>>  	while (pos) {
>> +		struct stat st;
> 
> Is this to make it easier to reason about whether 'st' has been
> properly initialized at any given moment, or is there a more subtle
> reason?

No, just the boring reason, the one that makes me reduce the scope of
variables whenever possible.  I'll buff up the log message.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
