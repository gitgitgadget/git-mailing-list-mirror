From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 1/3 v4] Add a macro DIFF_QUEUE_CLEAR.
Date: Mon, 2 Aug 2010 23:40:51 +0800
Message-ID: <AANLkTinZGWmA=9UZ6AiojtT861uM_Q4FXVK5DRxFyx4g@mail.gmail.com>
References: <1273207949-18500-1-git-send-email-struggleyb.nku@gmail.com>
	<1273207949-18500-2-git-send-email-struggleyb.nku@gmail.com>
	<20100802124729.GK12084MdfPADPa@purples>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Aug 02 17:40:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofx8N-0004Bn-4W
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 17:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab0HBPkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 11:40:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64832 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab0HBPkw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 11:40:52 -0400
Received: by qwh6 with SMTP id 6so1590474qwh.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=okt49Ru0jjTTStrJXPVXr0lW8CxYrIx3HdUkMaZIq24=;
        b=QCOa253op9XV57AodleSjxPzuYEx4wPq+S5n6Phw50hcbv7Fpi0ptEIKCa6ABM/8We
         g4x8cukcwYSA7XJobhIklnga2RL+d+EG2LTGkvYd8j7Arl5odXGWvlJLWzsmJAFAeJ4K
         jKQHJalwwX0NMxZd95Aa+cnYPmkZhjPdR6jh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mqtwRU1ax2jOR+jd+4DwnP1DiEy8gZRs2UjGdoS96QkDHXV5fbmiCqn9C9d4ELqcPT
         RW2WXWfD7TNkT8/ZNVX9fuZpU3/84lrR3PcqkD2vjT02zHuJkQ/K1LkBgStyxcS/9TIe
         ANFJzL0/KKeOBi2fgvQIju9FeZI/4KMjc0UuA=
Received: by 10.229.2.19 with SMTP id 19mr209430qch.283.1280763651805; Mon, 02 
	Aug 2010 08:40:51 -0700 (PDT)
Received: by 10.229.215.131 with HTTP; Mon, 2 Aug 2010 08:40:51 -0700 (PDT)
In-Reply-To: <20100802124729.GK12084MdfPADPa@purples>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152415>

Hi Sven,
On Mon, Aug 2, 2010 at 8:47 PM, Sven Verdoolaege <skimo@kotnet.org> wro=
te:
> On Thu, May 06, 2010 at 09:52:27PM -0700, Bo Yang wrote:
>> Refactor the diff_queue_struct code, this macro help
>> to reset the structure.
>>
> [..]
>>
>> diff --git a/diff.c b/diff.c
>> index e40c127..4a350e3 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2540,6 +2540,7 @@ static void run_checkdiff(struct diff_filepair=
 *p, struct diff_options *o)
>> =A0void diff_setup(struct diff_options *options)
>> =A0{
>> =A0 =A0 =A0 memset(options, 0, sizeof(*options));
>> + =A0 =A0 memset(&diff_queued_diff, 0, sizeof(diff_queued_diff));
>>

Sorry about the broken code and the bad commit message...

This line is used to clear the global queue structure and make it
usable in next round of diff. I am wondering how the submodule part
use the diff API to cause such an issue. :)

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
