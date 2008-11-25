From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 00:44:00 +0100
Message-ID: <85b5c3130811251544u5423c69p87c11241a2685f2f@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <492C367D.3030209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Fabian Seoane" <fabian@fseoane.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 00:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L57ar-000372-Vf
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 00:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbYKYXoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYKYXoE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 18:44:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:48787 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbYKYXoC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 18:44:02 -0500
Received: by fg-out-1718.google.com with SMTP id 19so113037fgg.17
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 15:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=ZhcBLCX6rJVOwqUlgoBF3izGGapv6dfztPSvJF5V/B8=;
        b=cm95zZRROeWWLKZdSf0sNx2gQ/LthVF8Wu0tQVa+dLTLdim3K+7Sdni1w+K2YeMYU+
         EQ0WS//NrKxuIqse94fUrry6XUkZhSkAKubQuYsSwWxjSWh6wP2+xT0r1BlndLwtn3Sk
         MqAnFBz6tU4plxF2X/5lSypqk2NCEyW528QGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=U4hgbYGD1RtGgcv0arsvX4Hon6Q50m6XaC4Rjkp4z4gt2FKXjSdi3VpgjELa02S7iw
         95P8c7s3mVD9s2zglok+YnXqu6dnPtYaoTnIzCNkb7j9MtKIj169XPSM+SvdSBDxs6h+
         uVkow2fAhEE+E9FMJeo3sl57DA7ALp9hOr/fY=
Received: by 10.86.84.18 with SMTP id h18mr3359919fgb.22.1227656640608;
        Tue, 25 Nov 2008 15:44:00 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Tue, 25 Nov 2008 15:44:00 -0800 (PST)
In-Reply-To: <492C367D.3030209@drmicha.warpmail.net>
Content-Disposition: inline
X-Google-Sender-Auth: 588603313a319d0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101694>

On Tue, Nov 25, 2008 at 6:31 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Ondrej Certik venit, vidit, dixit 25.11.2008 17:44:
>> Hi,
>>
>> I would like to export our whole git repository to patches, and then
>> reconstruct it again from scratch. Following the man page of "git
>> fast-export":
>>
>> $ git clone git://git.sympy.org/sympy-full-history-20081023.git
>> $ cd sympy-full-history-20081023
>> $ git fast-export --all --export-marks=marks > patches
>> $ cd ..
>> $ mkdir sympy-new
>> $ cd sympy-new
>> $ git init
>> $ git fast-import --export-marks=marks < ../sympy-full-history-20081023/patches
>> git-fast-import statistics:
>> ---------------------------------------------------------------------
>> Alloc'd objects:      25000
>> Total objects:        21355 (       144 duplicates                  )
>>       blobs  :         8009 (         0 duplicates       4529 deltas)
>>       trees  :        10627 (       144 duplicates       9189 deltas)
>>       commits:         2719 (         0 duplicates          0 deltas)
>>       tags   :            0 (         0 duplicates          0 deltas)
>> Total branches:          21 (        26 loads     )
>>       marks:        1048576 (     10728 unique    )
>>       atoms:            726
>> Memory total:          2880 KiB
>>        pools:          2098 KiB
>>      objects:           781 KiB
>> ---------------------------------------------------------------------
>> pack_report: getpagesize()            =       4096
>> pack_report: core.packedGitWindowSize =   33554432
>> pack_report: core.packedGitLimit      =  268435456
>> pack_report: pack_used_ctr            =      40706
>> pack_report: pack_mmap_calls          =       2791
>> pack_report: pack_open_windows        =          1 /          2
>> pack_report: pack_mapped              =   26177739 /   35513414
>> ---------------------------------------------------------------------
>>
>>
>>
>> However, the repository is very different to the original one. It
>> contains only 191 patches:
>>
>> $ git log --pretty=oneline | wc -l
>> 191
>>
>> and it only contains couple files. Compare this with the original repository:
>>
>> $ git log --pretty=oneline | wc -l
>> 2719
>
> I get the same stats (with the dups) but a perfect rev count, when I use
> git log --all. The reason is that the history in the imported repo is
> disconnected at various places (at tagging commits)! Your command counts
> only the revs backwards to the first "disconnection".

You are right! I didn't know about "git log --all".

>
> So, the real issue is: Why has the result these cuts in the history?

Yes, I would like to know this too. E.g. if it is a problem with our
repository, or a problem in git, or whether it is just not supposed to
work.

> I don't know, I just noticed that turning on rename and copy detection
> makes git-fast-import crash, which shouldn't happen either. Something's
> not right here. CC'ing the authors of im- and export.
>
> BTW: Maybe you can accomplish what you want with different means? Why
> export|import directly to git?

I just answered this in my other email. Basically there are
workarounds, but I would feel safe if I can (correctly) reconstruct
the whole git repository from a human readable patches.

Ondrej
