From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Clarifying "invalid tag signature file" error message from git
 filter-branch (and others)
Date: Fri, 12 Dec 2008 10:21:30 -0600
Message-ID: <ivc7ylNVmqD2RhGdI10MyG1ySwq00RZSzeh_UXbU05mhkw5od1QN8Q@cipher.nrlssc.navy.mil>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com> <P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil> <c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com> <LhfS_uc2B_Gje7rXd1882RMsQfSRjOEsBT24Z1Yza_bWhgl9lI-ZhQ@cipher.nrlssc.navy.mil> <c5df85930812111559p287ea6afk54a9759302288d5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jim Meyering <jim@meyering.net>
To: James Youngman <jay@gnu.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBAnD-0000LP-No
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 17:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757534AbYLLQVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 11:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757520AbYLLQVt
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 11:21:49 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45557 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757314AbYLLQVt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 11:21:49 -0500
Received: by mail.nrlssc.navy.mil id mBCGLUrQ015047; Fri, 12 Dec 2008 10:21:30 -0600
In-Reply-To: <c5df85930812111559p287ea6afk54a9759302288d5e@mail.gmail.com>
X-OriginalArrivalTime: 12 Dec 2008 16:21:30.0620 (UTC) FILETIME=[B0EFBBC0:01C95C75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102913>

James Youngman wrote:
> On Thu, Dec 11, 2008 at 11:13 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> 
>>> Before conversion:
>>> $ git cat-file tag FINDUTILS-4_1-10
>>> object ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
>>> type commit
>>> tag FINDUTILS-4_1-10
>>> tagger Kevin Dalley
>> The tagger field is missing an email address, a timestamp, and a timezone. It
>> should look something like:
>>
>>  tagger Kevin Dalley <kevin.dalley@somewhere.com> 1229036026 -0800
>>
>> git-mktag prevents improperly formatted tags from being created by checking
>> that these fields exist and are well formed.
>>
>> If you know the correct values for the missing fields, then you could
> 
> Yes for the email address.      But as for the timestamp, it's not in
> the tag file; that only contains the sha1.
> There is a timestamp in the object being tagged, is that the timestamp
> you are talking about?

Yes and no. I meant that if you knew the "real" timestamp, possibly by
extracting it from the original repository, then you can use that.
Otherwise yes, as a workaround, use the timestamp in the object being
tagged.

> $ git show --pretty=raw  ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
> commit ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
> tree 752cca144d39bc55d05fbe304752b274ba22641c
> parent 9a998755249b0c8c47e8657cff712fa506aa30fc
> author Kevin Dalley <kevin@seti.org> 830638152 +0000
> committer Kevin Dalley <kevin@seti.org> 830638152 +0000

The committer information should be used, though in this repository it will
probably always be the same as the author.

-brandon
