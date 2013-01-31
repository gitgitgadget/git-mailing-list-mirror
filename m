From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to identify the users?
Date: Thu, 31 Jan 2013 11:40:23 +0530
Message-ID: <510A0ACF.5060501@gmail.com>
References: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com> <1359612481-ner-5936@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Scott Yan <scottyan19@gmail.com>, git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0nMK-0006nz-En
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab3AaGKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:10:31 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:48570 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab3AaGK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:10:29 -0500
Received: by mail-pb0-f50.google.com with SMTP id ro8so1441233pbb.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=W9MHx3UqJOmS2YWmXCP9tn6FiuruM5wrJTlSICozw18=;
        b=nPnptASSNzwfIKnBdVG4+6sR0U5+mvBiA0fRRNloL2J9H3LoKYG3OF5x5OlSBj3KnK
         4pis1t6utlgH0IM4aj39pSPYk6dyGOnrJoVrA6j2LS6Baa1YebISiNbsgZ998ppN8tS8
         s7SaavQJSRibqOosGsFpO2o0MKuLV7QjtTLNlc4JE+wK46AwO2G9UkBQp5cms3glSuLD
         vE82jjPIhCQabLPXYN8W+oRxl4fObMdy/XBrs1RkNUc7UKzyXNXc6MgdVqFca9JzZ8b7
         MhcMIvHpSM5jtX0RxKzYI3TFiH4zmWbjk/K+mHUffWIW4gmqEa1pckbHOtyMBDS9+iFJ
         vzZQ==
X-Received: by 10.66.79.168 with SMTP id k8mr17696931pax.22.1359612628761;
        Wed, 30 Jan 2013 22:10:28 -0800 (PST)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.co.in. [203.200.212.145])
        by mx.google.com with ESMTPS id pw10sm3965210pbb.28.2013.01.30.22.10.26
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 22:10:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <1359612481-ner-5936@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215095>

On 01/31/2013 11:38 AM, Tomas Carnecky wrote:
> On Thu, 31 Jan 2013 13:52:32 +0800, Scott Yan <scottyan19@gmail.com> wrote:
>> Hello everyone:
>>
>> The user info of git client (user name and email) is set by the users
>> themselves, so , how to avoid userA pretend to be userB?
>>
>> Git server could authentication the user, but it do nothing about the
>> user info of commit message.
>>
>> For example:
>> There are 20 people of my team, and everyone can push to the public
>> repository(git server),
>> If I found some backdoor code in my project, and the commit record
>> shows it was committed by userA, so I ask userA: why do you do this?
>> but he told me: no, this is not my code, I have never committed such
>> thing.  ----and yes, everyone could change his user info to userA very
>> easily .
>>
>> so... what should I do to avoid such situations?
> 
> gitolite keeps a log of which SSH user pushed which commits. The smart-http
> backend does the same if you have reflog enabled on the server (see the
> ENVIRONMENT section in man git-http-backend). So unless someone can steal
> userA's credentials (http password, ssh key) you'll be able to detect who it
> really was.

See also my rant on this topic:

https://github.com/sitaramc/gitolite/blob/master/src/VREF/EMAIL-CHECK#L37
