From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 16:13:08 +1100
Message-ID: <CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com> <CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
 <slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 06:13:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkT1O-0002Y9-SD
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 06:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781Ab2LQFN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 00:13:29 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:53968 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab2LQFN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 00:13:29 -0500
Received: by mail-qc0-f180.google.com with SMTP id v28so3617757qcm.11
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 21:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZbtLaKaB5y4AnBboEAK0659Ii+8h96gwWKV8xD6TTaY=;
        b=KdQ7I89E2xU9t+OVQbaNGGFTyp06t+Gw3Ktl3VXRr57DFJN9bf3XnFmQ0lNpFeDCDN
         SbL2jZozaal+H346yTpHv8IoLGNDIUq2Y6ZIbMIGp5pmD2M99g6dqdo7RoILBDybUcf1
         a7h5zIqyZZSgqIF/5OEcOIFeO5qKK6utgvDM0gNSq7dNgo5zw1ysqAhtkCMRLKgHxmK9
         iNAKen2CxtS5cUsvuC6LOgoWhVaPcikShDgBbFCGKgyHk6fboUkdMQaDnHLMQi0IB882
         hxcXqkYpqojVZmIjKB5ZSW9SLIgjpjn8FR2e0pxAjCKOakH7vkMFSxt+mPRdKn6bt7eW
         C2qg==
Received: by 10.49.118.138 with SMTP id km10mr6375236qeb.18.1355721208387;
 Sun, 16 Dec 2012 21:13:28 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Sun, 16 Dec 2012 21:13:08 -0800 (PST)
In-Reply-To: <slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211631>

On 17 December 2012 16:06, Woody Wu <narkewoody@gmail.com> wrote:
> 1. git checkout foo.
> By this command, I think I am checking out files in my local branch
> named foo, and after that I also switch to the branch. Right?

Correct. Your working directory (files) switch over to whatever your
local branch 'foo' points to, and your HEAD is updated to point to
your local branch 'foo'. Unless something goes wrong/you have
conflicting files/uncommitted changes etc.

> 2. git checkout origin/foo
> By this command, I am checking out files in remote branch origin/foo,
> but don't create a local branch, so I am not in any branch now. This is
> the reason why git tell me that I am in a 'detached HEAD'. Is this
> understanding right?

Correct! Your working directory is updated, however it doesn't make
sense for you to make changes to a remote branch, so HEAD is updated
to be detached.

>>
>> There are lots of patterns that can emerge from this functionality,
>> but the main thing to remember is that to create changes on top of a
>> remote branch, we first need to create a local copy of it. A 'detached
>> HEAD' here means that we are looking at the remote repository's branch
>> but don't have a local copy of it, so any changes we make might be
>> 'lost' (that is, not have an easy to find branch name).
>>
>
> I think here is a little confuse to me.  You mean that a 'detached HEAD'
> means I don't have a local copy, but I remember that if I run something
> like:
>     $ git checkout a-tag-name
> then I ususally went into 'detached HEAD' but my local files really get
> switched to those files in the tag 'a-tag-name'.  So what does you mean
> by 'don't have a local copy'?

I should have been more clear. Here I mean that you don't have a local
copy of the branch reference. Your working directory is updated to be
in sync with the remote branch, but you haven't yet copied that remote
reference to a local branch that you can update with your changes.

Hope that clears it up.

Regards,

Andrew Ardill
