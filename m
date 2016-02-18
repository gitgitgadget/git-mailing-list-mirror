From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 2/3] config: add 'type' to config_source struct that identifies config type
Date: Thu, 18 Feb 2016 09:44:30 +0100
Message-ID: <6A1A6964-AA08-40DB-B927-A2EADE2EA703@gmail.com>
References: <1455699468-45443-1-git-send-email-larsxschneider@gmail.com> <1455699468-45443-3-git-send-email-larsxschneider@gmail.com> <xmqqa8mzjh7d.fsf@gitster.mtv.corp.google.com> <xmqqd1rvhvmq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, ramsay@ramsayjones.plus.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 09:44:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWKCV-00072d-N5
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 09:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425600AbcBRIog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 03:44:36 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38699 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424633AbcBRIoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 03:44:34 -0500
Received: by mail-wm0-f50.google.com with SMTP id a4so14276047wme.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 00:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4HbPE99U45yjDPDbrDgaduF68DnMH9e/vQvPMi5wHt0=;
        b=AJDkHgaf+XHm7NdHsU0XKQKEOB5PQ2077gPk85fAMDc9msmbijmuZ0ML3AyPVVLr5J
         Z04fcu5HW4XeIYGCxYuApztNJzu5quIiM45oVb5suAmBzqSoSedxAQrAWVxOWbtmXloG
         a8hGmIKtdLmmayDMD5fcwqYquf2Z8z+s41cVirAy58jgYt7pz+vjfaT0EVFSN5ob2RvN
         edLbaaP08sEBGzr8iFYP8Wx8gHyYFQbq26TnUYERwrQ5cp1iVA/1HB81iyKcCv8Uxlh6
         v6UsD4ImwOEqOxTrUZui3fEwDZ9auRqDFjWLxYPeG4sbZDlCQ0ZsD4IiKew5435i54yx
         Qq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=4HbPE99U45yjDPDbrDgaduF68DnMH9e/vQvPMi5wHt0=;
        b=I73jjqXbWyy2kCgzCcw9VfTv0YlcEk0g9Sjp1YlFQ1AYmHn6AtjvvLJ06W6J3KBf4L
         e/zu5ZKxSpBSr6BuerD5AbmiSjdxQ3g7lv8WEt6207kjBAVt5QjR+4nHJ4XuH/ClvieG
         lMqdDfZWrRebWDFX5d3Qn3kp7/WyWBeIztPPDwAN1iq15vp/xlWndCRs3iTD5pGVg6wO
         RlMLD9CkUpWz7OsjZMSk330o3dMnYjuV079GYpKL67RwevZ/zBQJBj7wQWJ1dYBb1m+O
         YuiY4ZCwNKgJ8EAES88AMYfAPByxn9iScvPcvSZGDIcatELF71skMH/cyuPGXfayJx5n
         9znQ==
X-Gm-Message-State: AG10YOSJPbY+wS6vcFBaJIULkxNgbgofpj4jzWDVkMCZZBG6Uv4eEIN/z6BhUrlKOdcPCA==
X-Received: by 10.194.7.195 with SMTP id l3mr6117152wja.43.1455785072892;
        Thu, 18 Feb 2016 00:44:32 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4227.dip0.t-ipconnect.de. [93.219.66.39])
        by smtp.gmail.com with ESMTPSA id e9sm5405967wja.25.2016.02.18.00.44.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 00:44:32 -0800 (PST)
In-Reply-To: <xmqqd1rvhvmq.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286601>


On 17 Feb 2016, at 22:31, Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> larsxschneider@gmail.com writes:
>> 
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> Use the config type to print more detailed error messages that inform
>>> the user about the origin of a config error (file, stdin, blob).
>> 
>> "type" is too broad a word in the context of configuration file, and
>> does not help readers as a variable or a field name in a structure.
>> You are not talking about "this is a binary typed variable", for
>> example.
>> 
>> If showing the origin is useful to the user, that origin should be
>> called origin, not type, I would think.
> 
> You seem to use in 3/3 "origin type", and I think that is a sensible
> phrasing.  Renaming 'type' to 'origin' in this patch would not be a
> good idea, but renaming it to 'origin_type' would be a great thing
> to do.

OK, I agree. I will wait one more day for other comments and make a
reroll with the change tomorrow.

Thanks,
Lars


> 
> In the context of configuration parsing, 'origin' would be like
> "file called .git/config", "standard input", "command line's 3rd
> argument", etc., i.e. for some origin types, it would consist of
> <origin_type=file, origin_value=.git/config> pair, while some other
> origin type (e.g. "standard input") there is no need for an
> "origin_value" that further qualifies the origin.
> 
> Thanks.
