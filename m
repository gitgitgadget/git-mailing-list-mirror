From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Wed, 10 Oct 2012 20:35:26 +0200
Message-ID: <CA+EOSB=NQTsSCs-EJF80h2L+xMULcu_HbaW+mc=yr-3u2hEKbQ@mail.gmail.com>
References: <50706B54.8090004@ramsay1.demon.co.uk>
	<7vbogfquc8.fsf@alter.siamese.dyndns.org>
	<5075B47C.6030607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 20:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM188-0004I7-Au
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 20:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab2JJSf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 14:35:29 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:60725 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab2JJSf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 14:35:27 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so598707iag.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=64UAFa2lN5dSYAcb9JXLZMD97RlyYN4T3fjXSPGq9kg=;
        b=O0mfFHCMNfywUyo/yA/jiJhcSoKRWys1Wqe1jd8em5v292flacG7xwORTgsBF4/zEU
         7WtrFQOew6x8MuaoOPhCZYwfmisDyhJ6KLuwoqlpmvhF/BnFeebouWSFxTIu2ThBBG9A
         HzOd9a7o9ffk6C7rUcN3bgmeBUur89yqSyI5Ce7J9CXq5jivp0eRXcQttxo+n3pbwRRm
         BsGQsLN/a47xOYJClWvn2TFL9IJphPnzR4xAdmpv2XLYu7PJMNBFWwviOwprpQrAuBiX
         BvUJp4wQexlRE2+xf2O4HtHuelUPE6JeLY/dNE45kcc1DlzhWBA1/Q5AvCeZDIfxUC2k
         WSyQ==
Received: by 10.50.51.231 with SMTP id n7mr6310593igo.34.1349894127004; Wed,
 10 Oct 2012 11:35:27 -0700 (PDT)
Received: by 10.64.58.135 with HTTP; Wed, 10 Oct 2012 11:35:26 -0700 (PDT)
In-Reply-To: <5075B47C.6030607@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207423>

Hemm, too old release distro , no ? 4-5 year ago. It is time to
upgrade to something more recent , 5.7 5.8 . Rhel5.3 is not a good
distro for a developer isn't it ?

2012/10/10, Ramsay Jones <ramsay@ramsay1.demon.co.uk>:
> Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> The malloc checks can be disabled using the TEST_NO_MALLOC_CHECK
>>> variable, either from the environment or command line of an
>>> 'make test' invocation. In order to allow the malloc checks to be
>>> disabled from the 'config.mak' file, we add TEST_NO_MALLOC_CHECK
>>> to the environment using an export directive.
>>
>> We would want to encourage people to test with cheap but effective
>> checks when available.  I do not see "malloc: using debugging hooks"
>> message anywhere when I run tests, but if you do, I'd rather see us
>> check if we can tell glibc to stop doing so first without disabling
>> the whole test.  Your patch feels like the first step to a slipperly
>> slope whose destination would make us say "we get too many messages
>> so let's do nothing in "make test" with this configuration." when
>> taken to the extreme, and obviously we would not want to go there
>> ;-).
>
> [sorry for the late reply, I've been away ...]
>
> Yes, but ... I really don't see that this patch would encourage anyone
> to skip the malloc checks, who wasn't going to anyway! I didn't notice
> much of an increase in the running time of the tests, so that wouldn't
> discourage me. This idiotic message spewage is a different issue.
> (the complete loss of terminal scroll-back is particularly annoying)
>
> I had intended to run the tests with malloc checks enabled before
> submitting patches, testing -rc* builds etc., but have them disabled
> for day-to-day programming.
>
>> Besides, doesn't a simple instruction to export TEST_NO_MALLOC_CHECK
>> to your environment before running "make test" suffice?
>
> Yes, so I can simply disable the malloc checks in my ~/.bashrc file.
> However, it would be disappointing to have my config tweeks in two
> places ... :(
>
> I guess I can live with it ...
>
> ATB,
> Ramsay Jones
>
>
>
>

-- 
Inviato dal mio dispositivo mobile
