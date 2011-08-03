From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v13 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 22:46:54 +1000
Message-ID: <CAH3Anroaq+fH3T3_G1HsS3ecdNdpReaKLC5v=x37rDqSmtghww@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD3XzUjxiz6QQzyTOYzfiWrF4ckiv0h+gvi7YuZkma6yiw@mail.gmail.com>
	<CAH3AnrrkAeN3BgnnFBsbzh=37tC6f6aRACgk94wxW85qFQpfVw@mail.gmail.com>
	<201108030727.04246.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 14:47:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoaqi-0005YK-Kb
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 14:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab1HCMq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 08:46:56 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64480 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab1HCMqz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 08:46:55 -0400
Received: by vxh35 with SMTP id 35so578216vxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 05:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MPBSjN7HWXa/4S9ZDzOGuuLWqjMNxxKLN+kOwAFGUOA=;
        b=bPjgz3z7TiTV27ZcvXOz91hLQcDOAdKQdIrXCPpsny3KSy6IX/dJg7y/YUHdgpTus6
         p2EdEcwzAoixhz94FSOR1HKjZM/XQuHsS1/5/idkIKoHFwv6mNjwhzf3SFooHZ9qzrPg
         TX5H8Iyk1cVQHCtayE/kPCW3TrIFLf7Crz+nk=
Received: by 10.52.28.79 with SMTP id z15mr6862431vdg.365.1312375614749; Wed,
 03 Aug 2011 05:46:54 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Wed, 3 Aug 2011 05:46:54 -0700 (PDT)
In-Reply-To: <201108030727.04246.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178565>

On Wed, Aug 3, 2011 at 3:27 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> On Tuesday 02 August 2011 16:41:13 Jon Seymour wrote:
>> On Tue, Aug 2, 2011 at 10:04 PM, Christian Couder
>>
>> If I was to do this, I'd prefer to change uses of $BISECT_MODE with a
>> call to a function bisect_mode() that does the same thing.
>
> Yeah, I think it would be a good idea to have a bisect_mode() function.
> I don't like very much to blindly call some code when we might not need it.
>

Ok, I'll do that, though it does mean that during a bisect run
invocation, for example, the file BISECT_MODE file will be read log(N)
times instead of just once. Obviously, in the grand scheme of things
this is not a huge cost.

I could use a variable to avoid hitting the file each time, but if I
do that I am going to have to ensure it is blank to start with which
means I will need at least an assignment in the place where that
statement is now.

jon.
