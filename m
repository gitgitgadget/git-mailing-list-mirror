From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Mon, 8 Feb 2016 12:22:01 +0100
Message-ID: <CAHGBnuOcWDhxn+poXhxasFW3gSon7fv8sugZqPjGZFMxNyf7Ng@mail.gmail.com>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
	<56B483C0.6070906@gmail.com>
	<20160205112240.GA18581@sigill.intra.peff.net>
	<DF57DD4F-630F-421D-A379-0A451F6509DF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 12:22:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSjtQ-0002l5-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 12:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbcBHLWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 06:22:04 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35000 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcBHLWC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 06:22:02 -0500
Received: by mail-vk0-f54.google.com with SMTP id e6so92784917vkh.2
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 03:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7Q7lQoXwxLMqL1maQ+DyBujY+Gc0ZNAyeVJ0zfBBwH0=;
        b=JhpAx4K35wYnKD7SFO8qnEoXP3+uAtPpY4OtwLLk8mfGCEA2WvOmD1FHTweHxxzNRY
         q19HLe0C/ZRiwrryzqOfDQooZ4y32tMxlSs6aTqsfZWp47VFVEHpaSogxQDDQVQ39X3z
         QW29bPOVzko4K3hpiHFxqcFvmvghVPsLf0JE2jjE4Xw6nY1AdswKsReI1+fe2Xg6GmOd
         WL8TgXWpkP7n+w9Z0rnhal5yynCO5eotMU/nTWQkYKkEjuJy/VlB0eYi4NoMqN02naOG
         fNjwYHT90GVmlWInN9mQG8xcelggcTGdPIGJyYNr902TVGkRLVHIamI1yvO2rx2L9BLS
         0XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7Q7lQoXwxLMqL1maQ+DyBujY+Gc0ZNAyeVJ0zfBBwH0=;
        b=CDwQilVTdDxxpxMuRiQcfqszCwQXlCN7cvPAN6rz64Ia5Ep5huekjwbIgFvlGeT3Z5
         FjRV8k/7OF9PSL0v6V153x0NMjcJbs6dJUcSrNGPaRIXAFCgo66DRpnJwKvSiOq2WSZf
         HdSUEgDHqOcuEBMHnAtHthU4HfW9zIBV4FPmvOwDq09e5KzN6yr+kfIL8h/KvAKx8PXI
         EYM2Ga+mb7JwiJmjT8uB9/dmceyalo84WPUemPl6sZCrg9lHD1hk1KD0n8NGcb4GMEY7
         q7DT6ubxNXSVes+zryO9wGKgN5kq3bK48Azu55ePUP43TPNmoH8sKfnE65smFfhPIspN
         sdLQ==
X-Gm-Message-State: AG10YOSfWHc/9PwHv47hwxqB5LUd2mdSUI7hm+GAx3iu+dBK2VZ9FSZBmQw9qzOo7rqYfk1FA5ZMTd0OLnVltA==
X-Received: by 10.31.178.134 with SMTP id b128mr17942322vkf.112.1454930521381;
 Mon, 08 Feb 2016 03:22:01 -0800 (PST)
Received: by 10.176.68.6 with HTTP; Mon, 8 Feb 2016 03:22:01 -0800 (PST)
In-Reply-To: <DF57DD4F-630F-421D-A379-0A451F6509DF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285755>

On Sun, Feb 7, 2016 at 8:28 PM, Lars Schneider <larsxschneider@gmail.com> wrote:

>>> However, the naming of the '--sources' option sounds a bit misleading to me.
>>> It has nothing to do with source code. So maybe better name it '--origin',
>>> or even more verbose '--show-origin' or '--show-filename'?
>>
>> I think he inherited the "--sources" name from me. :) I agree it could
>> be better. I think "--show-filename" is not right as there are
>> non-filename cases.  Just "--origin" sounds funny to me, perhaps because
>> of git's normal use of the word "origin".
>>
>> I like "--show-origin" the best of the ones suggested.
>
> I understand your reasoning and I agree that "--show-origin" is better than
> "--sources". However, I think just the word "origin" could be misleading in
> this context because people associate it with Git remotes. How about
> "--show-config-origin" then? Or would that be too verbose?

Well, "origin" just happens to be the name of the default remote.
AFAIK all options that deal with remotes have "remote" and not
"origin" in their name, so I think the risk of confusion is rather
low. But I'd be fine with "--show-config-origin", too. Although it's
verbose, it's probably not used very often, so personally I could live
with typing the extra character. Esp. if you add Bash completion
support for it :-)

-- 
Sebastian Schuberth
