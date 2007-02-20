From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] Add prefixcmp()
Date: Tue, 20 Feb 2007 02:20:54 -0800
Message-ID: <7vfy91w2nt.fsf@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200942.18654.andyparkins@gmail.com>
	<7vbqjpxilh.fsf_-_@assigned-by-dhcp.cox.net>
	<87mz3916xh.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C. Hamano" <junkio@cox.net>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Feb 20 11:21:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJS7I-0006P8-4V
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 11:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbXBTKU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Feb 2007 05:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932845AbXBTKU5
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 05:20:57 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46460 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbXBTKU4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Feb 2007 05:20:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220102056.GBGB21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 05:20:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RmLv1W0061kojtg0000000; Tue, 20 Feb 2007 05:20:56 -0500
In-Reply-To: <87mz3916xh.fsf@morpheus.local> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of
	"Tue, 20 Feb 2007 11:04:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40227>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> We have too many strncmp(a, b, strlen(b)).
>>
>> Signed-off-by: Junio C Hamano <junkio@cox.net>
>> ---
>>  git-compat-util.h |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 9863cf6..0a9ac56 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -279,4 +279,9 @@ static inline int sane_case(int x, int high)
>>  	return x;
>>  }
>> =20
>> +static inline int prefixcmp(const char *a, const char *b)
>> +{
>> +	return strncmp(a, b, strlen(b));
>> +}
>> +
>>  #endif
>
> Is it just me, or coudln't this be a little more self-documenting.  I
> find it annoying to have to read through a functions implementation t=
o
> figure out what to pass to it.
>
> If a doc comment is too much, just naming the parameters is often
> enough.
>
> +static inline int prefixcmp(const char *s, const char *prefix)

Thanks.  That is much much better.
