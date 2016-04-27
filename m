From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/15] string_list: add string_list_duplicate
Date: Wed, 27 Apr 2016 14:17:34 -0700
Message-ID: <CAGZ79kagX5TJU_mbjpo4PKJDoc1wh24DhyS814Kkq76EU9aykA@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-2-git-send-email-sbeller@google.com>
	<xmqqh9eoc7zc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbWMN3YG5Jtz8i8Y9A3id8bX-YxSWp19+yGAdzMX_wKKA@mail.gmail.com>
	<xmqqzise7o4l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:17:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWq4-0000Pn-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbcD0VRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 17:17:36 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33462 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbcD0VRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 17:17:36 -0400
Received: by mail-ig0-f173.google.com with SMTP id c3so1073105igl.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qJJrT6c5lqhlZ2qXm1fMTwlqs9g+LKR3cDqIv6dbxBk=;
        b=TTDQBsX/b4d0uy2MCLeVkFyvu3OV1EwKNIcXwQSHdBs16WF1pikgMpDfoDVw5pm5rD
         kL+FUsuEveJQIFsXR+YE69YTOORhXoiFzupT869taj10y/1THVRr5xTPaZyMvEQVzrIi
         c9gjpt5PbIuVzwk0DkMnz4H5KXwVWOBdlnCoQByBMiB4X70hIgFF951TZshX6C8THnAC
         MWFwFrRq2L5relmYHgTDWyEQS0lkeniJULRg2kRAhkNVskID7UuQGFrJdpaaTtDtMBQK
         tCs0db40rrFxhz5hF0rLRautT7wbecwl1wcFkSFaBoDeumF9UYDcTpioRsCfQmSkfT48
         SS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qJJrT6c5lqhlZ2qXm1fMTwlqs9g+LKR3cDqIv6dbxBk=;
        b=jTqhXSRhlj9KWrqWOmNq8KrnhNGMCA4hbO+E96D9457emO9cW9ZVQrlP7GzOViSRXW
         WPGYLYqzS3jauFZ8fs5nBMJIlONqnxgtAq/HPxN0AKcczqZgM6rPlpcPokbU6XUlQPGi
         2gyEQHE9kF0CpMlQHLSUFFJrK1IMMGc55sgNESCTJMARwM9SdBBGSLgd7a9flBmMFs9+
         t8auJrvuhkwU28v1A0pxPtMvyvdUKSQYxM5rDQ8CA+Ecty/qomm0v1ccoYN+Hlt9AYMU
         Kq2s+iqQW2GYiG6unf0VZMO0szJPi3fPuNJMFkCRxPYXWojU2cRTlEcMx9Mc/XoeKRJB
         Fg+A==
X-Gm-Message-State: AOPr4FWVA+nKB56A7Z09jOADnaYGzkMMMlspuEV1yRMWPfQt6JppZbWJw4TpIF5KA/PsLhvoK9PWiZ6cKfQLv7Yb
X-Received: by 10.50.102.207 with SMTP id fq15mr24464253igb.94.1461791855066;
 Wed, 27 Apr 2016 14:17:35 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 27 Apr 2016 14:17:34 -0700 (PDT)
In-Reply-To: <xmqqzise7o4l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292828>

On Wed, Apr 27, 2016 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When not duplicating git_config_get_value_multi("submodule.defaultGroup");
>> I run into
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> ...
>> So the string list seems to be corrupted here.
>> Someone stomping over our memory? How long is the result
>> of git_config_get_value_multi deemed to be stable and usable?
>
> That call goes to
>
>     git_config_get_value_multi()
>     -> git_configset_get_value_multi()
>        -> configset_find_element()
>
> the returned value from there would be either NULL or the list of
> values that belong to the config cache layer, i.e. a caller of the
> API can peek but is not allowed to modify it.
>
> So if you are modifying the value you obtain from the API, you must
> make a copy; otherwise you will "stomp over" memory that belongs to
> the config cache layer, not to you.

Yes, we do not modify the string_list (the return of git_config_get_value_multi)

Another way to corrupt it is to change the configuration (e.g. add
things to the config hashmap such that it reallocates and grows).

The problem arises after a call to submodule_from_path(...);
which may change the cache for submodules. I assumed that was
completely different from the regular config cache, but somehow there is
a relation, which I have not tracked down yet.

Thanks,
Stefan
