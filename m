From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] t1402: check to delete broken refs
Date: Tue, 25 Nov 2014 16:42:20 -0800
Message-ID: <CAGZ79kao0CpeidBzVL4O-4jfNd7nGbOJwtvsJCEgOjb370z8uw@mail.gmail.com>
References: <1416956166-20341-1-git-send-email-sbeller@google.com>
	<20141126003506.GA19239@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 01:42:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtQgb-0006J8-Ga
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 01:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbaKZAmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 19:42:22 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36442 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbaKZAmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 19:42:21 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so6449984iga.9
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K1N4NEcyPprIdHTWUScuoQUjY7LO2lPw4WNXVSTAHO4=;
        b=AlIXcuAUH6qoJ6t4WdkA/eO//H0QhF3I0Kw90IWAAknjwpcITGov/mm4J2Y0qPC3j9
         ROFLFE2nvrfjESWqShte8TDnjrSLLzMx8V6NbdaYaFnKLfsFERpv5GkAPJicZTsLtPsz
         ar/BuuR/ave6jAjerahIhJWVvYiwdXA5pG0wosnRdkb83QBZOPv5JgfoF2k1W6tRH72L
         j+zOCiyZP/+7qwOtp5lWk6SHTSVc2+SKhOSa652MkJiW8kgqtFsU3ZuqbqpmFuxYb3oC
         yS92GApKVnPcdUW8sqBEQr7dwyr3B1fQR30zRHSBnaOpbMSdtlCmENfqHhBvOPNK/iHu
         VvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K1N4NEcyPprIdHTWUScuoQUjY7LO2lPw4WNXVSTAHO4=;
        b=TYwG3zIS+PZENhWyTbg8Mmw7nSynibgSNfqAiQ15moyqUwEt4jTzZ5nsAiQx/CZt8z
         bQ72HSNvxvVMTalo6mMKz3ZNhbapiBNFL/CNOkgXIHhdPSP87dZTPkYJGTcHsjWtdRSC
         XaqvYfY+JIo7UvQQdDateAnzh+CGnMBEiewhY9iNG8qccIn79v7ClT44QvaRltuZI9wU
         dBAB3qSzkliL9IvFPE5SM37j68+EyQ33CcPxD8QcpZzUj+e8emJGxWc4GDH9z3DzU+Dp
         HXVC10Hswy9bESEw4l5erKiKR9pClqc3ew1NWB6TpzQL8tlvuHdcRZtrDFI7JVwoBNGH
         qrug==
X-Gm-Message-State: ALoCoQldoKa3uClu83mlZ6sqLcIWVo0mVENeB0hsyMeEj1DTFJaineN7QeqQjQQlqQdYLOcdGDQU
X-Received: by 10.107.7.91 with SMTP id 88mr25826454ioh.70.1416962540681; Tue,
 25 Nov 2014 16:42:20 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Tue, 25 Nov 2014 16:42:20 -0800 (PST)
In-Reply-To: <20141126003506.GA19239@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260255>

On Tue, Nov 25, 2014 at 4:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> This was also part of the ongoing series from Ronnie.
>> But I think the patch in this form is rather independant,
>> documenting the current state of "git branch -d", so it's
>> fine to have it in now.
>
> Is there a patch adding the feature this patch describes that this
> could be squashed into?

I have extracted it actually from a patch, which it was part of.
I want to send as much uncontroversial stuff to the list, before I try another
round of the larger reflog transactions series.

For now this test just documents, how git branch is behaving differently
from its desired  behavior. So it is also a subtle proposal how the desired
behavior should look like. (Deleting broken branches without further
questioning, flags or other magic incantations)


>
>>  t/t1402-check-ref-format.sh | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>
> This doesn't have anything to do with check-ref-format --- it's about
> how easy it is to recover from a repository with corrupt files in it.
> Would it fit somewhere like t3200-branch.sh?

I'll look into placing this test in a more appropriate spot.
