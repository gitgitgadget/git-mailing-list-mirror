From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Wed, 3 Jul 2013 11:46:50 +0200
Message-ID: <CAETqRCjPkjZiKDmRc8TP-kZXOJwKn-_X2Bvnuqp=fJKRcwtuEw@mail.gmail.com>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
	<7vk3l8in2c.fsf@alter.siamese.dyndns.org>
	<CAETqRChiW49TwrZiZoi6vCwe9yOjurn97QpPEcJ2pb6fvp3ZBQ@mail.gmail.com>
	<7vhagcgh0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 11:46:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJeJ-0004ai-G7
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 11:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab3GCJqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 05:46:52 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37230 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab3GCJqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 05:46:51 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so14583564iec.22
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=aL3mQ7MwK98E8B6F03F0EWlOGrd12B375rHcKjVahpU=;
        b=c5N4FMfMzxq5Zpr3kw3zuYZql2tIZbqr4tQFrlnAGf4gEGr2qd1lyeKqTRW5jMuul9
         lnz5JegPv8BWCQ2t2a9bzyx8tRTxntlzshswCYv1AmFeFDsaxC1j9lSJMSL6bFy8kilT
         iQ6XdILFSC/YSucRJCfm2RJbEC7j4k6/nRrSbFY2wkc4zazJn9mX18Pjx2VMYbPwARjc
         feueC7QXZGJysx79+J0KhJtLzBOXuu7jTG3RCQx72eBvdkE5S1x6cu2+KiHfT3tmulTm
         m8rfhOAHhOLpp+jQWcbMNjrKb3qzm20veTz4SuXsbIWBDQcW7dp+lHbt9zsemvTQQ5wx
         adeQ==
X-Received: by 10.50.12.5 with SMTP id u5mr23681303igb.58.1372844810552; Wed,
 03 Jul 2013 02:46:50 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Wed, 3 Jul 2013 02:46:50 -0700 (PDT)
In-Reply-To: <7vhagcgh0e.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 6VU3AC1wwkeUosBbXlSzhXxnSuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229478>

>> For now, GITPERLLIB is only used in that kind of statements:
>> use lib (split(/:/, $ENV{GITPERLLIB} || ... ));
>>
>> The trailing ':' does not really matter, split will ignore it.
>
> That may be true with the current use, but "For now" leaves funny
> taste, doesn't it?
definitely. For me, the issue was that we were trading that "funny
taste" for less
readable code in wrap-for-bin.sh but with that default-substitution
construct, it seems
worth it. (a huge if-block seemed even funnier in fact :) )

> It is not too much trouble to fix by writing
>
>   GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'"${GITPERLLIB:+:$GITPERLLIB}"
>
> and we will not have to be worried about future changes breaking
> today's assumption.
That construct is really nice :) did not know there was such a thing
in bash, thanks.
