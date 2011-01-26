From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Updating a submodule with a compatible version from another
 submodule version using the parent meta-repository
Date: Wed, 26 Jan 2011 14:10:32 -0500
Message-ID: <AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
	<AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
	<4D407099.4010805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 26 20:10:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiAlQ-0003g4-Ji
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 20:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1AZTKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 14:10:34 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46077 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab1AZTKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 14:10:33 -0500
Received: by wwa36 with SMTP id 36so1317418wwa.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 11:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Nvgst1Is0lGLk5ZaJ583l9QoZnqOw7bDbuqi9yPxlFM=;
        b=RHAg3yus6bFFPcMXGsTbPjvMmOQBSbF4E9lzV5beBshGaQpMXPj96F0j7EADrLnZSL
         va0d13L8ido4Q9Qa4GdHKy9/AY7AnZhii3yOA2DLqNTUn6PF+fvn/tc75NVQLiMmaDNz
         3L09oN8IUri1mqyWJGknh7c8rbTtcrvxJ1Pd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MzBiyEnisrJmvpcihcSDdZIFhcvohCaTo3GI4zAUsBDIpHOCorKUREyr5pwu4mANd1
         Nz/X0BEWM/ed0EjUvCdOFxcffIHSd2EtW17s1/8m/c4cNrgXF7FW+Re6qhyPC2GMGbTI
         Nj0qd9TiiESwsi13bA9ROlG4Cd1gK1DiODhrw=
Received: by 10.227.11.143 with SMTP id t15mr3147988wbt.27.1296069032395; Wed,
 26 Jan 2011 11:10:32 -0800 (PST)
Received: by 10.227.146.83 with HTTP; Wed, 26 Jan 2011 11:10:32 -0800 (PST)
In-Reply-To: <4D407099.4010805@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165532>

On Wed, Jan 26, 2011 at 2:06 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 26.01.2011 19:32, schrieb Julian Ibarz:
>> I am using git submodule in one of my professional projects and I am
>> facing an issue when I am using git bisect in one of the submodules.
>>
>> Basically I have a meta repository which I will call A and two
>> submodules B and C. Sometimes I use git bisect in B but it is
>> dependent on C so when I go back too much in the history of B, C needs
>> to change its version to a compatible one. Doing this manually is
>> really time consuming for me and I guess a lot of people have this
>> issue so I was a little bit surprise to not find easily anything on
>> the net that permits to do this automatically.
>
> What about bisecting in A (doing "git submodule update" after every
> step) to bisect to a smaller range of commits in B (which are then
> not dependent on your submodule C anymore and can be bisected inside
> B)? This of course assumes A properly records the dependencies
> between B and C.

Yes but actually my real use case that made me write this mail was
more I have a feature done in an old branch and to try it I never to
revert back to this version. In this case, I have to find out the
corresponding good version in A and C. In this case I cannot start
like what you propose in A to find out the good version in B and C, I
already know the version I want in B.

>> Is there anything existing to do that and I just didn't find it yet?
>> If not I think I might have an implementation idea I would like to try
>> out.
>
> The call to "git submodule update" after each bisect step in the
> superproject will be obsolete as soon as the recursive checkout
> I am currently working on is done, but that is not here yet.

Can you be more detailed about your recursive checkout feature? Is it
what I proposed?
