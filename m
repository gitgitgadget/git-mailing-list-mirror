From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git fetch pack freezes
Date: Wed, 28 Nov 2012 11:22:53 -0800
Message-ID: <CAJo=hJs0dEY1WX4t+R1cz__5TK3Od+wtiRjnHJQxs-m1SU69Lw@mail.gmail.com>
References: <87624pizoe.fsf@googlemail.com> <CAJo=hJvGNUtT+z_E7rSaOr77=7dSo1N+7QiEoHNdEQDV3n7JWw@mail.gmail.com>
 <87obihhc6q.fsf@visionobjects.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Ivan Kanis <ivan.kanis@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:23:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdnEI-00066J-Oc
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 20:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab2K1TXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 14:23:15 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:39798 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab2K1TXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 14:23:14 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so4875902qad.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JO85REROd75lcUNyxJHUpLkh/o/UW901CPXZpBqQIWI=;
        b=F28i1vl7KTfYO3J0HeU6oWjgaqFesBCvj9xg9k6dm/f3oLAKmI5Vc/i+j8/Owrr8yz
         Lvlrx728XljJuRifUf93SanVLTSKu4wPlRNoJSd2jMY1CmFEdJiaH2C/xuI/0L9cB9B2
         kakokPp+GB0/jeQy2H34tbWRtZI1oIHqn8LRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=JO85REROd75lcUNyxJHUpLkh/o/UW901CPXZpBqQIWI=;
        b=VkO+zAqYmQXJynQ9qZDuuJ2jGZ34b/iln5Hek1OYP6zidF6YSSpsYju1BPGDeAKQ1w
         Ic67x+z0LT1DLEhO2us3LdsELRylFdcu3JNyGiCgTE/B8RRz/WLkONV9ZjUfAmGMMAFv
         j9h/BnBTwza+a7/6/m7tu2WpFiKKJ73yWSoaGddenGd/fQRG1hkE/RDBZV5cU9pooKL+
         8pT/iDNh+DJQk2ZucFoKTaqAl0bwgq51ld3WxEsq0BroXq/gLA4yvB0fe0RMPVrZGqfw
         U2/v+1jAmAoVWM0GU1iwsRgNiIZefykrbYnknMgMO39Bvv9WSdk6EyqVzREjyMVcG/sE
         h0Dg==
Received: by 10.224.19.74 with SMTP id z10mr22295045qaa.96.1354130594093; Wed,
 28 Nov 2012 11:23:14 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Wed, 28 Nov 2012 11:22:53 -0800 (PST)
In-Reply-To: <87obihhc6q.fsf@visionobjects.com>
X-Gm-Message-State: ALoCoQnHdbxn7OUIRr+0rOtDbVLzgZC8yiYMsTNut5N1u4fogpGFnBRHS7QmeFKZIG56g5k8OZvV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210762>

On Wed, Nov 28, 2012 at 9:25 AM, Ivan Kanis <ivan.kanis@googlemail.com> wrote:
> Shawn Pearce <spearce@spearce.org> wrote:
>
>> On Wed, Nov 28, 2012 at 6:12 AM, Ivan Kanis <ivan.kanis@googlemail.com> wrote:
>>>
>>> On the server we are seeing the following error message:
>>
>> Upgrade your server.
>
> OK we'll look into it. I have a question: will a 1.8 server still serve
> 1.7 git client?

Yes.

>> So the stack frames are correct. Its just a problem that the parent
>> didn't identify the server crashing and closing its side of the pipe
>> on stdin to force it to EOF to prevent the child from getting hung
>> here in a read.
>
> It sounds like a bug on the client, doesn't it?

Yes.
