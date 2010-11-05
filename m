From: Christian Couder <christian.couder@gmail.com>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a
 file or directory
Date: Fri, 5 Nov 2010 09:34:46 +0100
Message-ID: <AANLkTi=aGHvQhG3bOcqS-U04UjFeB7PVw9GTsSuf3UFA@mail.gmail.com>
References: <20101104125641.2ef90853@cortex>
	<AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
	<20101104151637.076ac021@cortex>
	<AANLkTi=cydcB2yRpWbSH7qZGHdjXEPjNvfBCJny7JcwJ@mail.gmail.com>
	<20101104181537.5f866d42@cortex>
	<AANLkTimDWM69qvY5wdyzFu=g6htg12-K542PRR4bdDYq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Camille Moncelier <moncelier@devlife.org>,
	Nick <oinksocket@letterboxes.org>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 09:34:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEHl7-0002kR-4N
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 09:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0KEIet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 04:34:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59306 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0KEIer convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 04:34:47 -0400
Received: by wwb39 with SMTP id 39so1138685wwb.1
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vI+IpC7TpeQnBP1QWXU7jP5jbG0zOzbQ/LEzfkAvbAI=;
        b=EWwjCW5FnIdnf+DvJjoEdT5j8jmzYiCwxPevMHkZlCLWhztmzSYyMTW8LE5rI5V70+
         JNyfn2IzdrBh7bNLaT4KXa+h/036Kw3MgdahnwWffTvQ5K4JPbLVmv2YhpInvcU87Ol1
         G2gcjz20UBElZFMqoDMmXSsdJ7p3tz9E+KNG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aJ9k2v9YO0aCiJCYafH1ecVSwacQXyYuj787+IyIRFcK9EC5cNNKuw3tnIJ15Fsi1v
         wXLOVdT3cTII6TxIwTH0qhVyZIyzTQyEySXQHsoi9rXyhHK61VhILxpOglPXWi9uUa7B
         8xXthvGcLMHR6fO4TeRqk442D8/zBpET8L5Hw=
Received: by 10.216.184.11 with SMTP id r11mr1813541wem.8.1288946086261; Fri,
 05 Nov 2010 01:34:46 -0700 (PDT)
Received: by 10.216.26.208 with HTTP; Fri, 5 Nov 2010 01:34:46 -0700 (PDT)
In-Reply-To: <AANLkTimDWM69qvY5wdyzFu=g6htg12-K542PRR4bdDYq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160804>

On Fri, Nov 5, 2010 at 5:54 AM, Elijah Newren <newren@gmail.com> wrote:
> Hi,
>
> Sorry, I've been missing in action for about a month, but I'll have
> some time this weekend to catch back up on git stuff...
>
> On Thu, Nov 4, 2010 at 11:15 AM, Camille Moncelier
> <moncelier@devlife.org> wrote:
>> On Thu, 4 Nov 2010 18:03:39 +0100
>> Christian Couder <christian.couder@gmail.com> wrote:
>>> Elijah Newren sent a patch series around September the 20th but I d=
id
>>> not check to see if this series was merged into pu, next or master.
>>> And I don't know if it fixes your problem.
>>> Could you have a look?
>> I think I already took a look last week, and I think they were merge=
d
>> in 1.7.1 or 1.7.2 although I'm not sure. I'll take another look. Thi=
s
>> evening or maybe tomorrow.

Great!

> The patch series I posted in late September post-dates the related
> series of mine that were merged in 1.7.3.
>
> I'd also be happy to take a look and see if my newer merge-recursive
> series fixes your case (or whether one of my other improvements to
> that series since my September posting does). =A0If not, I'll track i=
t
> down and fix it and add that fix to the series.

Great!

Thanks both,
Christian.
