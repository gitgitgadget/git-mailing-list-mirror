From: Adam Stankiewicz <sheerun@sher.pl>
Subject: Re: Motd message on git cloning
Date: Sun, 18 Nov 2012 17:51:09 +0100
Message-ID: <CANCidP-8KCnOTcKwOQGpLUmc73WjQ3OrDcUOYy40O4mgiE5cBw@mail.gmail.com>
References: <CANCidP-d0tXfo6ZsC80LmaS1CJ475rew2D7ztrx9TkNa94a-uw@mail.gmail.com>
 <CAM9Z-nkxLqrS5i6Ycz02Amit5itmGJojy=e8+SG9LQYcBHJVxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 17:51:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta85x-0005fF-2P
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 17:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab2KRQvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 11:51:31 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:42814 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2KRQva (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 11:51:30 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so2773477qat.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 08:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:x-gm-message-state;
        bh=PcM/Xl9HfkyuBXLv4l/wezoxypjBD71/aUH+g0ToJVw=;
        b=Ia0NHUH8gWC0jtGbpGbvpBqbqkCLwVRq7VIix2HuBzwiGvjGsaW13D0FbyjTJwiHTU
         1PAYA32X2oKIoDsZGoWWAXUieRmGYfdAVk5LC1pF0suXoWZ5Nt9ylqXrsjx1i0Vgc5PM
         oLLw2aPMH98yUE4UQN2jcavZt2UDyJc3H34roufKO4VSNm6+fFXWLcwksdlDryZKCMGy
         3IH8RxQfPDKlXJu3FCMaxVbbRWUi6Py4qvYQU8rpOvEj58V5sJF6G5HBoZj/2cGnE7pC
         LmyuvZCqev1TuCrL8Kn9MRgqOWboZWcry43nL52kzKRcOfQtyKkm6ViMze6wq2K+rKGt
         1dMg==
Received: by 10.229.178.166 with SMTP id bm38mr2305557qcb.21.1353257489812;
 Sun, 18 Nov 2012 08:51:29 -0800 (PST)
Received: by 10.49.74.106 with HTTP; Sun, 18 Nov 2012 08:51:09 -0800 (PST)
X-Originating-IP: [62.87.248.204]
In-Reply-To: <CAM9Z-nkxLqrS5i6Ycz02Amit5itmGJojy=e8+SG9LQYcBHJVxQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQlMt8YwdoZ25k1ATyEvNgzDjuys3JM1kT3KVPXY3XbMbMr72/up/1CtV3M7i4nQirSVws+E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210031>

It we would agree that .git/motd should serve as MOTD file then at the
beginning there would be no noise at all, because currently no
repository contains that file.

I don't think developers would place there non-critical information
about the repository. The community would blame them for that.

Also if one does not like any additional noise, no one prevents him
from adding --no-motd flag as the default.

Thank you for attention.

On Sun, Nov 18, 2012 at 5:34 PM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Sun, Nov 18, 2012 at 11:04 AM, Adam Stankiewicz <sheerun@sher.pl> wrote:
>> I'm dreaming about git feature that shows custom message on git clone.
>> It would be extremely helpful for informing the person cloning about
>> init scripts he/she need to execute (for example submodule inits or
>> hooks set up). For now there is no way to make sure cloning person
>> will receive such message (unless he/she will read the README).
>
> So we should clog up the output (which may contain important error
> messages) just to protect the user from themselves?
>
>> The server does not need to know if it's fetch or clone, if programmer
>> executes git clone on client side, then the MOTD message would be
>> shown.
>>
>> I think good candidate for MOTD message is .git/description (because
>> for now no one seems to care about setting repository description).
>> Another option is to introduce .git/motd file that would consist of
>> some maximum number of non-control ASCII characters.
>>
>> I don't really see any security concerns. Git could filter any control
>> characters from MOTD out, and automation script could add --no-motd
>> flag. The could also be limit on MOTD file size so no one could
>> "flood" the terminal window with MOTD messages.
>
> While I think that it is helpful and sometimes important to set the
> description (especially for public repositories) I suspect that if
> somebody is cloning it then they already have a good chance of knowing
> what _should_ be in that file. This isn't a text-interactive session
> on an FTP server of yore.
>
>> Also it's important to me that such message would be shown
>> automatically by default and could be turned off, not the other way
>> (for example --motd flag).
>
> Ummm....NO. I cannot see this being an improvement for enough users to
> justify the extra noise.
>
> Granted, I am not the definitive word on much of anything around here,
> but I cannot see this making much sense in the big picture of things.
> If you wanted to make this change to something more like Google's
> "repo" wrapper script that would make at least some modicum of sense
> to me.
>
> --
> -Drew Northup
> --------------------------------------------------------------
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
