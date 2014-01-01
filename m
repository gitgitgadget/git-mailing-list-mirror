From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/5] safe_create_leading_directories(): add "slash" pointer
Date: Wed, 01 Jan 2014 22:10:25 +0100
Message-ID: <52C48441.8060605@alum.mit.edu>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu> <1387696451-32224-4-git-send-email-mhagger@alum.mit.edu> <20131226223444.GY20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 01 22:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyT43-0006MC-JM
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jan 2014 22:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbaAAVKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jan 2014 16:10:30 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58616 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754556AbaAAVK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jan 2014 16:10:29 -0500
X-AuditID: 1207440c-b7f566d000004272-91-52c484442da6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 4F.41.17010.44484C25; Wed,  1 Jan 2014 16:10:28 -0500 (EST)
Received: from [192.168.69.148] (p57A256B4.dip0.t-ipconnect.de [87.162.86.180])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s01LAPsB004359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Jan 2014 16:10:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <20131226223444.GY20443@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqOvSciTIYG2jokXXlW4mi4beK8wW
	b28uYXRg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfsPXGVsWCyeMWF+XeZGhgn
	CnUxcnJICJhIvJ53gA3CFpO4cG89kM3FISRwmVFi6oUeZgjnHJPE3as9jF2MHBy8AtoSp046
	gZgsAqoS9x/Lg/SyCehKLOppZgKxRQWCJB4desgOYvMKCEqcnPmEBcQWEdCQeP7pG9guZgFr
	iRWvD4PVCwv4S3xqOQq1aiGjxO3t31hBEpwCBhJnH89mBtklISAu0dMYBNGrI/Gu7wEzhC0v
	sf3tHOYJjIKzkKybhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNK
	NzFCAppnB+O3dTKHGAU4GJV4eH9EHgkSYk0sK67MPcQoycGkJMp7uRwoxJeUn1KZkVicEV9U
	mpNafIhRgoNZSYRXKgMox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS
	4E1pBmoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VvfDEwgkFSPEB7d4O08xYX
	JOYCRSFaTzHqcsz78uEboxBLXn5eqpQ471qQIgGQoozSPLgVsPT1ilEc6GNh3g6QKh5g6oOb
	9ApoCRPQEpGSQyBLShIRUlINjALvfDg80/o2VDClms7Ji6neUPQhMeTV1lShyh0y/L/nGLEJ
	TpugJ/G087L4ly1Tswtfv9DMy1vHytF2o/Clz+rjXgUtj5LWvDVNuSjY1Xz/i5DD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239846>

On 12/26/2013 11:34 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> [Subject: safe_create_leading_directories(): add "slash" pointer]
> 
> Is this a cleanup or improving the (internal) functionality of the
> function somehow?  The above one-liner doesn't sum up for me in an
> obvious way why this is a good change.

It's hard to make the subject more self-explanatory, given so few
characters.  But I will make the rest of the log message better in the
reroll.

>> Keep track of the position of the slash character separately, and
> 
> Separately from what?
> 
>> restore the slash character at a single place, at the end of the while
>> loop.  This makes the next change easier to implement.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Ah, do I understand correctly that this is about cleaning up
> after the code that scribbles over 'path' in one place, to make
> it harder to forget to do that cleanup as new code paths are
> introduced?

Yes.

> It's too bad there's no variant of 'stat' and 'mkdir' that takes
> a (buf, len) pair which would avoid the scribbling altogether.

Yes.

>> ---
>>  sha1_file.c | 36 ++++++++++++++++++------------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index cc9957e..dcfd35a 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -107,40 +107,40 @@ int mkdir_in_gitdir(const char *path)
>>  
>>  int safe_create_leading_directories(char *path)
>>  {
>> -	char *pos = path + offset_1st_component(path);
>> +	char *next_component = path + offset_1st_component(path);
> 
> This name change is probably worth also mentioning in the commit
> message (or lifting into a separate patch) so the reader doesn't get
> distracted.

OK, I split the renaming into a separate commit.

>> +	int retval = 0;
>>  
>> -	while (pos) {
>> +	while (!retval && next_component) {
> 
> A more usual style would be
> [...]
> Using retval for control flow instead makes it eight lines more
> concise, which is probably worth it.

Agreed.

> [...]
>> 			if (!S_ISDIR(st.st_mode)) {
>> -				*pos = '/';
>> -				return -3;
>> +				retval = -3;
>> 			}
> 
> Now the 'if' body is one line, so we can drop the braces and save
> another line. :)

Will fix.

> One more nit: elsewhere in this file, a variable keeping track of the
> return value is named 'ret', so it probably makes sense to also use
> that name here.

OK, will change.

> That would mean the following changes to be potentially squashed in
> [...]

While going over the code again, I noticed another problem in the
original version; namely, that the handling of redundant multiple
slashes in the input path is not correct.  I will fix this problem and
split up the commit into smaller steps in the re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
