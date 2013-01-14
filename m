From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Mon, 14 Jan 2013 08:41:14 -0800
Message-ID: <20130114164114.GA3121@elie.Belkin>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org>
 <4836187.09xoy3kJnj@blacky>
 <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
 <50F40316.7010308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 17:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tun6W-0002ZU-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 17:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502Ab3ANQlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 11:41:24 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34779 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247Ab3ANQlX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 11:41:23 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so2311730pad.2
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0sO8izBj0BqcRqainhBzmt0EWPzbxuSj++PBKjXFQIA=;
        b=KUKU0K06p42+LxwsK6pqx6V+FoUmCCr6Er6gmB01t7KqmgNesZDaC0Hf6dWexi3TCH
         kSn2E9HLW1kiZdoJyGdtw5b54isyaH+UdFFry59l3dwS+MYbcaqmcB+hFFVlj0bx+e+r
         J8dAgeODgweYZ73ciJG0Z9EdrtkYTpTO317L6oGBvEnWcE4AGr91K+rDEMTSlnBeqcXe
         euPIvx2urrtJQu/1Pbz1rnHpisl7exTWu3syMKUb7GfWWgLnQhp9XQC3HMkf4QpmI/z8
         8g/GrSHARzDQN1WqEJYdnyv1rpxll51Y2arfTQ6os8S9qee+8D32ov9pYfBTLxY02Jcd
         h55Q==
X-Received: by 10.68.244.6 with SMTP id xc6mr257872908pbc.94.1358181682712;
        Mon, 14 Jan 2013 08:41:22 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id o5sm9019917paz.32.2013.01.14.08.41.20
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 08:41:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50F40316.7010308@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213499>

Michael J Gruber wrote:

> All that "set-url --push --add" does is adding a remote.foo.pushurl
> entry to the config. If there was none, there will be one after that.
>
> If there is no pushurl entry, "push" takes the url entry instead. This
> is the "default URL for push", but not a pushurl entry.

That is how it is implemented, but it is hard for me with a straight
face to say that is what most users expect.

Wouldn't the least confusing thing be to just error out for "set-url
--push --add" when there is no existing pushurl?  That way, the
operator can use plain "set-url --push" to clarify whether whether he
meant to include the pull URLs in the new pushurl set.

My two cents,
Jonathan
