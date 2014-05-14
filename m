From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v2 00/29] Teach guilt import-commit how to create legal
 patch names, and more
Date: Wed, 14 May 2014 11:49:39 +0200
Message-ID: <CAP=KgsSi2DHvgKhpXPYRgQcnsRvP2UWva5u_V4DEnLEP-q6zQg@mail.gmail.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
	<20140513204546.GB11391@thunk.org>
	<20140513205443.GB4791@meili.valhalla.31bits.net>
	<CAP=KgsTvt7btB0EO75UeW2SejeXm9u7nfPLf0J2M+Y2H=u9s5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Theodore Ts'o" <tytso@mit.edu>, Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 14 11:49:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkVou-0005zB-IU
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 11:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbaENJto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 05:49:44 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:65157 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbaENJtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 05:49:40 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so1555555iec.7
        for <git@vger.kernel.org>; Wed, 14 May 2014 02:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=teEDn97Hj1Z0i4qtTM4ODZwGZxOWJUyQLzQ2uQC2pZY=;
        b=E7cyk2DN9U1b7prxE6xTRry+DSbiz4G4OcpwR24UkCX+0QQsuptkOhyHmC2PMlTBN+
         t6C9/O4f9CE/VgePkLTZBuUohBfPyaAC4Eg5stdQUlK02hkJC41bTDR5S/Ogp+NYrqfz
         y1MdpXAq23rerM+lxcqk7tgoGRIjl/Gh+WEzXdz22rtBG07lgh6ruZTcgS2VOJ+eVsJ6
         RNmx6Ci9wonAlIUhozUGwBoZbnENlUn9ksrmfMMVCdmu1rk6vF09Cb0+afYnjU/qu5OU
         rFmjvtKLP2L/6VkyCYCYMhnr7BqBhK/gTJSOYTtv9krUXFSm4AcyLZdQudUY11HOtwjb
         +h3w==
X-Gm-Message-State: ALoCoQmizPhdoxqf/xo7XFvBAj+yBKJUCEHMkd+5/xkL44T67Hsk9qbq2vgB/uMU+QCuXENNFIV7
X-Received: by 10.50.66.143 with SMTP id f15mr65673794igt.18.1400060979797;
 Wed, 14 May 2014 02:49:39 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Wed, 14 May 2014 02:49:39 -0700 (PDT)
In-Reply-To: <CAP=KgsTvt7btB0EO75UeW2SejeXm9u7nfPLf0J2M+Y2H=u9s5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248905>

On Tue, May 13, 2014 at 11:29 PM, Per Cederqvist <cederp@opera.com> wrote:
> On Tue, May 13, 2014 at 10:54 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
>> On Tue, May 13, 2014 at 04:45:47PM -0400, Theodore Ts'o wrote:
>>> On Tue, May 13, 2014 at 10:30:36PM +0200, Per Cederqvist wrote:
>> ...
>>> >  - Changed behavior: by default, guilt no longer changes branch when
>>> >    you push a patch.  You need to do "git config guilt.reusebranch
>>> >    false" to re-enable that.  This patch sets the default value of
>>> >    guilt.reusebranch to true; it should in my opinion change to false
>>> >    a year or two after the next release.
>>>
>>> We've been living with the "origin" -> "guilt/origin" branch change
>>> for a year already, and in fact, these days I've gotten used to the
>>> new behavior.  Is it really worth it to change the default?
>>
>> So, at first I was skeptical about the branch name prefix change.  I've used
>> it for about a year now, and I love it.  When I first read Per's idea to
>> change the default to the old-style, I was a bit sad but I understand the
>> motivation.
>>
>> I'm open to either mode being the default since it's easy enough for me to
>> change it for me (thanks, ~/.gitconfig) but I think more people should
>> benefit from the added safety against accidental git-push.  (I also like
>> being able to use guilt/master..master to get only the commits I care
>> about.)  Thoughts?
>
> I don't have a strong opinion on which the default value should be.
> The scenario where it matters, when you run multiple versions of
> guilt against the same directory, is probably very rare in practice.
> If it is mentioned in the release note that it can be changed if needed,
> that is probably good enough.
>
>     /ceder

I will change the default value to false in the next version of the patch
series, unless there are objections.  I plan to send it to the list Friday
morning.

    /ceder
