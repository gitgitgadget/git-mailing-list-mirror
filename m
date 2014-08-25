From: Arjun Sreedharan <arjun024@gmail.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Tue, 26 Aug 2014 01:57:36 +0530
Message-ID: <CAJFMrCGK8uBYYGVHx2GgDEY+6OCS3pT8O8BE7TKpV0v1A0-kGQ@mail.gmail.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
 <20140825133550.GE17288@peff.net> <CAP8UFD2FAfg5GenJXOkOsjU9vmCO3R3Difp6-mrP_cp4zXQENg@mail.gmail.com>
 <20140825150028.GA28176@peff.net> <xmqq8umcmnmo.fsf@gitster.dls.corp.google.com>
 <20140825193519.GH30953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:28:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM0rx-0006z7-FM
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 22:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbaHYU16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 16:27:58 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:51878 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538AbaHYU15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 16:27:57 -0400
Received: by mail-qa0-f42.google.com with SMTP id j15so12934341qaq.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WFvCMD3caoL31hvu45SlCivv/Ric+tUo3/vlqZ6+VFQ=;
        b=CHZLLHSVxhGdQqLd8TdEmtbHIdBMUyUSpcn06456+g86VVxwjfNGi9NFpe/9hRX5An
         dXi4T+MNRg87eyhTePUWlEAgpmiI2sd+ykZ7hM8ByACxQCgCbM/MjibJTyWggkERAxAv
         Ju7I+VU4yaqRqGzYZEY1UutWpwkXXQVmoUZOrtD794ACI1N2CDdgZNxqrSrG3R8L59gG
         I8pFhHJ6sFvbxJGRE8dvOVOcrzr5pAMcDqRLNZ6k7SnKib64C9GvLY22EPe8UqChBDGh
         PyQ3Xa6DX/ov7pqOMod7Y6amdnsYf96d17ZI44lmxce2SSZ0q1XkeqwO+zx/3n3haxmQ
         LoiQ==
X-Received: by 10.140.89.5 with SMTP id u5mr37418131qgd.14.1408998476876; Mon,
 25 Aug 2014 13:27:56 -0700 (PDT)
Received: by 10.140.255.215 with HTTP; Mon, 25 Aug 2014 13:27:36 -0700 (PDT)
In-Reply-To: <20140825193519.GH30953@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255864>

On 26 August 2014 01:05, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 25, 2014 at 11:26:39AM -0700, Junio C Hamano wrote:
>
>> Good digging, and I agree that it should use the FLEX_ARRAY for
>> consistency.
>
> I can produce a patch, but I did not want to steal Arjun's thunder.

Please feel free to do so.

>
> Arjun, did my proposal make sense? Do you want to try implementing that?
>
> -Peff
