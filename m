From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Mon, 17 Nov 2014 10:35:18 +0100
Message-ID: <5469C156.7000907@alum.mit.edu>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu> <xmqqk32vyndg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?windows-1252?Q?Torsten_B=F6g?= =?windows-1252?Q?ershausen?= 
	<tboegi@web.de>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 10:35:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqIib-00034A-OA
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 10:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbaKQJfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 04:35:30 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57268 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751547AbaKQJf3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2014 04:35:29 -0500
X-AuditID: 1207440e-f79836d000000b8c-9d-5469c159089b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.56.02956.951C9645; Mon, 17 Nov 2014 04:35:21 -0500 (EST)
Received: from [192.168.69.130] (p5DDB383E.dip0.t-ipconnect.de [93.219.56.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAH9ZJxA027792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Nov 2014 04:35:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <xmqqk32vyndg.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqBt5MDPE4H+njkXXlW4mi4beK8wW
	C/8dZbf4v2MBi8X+piSLNd07mCw6O74yOrB77Jx1l93j2LFWZo+Ll5Q9Pm+S87j9bBuLR/OU
	86wBbFHcNkmJJWXBmel5+nYJ3Bm7Hi9hLDgtVPFvjUUD41W+LkZODgkBE4mlG7cxQ9hiEhfu
	rWfrYuTiEBK4zCix4etJJgjnHJPEylWdbCBVvALaEqt3rWXvYuTgYBFQldi/EKyZTUBXYlFP
	MxOILSoQJHFyz3V2iHJBiZMzn7CA2CICahIT2w6xgMxkFpjDJHF68jGwImGBCIkp245BLVvD
	KDHl2EqwBKeAtcS1nX1gi5kF9CR2XP/FCmHLSzRvnc08gVFgFpIls5CUzUJStoCReRWjXGJO
	aa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSATw7WBsXy9ziFGAg1GJh3dHdmaIEGti
	WXFl7iFGSQ4mJVHehD1AIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8ytuAcrwpiZVVqUX5MClp
	DhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV7XA0CNgkWp6akVaZk5JQhpJg5OkOFcUiLF
	qXkpqUWJpSUZ8aBYjS8GRitIigdoryNIO29xQWIuUBSi9RSjopQ4rxtIQgAkkVGaBzcWltZe
	MYoDfSnMawFSxQNMiXDdr4AGMwENnrMBbHBJIkJKqoFxfvJU4YX/J15cv2t3vJds0ZLczksi
	8gzC6X8XPozZuVNm1e+598WyfPRTfs//cP/ZU2MTo6v827Z7Hcxb9PT0i+KKdXFr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/16/2014 08:08 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Since time immemorial, the test of whether to set "core.filemode" has
>> been done by trying to toggle the u+x bit on $GIT_DIR/config and then
>> testing whether the change "took". It is somewhat odd to use the
>> config file for this test, but whatever.
> 
> The last sentence should read "We could create a test file and use
> it for this purpose and then remove it, but config is a file we know
> exists at this point in the code (and it is the only file we know
> that exists), so it was a very sensible trick".
> 
> Or remove it altogether.  In other words, do not sound as if you do
> not know what you are doing in your log message.  That would rob
> confidence in the change from the person who is reading "git log"
> output later.

The sentence is not meant to rob confidence in this change, but rather
to stimulate the reader's critical thinking about nearby code that I am
*not* changing.

By making this change without changing the function to use a temporary
file for its chmod experiments, I might otherwise give future readers
the impression that I like this shortcut, which I do not. For example,
if the original code had used a temporary file rather than "config",
then we would never have had the bug that I'm fixing. The "but whatever"
is meant to indicate that I don't disagree so strongly with the choice
of tradeoffs made by the original author that I think it is worth changing.

So maybe I am a coward (or lazy) for not proposing to change to using a
temporary file instead. But since this patch is suggested for maint, I
wanted to make the smallest change that would fix the bug.

Feel free to delete the controversial sentence if you prefer.

>> @@ -255,6 +255,7 @@ static int create_default_files(const char *template_path)
>>  		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>>  				!lstat(path, &st2) &&
>>  				st1.st_mode != st2.st_mode);
>> +		filemode &= !chmod(path, st1.st_mode);
> 
> Sounds good.
> 
> You could also &&-chain this "flip it back" to the above statement.
> If filemode is not trustable on a filesytem, doing one extra chmod()
> to correct would not help us anyway, no?

Yes, that would be better. I will fix it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
