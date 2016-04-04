From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v2 0/7] t5520: tests for --[no-]autostash option
Date: Mon, 4 Apr 2016 22:37:55 +0530
Message-ID: <CA+DCAeQU2eOA7gQ4Q=GTGWeNuAzor0aL4DUFnD+8vYErPc21DA@mail.gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqshz125jr.fsf@anie.imag.fr>
	<xmqqmvp95mxl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:08:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an7z9-0005gz-Gf
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbcDDRIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:08:15 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:34888 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbcDDRH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:07:56 -0400
Received: by mail-qg0-f65.google.com with SMTP id b32so17281827qgf.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BHs1iMPMG+dkKzdghZxzG2ZLRwGlHvBHZ1Qj2qotft0=;
        b=HiAqHtFykwhLW2j/Q4j+IOHXpJRdvDgzD3a5tx3GeZdRfaFXLqGP5VaLntgOR70agT
         gX1qfyfGRqSwZfeQrH2PjHIDGD8L2X57YmYeuftxw+Sr0ckxAlPOVGzD7j7vJ2dfS2az
         N+w6SoD0Zk8lXC1Ns3NWY1N7RalsQX8CF9Pe7XyxuC2kUbaaVldaXqKEHHgrljYjiujz
         0kYPOV6etESVAakMeiAYQg0AZwsfAHks+jH8+CugVLcF7gemMqMkslSe03gFbd4NDEX7
         S+1FjJVAWhYG6+DtV2gvRwyFxb8MN0Q3klOwlhYIrZqF08+2bu2DCXp7AKcj068F0zkX
         S1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BHs1iMPMG+dkKzdghZxzG2ZLRwGlHvBHZ1Qj2qotft0=;
        b=e/shFfRjiCLsgUfcqjY+eP6P4us+3Olr1vUoTiAlQtNUBTUx/tgNIOOcetMuL4yQqZ
         OJfZaifVNiUEPOqp9et7xMI5Ar19P0tGa9Dxc5i1afEl7BdJ+tu/mn1Nu/k0pkWvP0u+
         L5/QRzYTPtwr+rMLlEBzRPuEPHvgXtVWZF2tQFh8wFTsKWY/fVW3fapZgH4b5bngUz/o
         f/Oz4y2snP8rJSKbdEt3jsvENzKnp4/5a23u/oqFFG+/pra0v5LVXypzOvVIzcLXTs7k
         rt7dOXpExI524or8XGionYQqYpbFkDdkXqctIIiPfAKffswEbHqU8B2emv0ov3CVNxfO
         J3qQ==
X-Gm-Message-State: AD7BkJJDrc10OosLJfk+kjlcWWQROz4U8RdYjZFEN1lxEuqostyjWgZ5dGrvTbaGIlnurDcQC4rCL+4iGJvXSg==
X-Received: by 10.140.157.7 with SMTP id d7mr18261484qhd.17.1459789675575;
 Mon, 04 Apr 2016 10:07:55 -0700 (PDT)
Received: by 10.55.10.135 with HTTP; Mon, 4 Apr 2016 10:07:55 -0700 (PDT)
In-Reply-To: <xmqqmvp95mxl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290701>

On Mon, Apr 4, 2016 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Mehul Jain <mehul.jain2029@gmail.com> writes:
>>
>>> -test_rebase_autostash () {
>>> +test_pull_autostash () {
>>>      git reset --hard before-rebase &&
>>>      echo dirty >new_file &&
>>>      git add new_file &&
>>> -    git pull --rebase --autostash . copy &&
>>> +    git pull $@ . copy &&
>>
>> Not strictly needed here, but I'd write "$@" (with the double-quotes)
>> which is the robust way to say "transmit all my arguments without
>> whitespace interpretation".
>
> Yes, these should be "$@" (with the double-quotes).

I will do a re-roll then.

Thanks,
Mehul
