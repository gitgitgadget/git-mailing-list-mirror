From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] MSVC: vsnprintf in Visual Studio 2015 doesn't need
 SNPRINTF_SIZE_CORR any more
Date: Wed, 30 Mar 2016 09:57:27 +0200
Message-ID: <CAHGBnuOu9BMfDjmozMHSGKCaA5sYYHYmPupL2-51has4rv-MqA@mail.gmail.com>
References: <56FAAC78.2040304@cs-ware.de>
	<CAHGBnuP1Y1F-CrQJx9zNKSv1KP7gH86WSKo7tbmcYT3Vf2cQ_g@mail.gmail.com>
	<56FAD3DD.4060009@cs-ware.de>
	<CAHGBnuNkuiyk1uvJqT1_1UWOhpVTg+TxJ2QvepuMBpvOD8AyFw@mail.gmail.com>
	<alpine.DEB.2.20.1603300946410.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sven Strickroth <sven@cs-ware.de>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, blees@dcon.de
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 30 09:57:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alB0X-0005Jp-VK
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 09:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbcC3H5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 03:57:30 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33644 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbcC3H52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 03:57:28 -0400
Received: by mail-vk0-f65.google.com with SMTP id a62so5567750vkh.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=clUSNOpGmNFQaj1hWJ36jj1xf7D25BQitU5LS7VGD1M=;
        b=YRPp03CoucCXFQ++WJZOu4zJyHwMQxuAQ/tdMqsyY8WzWK1d5n+/NaGG6zpvXp+kw1
         vQ8UinsiesZPjSf2TDLRoPl3AWnBxzbGT4/zEUYyBi11kVNtyutPwLCgGbRiWa7yVvOu
         VUHfxDU3vWPMvlW1JPow9QRirkPEByYf567Rn+eDL1XV1rYRn+F/y9G2GRSg9PfKBXT7
         6/DzY/KHF/BT3SWsYItB+KagRD/G1tCHaAO5bJaRd9RYjmn6vKceViO1BBkvy2VcWbdO
         96zD4ziLIrbmU14bQYD+Oip0KfU1Ujy2RUdcHieZitvbfzUj5OY9E/cLvto+1xuk+C4o
         K7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=clUSNOpGmNFQaj1hWJ36jj1xf7D25BQitU5LS7VGD1M=;
        b=JcS4D+IUIjvWpKdhlGld2umKNwVcrq8e8fjXEE+McJWb3EAvAiUV2cq50arTPoKfma
         iFp6c2KKiJ0j116pHeUfNUAcCycitjU5CuExx1Q9CsXTevkzlHsWXa36DYWIiuQvOmc2
         Hz0kyTsvrehz1wyga/MrPE2Wz9tPoWezAnflWat0bZZ2bvpnUJjvRMqc37IAAwr/Ndn0
         V5iAGmGcalzLBwXNDUlTCeo07PGOeT7m/MT2mEGp04FFABfo0GCdtYKmvbWimuO1CnUP
         vko5beRLnCJBC7yhdYigtqcwfufCItfE/DkjJceeyIf+C4Foab8IwPwhvatCkbnC7nyF
         y3/A==
X-Gm-Message-State: AD7BkJKtSCjYTAq1eICsKY07fb56USV121yICe+DQY8q+AsxKSO9TrrqAaoTTs/YWccw5hOax94b8ARWQtmxDg==
X-Received: by 10.159.36.39 with SMTP id 36mr3915444uaq.16.1459324647173; Wed,
 30 Mar 2016 00:57:27 -0700 (PDT)
Received: by 10.176.68.6 with HTTP; Wed, 30 Mar 2016 00:57:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603300946410.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290276>

On Wed, Mar 30, 2016 at 9:49 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> >  #ifndef SNPRINTF_SIZE_CORR
>> > -#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
>> > +#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4) && (!defined(_MSC_VER) || _MSC_VER < 1900)
>> >  #define SNPRINTF_SIZE_CORR 1
>> >  #else
>> >  #define SNPRINTF_SIZE_CORR 0
>>
>> I wonder if the logic is (and was) sensible here. We assume that every
>> non-__GNUC__ and non-_MSC_VER compiler on Windows requires the
>> correction. Wouldn't it make sense to not assume requiring the
>> correction unless we know the compiler has this bug? That is,
>> shouldn't this better say
>>
>> #if defined(WIN32) && (defined(__GNUC__) && __GNUC__ < 4) ||
>> (defined(_MSC_VER) && _MSC_VER < 1900))
>> #define SNPRINTF_SIZE_CORR 1
>> #else
>> #define SNPRINTF_SIZE_CORR 0
>
> Since the standard on Windows always was MS Visual C, it should be assumed
> that compilers *other* than GCC followed Visual C's lead.
>
> Of course, evidence speaks louder than assumptions.
>
> Therefore I would prefer to keep the current version, at least until we
> encounter a case where it is incorrect.

Fine with me. It's probably better not to change the logic as we
wouldn't know whether this would break things for some exotic compiler
currently in use to compile Git.

Also ACK from my side on the path then.

-- 
Sebastian Schuberth
