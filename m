From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH 1/5] General configuration portability (Resend)
Date: Thu, 11 Mar 2010 17:48:02 -0600
Message-ID: <rNXeyNyiwlXO9LSfnspDn4Vg_2gHAf4iTHy4MhrWQfGWxJqvzUQAVQ@cipher.nrlssc.navy.mil>
References: <20100311162750.GA7877@thor.il.thewrittenword.com> <alpine.DEB.1.00.1003111750130.3748@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 12 00:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nps7I-0006wa-My
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 00:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab0CKXsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 18:48:31 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41036 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab0CKXsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 18:48:30 -0500
Received: by mail.nrlssc.navy.mil id o2BNm3RK016270; Thu, 11 Mar 2010 17:48:03 -0600
In-Reply-To: <alpine.DEB.1.00.1003111750130.3748@intel-tinevez-2-302>
X-OriginalArrivalTime: 11 Mar 2010 23:48:03.0115 (UTC) FILETIME=[4A0C87B0:01CAC175]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142007>

On 03/11/2010 10:51 AM, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 11 Mar 2010, Gary V. Vaughan wrote:
> 
>> Resending some patches that didn't make it, in the correct format
>> and taking into account the feedback I already had on one of the
>> later patches...
>>
>> This patch is in part to deal with peculiarities of our build
>> environment (software packages are installed in their own directory
>> tree, for example, and oftentimes we need to set additional -I options
>> in CPPFLAGS, or -L options in LDFLAGS, among others).
>>
>> However this is also where we put configuration changes to add
>> additional tests, or fix Makefile problems so that everything builds
>> on all of our supported architectures.  Probably, much of this patch
>> is useful upstream.
>> ---
>>  Makefile             |   50 +++++++++++++++++++++++++++++++++++++++---------
>>  aclocal.m4           |   41 ++++++++++++++++++++++++++++++++++++++++
>>  config.mak.in        |   10 ++++++++-
>>  configure.ac         |   51 ++++++++++++++++++++++++++++++++++++++++++-------
>>  git-compat-util.h    |    8 +++++-
>>  perl/Makefile        |    3 +-
>>  perl/Makefile.PL     |    2 +-
>>  t/t7610-mergetool.sh |   25 +++++++++++++----------
>>  8 files changed, 156 insertions(+), 34 deletions(-)
>>  create mode 100644 aclocal.m4
> 
> Whoa.
> 
> Pretty large patch, no? And looking at things like this:
> 
>> diff --git a/Makefile b/Makefile
>> index 8fdc421..6058805 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -243,7 +243,7 @@ endif
>>  
>>  CFLAGS = -g -O2 -Wall
>>  LDFLAGS =
>> -ALL_CFLAGS = $(CFLAGS)
>> +ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
> 
> It seems to me that this wants to be a relatively large patch series of 
> well-contained, easy-to-review, tiny patches.
> 
> Am I correct?

Yes, please.

-brandon
