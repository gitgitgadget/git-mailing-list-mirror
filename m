From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCH] grep --no-index: allow to grep without git exclusions
Date: Thu, 21 Jul 2011 19:23:25 +0200
Message-ID: <CAKPyHN3dRyrpW_3emC1s8eDWTF_hSGEY9p+Ojio3NzvNP2hOsg@mail.gmail.com>
References: <82218b89c89f733dc0759d648b3a60bca6e20f3e.1311165328.git.bert.wesarg@googlemail.com>
	<7vzkk86577.fsf@alter.siamese.dyndns.org>
	<CAKPyHN2TMu2yO4sZDAqCce9P-5==Z2jKQVoU=zUsmUQJhHoeQg@mail.gmail.com>
	<7v62mv4n93.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 19:23:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjwyB-0001gJ-R5
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 19:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab1GURX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 13:23:27 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60782 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab1GURX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 13:23:26 -0400
Received: by vxh35 with SMTP id 35so1049416vxh.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VGNPA11Zx/eJv43YLrqThHEMlBxEtX2jTFXwFAptMVM=;
        b=gsKy+93TIM9k/k2t+Z6er6nWNLn2yJuTD+RGZZffvbKrFojpVuB8l2NakZPUGtoc5H
         k/hGy1ZHTi5zmGgu/hljZPAfszoO2o/CY/e1B7OSzXrJj/3w6foMMpGcjkwF6YL5seuV
         RaGFGXp3LW5lNTtuEc1Ca0BjbanLOaXiwKBsM=
Received: by 10.52.173.83 with SMTP id bi19mr541720vdc.463.1311269005879; Thu,
 21 Jul 2011 10:23:25 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Thu, 21 Jul 2011 10:23:25 -0700 (PDT)
In-Reply-To: <7v62mv4n93.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177588>

2011/7/21 Junio C Hamano <gitster@pobox.com>:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> It should be. But I think that unveils one of the shortcomings of the
>> (any) option parser: You wont get notified when an option was given,
>> regardless of its value. To handle the above I would have to use
>> OPTION_CALLBACK to set an addition flag exc_given (like it is done in
>> git-ls-files) and test against this.
>
> Prepare a three-value variable, initialized to -1, set it to 0 on --no-foo
> and set it to 1 on --foo. Use the default if the variable is still -1.
>

Thats the 'invent an invalid value'-case I described. Which does not
necessarily exist.

Having the proposed 'given' flag available I would need only one
variable for all the options (these coming from ls-files) to check if
any of them where given, and could decide if the given options would
make sense.

Bert
