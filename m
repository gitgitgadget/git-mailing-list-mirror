From: Michael Witten <mfwitten@gmail.com>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sat, 3 Apr 2010 17:42:55 -0600
Message-ID: <j2pb4087cc51004031642qa9444506s8d0d34e57e541953@mail.gmail.com>
References: <201004030005.35737.elendil@planet.nl> <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com> 
	<201004040123.06877.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sun Apr 04 01:43:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyD02-0006pe-42
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 01:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab0DCXnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 19:43:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:43899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab0DCXnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 19:43:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so375439fgg.1
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=Hm1TkvnwqNtmD8632YtOMyRw2Zv4fakM1YCgupjh2oU=;
        b=pTz0rxse35eOW8OGhNDBoAuNngXgMoi3bUNmQBgcu5K00A1S8nc+7GlIcl0cajcAVF
         yIKmMXvC6g9orK0DbBsle8NJwRnjSJmFZrLwt+V3iwxudRX6xlJmf1Wgjx7uhXPj/M4y
         IRWY7HKCiEVDc9R74n4R1SCGVL7L8ZXSbPlkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oMEOJAIZX6NnqBtVSO8M8CG0wHfNuRXv9iZcteD3S5B2hVTywiJXInqdOroHxoguG7
         WTBCTD70cU+6SataYdDdp+rbpYAzHITT7ii+OYDfWJsWaroA/vLZg88fgq2/kA9mwkuJ
         6kHvcGO2esb+t59I5UsHbTB4/OS6zyxJsN6Is=
Received: by 10.239.133.140 with HTTP; Sat, 3 Apr 2010 16:42:55 -0700 (PDT)
In-Reply-To: <201004040123.06877.elendil@planet.nl>
Received: by 10.239.183.71 with SMTP id t7mr380377hbg.36.1270338195071; Sat, 
	03 Apr 2010 16:43:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143909>

On Sat, Apr 3, 2010 at 17:23, Frans Pop <elendil@planet.nl> wrote:
> On Saturday 03 April 2010, Michael Witten wrote:
>> On Fri, Apr 2, 2010 at 16:05, Frans Pop <elendil@planet.nl> wrote:
>> > I haven't had the patience to let it finish
> ...
> I've tried it today on my linux-2.6 repo as well and the same thing
> happened. At first the progress is not fast but reasonable. When it gets
> to about 45% percent it starts slowing down a lot: from ~1500 objects per
> update of the counters to ~300 objects per update. And who knows what
> the progress is going to be when it reaches 70% or 90%: 10 per update?
>
> With a total of over 2 milion objects in the repository such a low speed is
> simply not going to work, ever. So I maintain that it is effectively
> unusable.

Well, all I can do is quote myself:

    Last time I used this option (on Linus's Linux repo),
    I let the algorithm do its thing for a couple of hours.
    Maybe the efficiency could be vastly improved, but
    it does finish if you let it.

On Fri, Apr 2, 2010 at 16:12, Frans Pop <elendil@planet.nl> wrote:
> I'm seeing this with both git 1.6.6.1 and 1.7.0.3 on the same repo.

I think I must have run gc with 1.7.0.2.199.g90a2bf9; perhaps you
could use something like oprofile to figure out where gc is spending
most of its time.
