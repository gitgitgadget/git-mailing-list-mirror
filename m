From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH 0/2] submodule aware grep
Date: Fri, 24 Sep 2010 09:07:40 -0700
Message-ID: <4C9CCCCC.4000909@gmail.com>
References: <1285276627-7907-1-git-send-email-judge.packham@gmail.com> <20100924134748.GA576@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Sep 24 18:07:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAo8-0007KJ-BW
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385Ab0IXQHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:07:24 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51800 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab0IXQHX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:07:23 -0400
Received: by pxi10 with SMTP id 10so837888pxi.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=i5dPmP99MXJ3wP3mbyBwWW8gPXRkzxa5QuYY6SawHDk=;
        b=HHqv9jsdWjYlhRnriRoC/Ixtuj2oiAF/UXnbTWv0AvIAnqFVEK1Dcu5vUGRA2vsxki
         klSLUI+hY5zRbIyeDM/kQcac3vNvGDQctl+/QB5xZS0lBuwO/JC1eJSLMaIENq5R37jM
         O4L8fft55kffpHK7ENYPjDh1gpyrQ3iDBbb0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xgEHsl8fq0K4ohJCdiRXwggTSvTvTgfuEqQcIBPbGa2qlR8k04m1nMT+JxY8Jhs5+P
         jPUrspEvvU0/48rmKFORpHvMMCwbW9kPaNETF3q8XS4ULHytta0HG+HGQPPliD0QDevH
         oPpDo6Mc16a+62avEWrnWyFq2D+MnEdCHOV9U=
Received: by 10.114.201.18 with SMTP id y18mr3831073waf.138.1285344443069;
        Fri, 24 Sep 2010 09:07:23 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d2sm3791635wam.14.2010.09.24.09.07.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:07:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <20100924134748.GA576@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157014>

On 24/09/10 06:47, Heiko Voigt wrote:
> Hi,
> 
> On Thu, Sep 23, 2010 at 02:17:05PM -0700, Chris Packham wrote:
>> This series contains 2 RFC patches that both implement a grep feature for
>> submodules.  The first patch is a self-contained script for contrib that should
>> work with most current git versions. The 2nd is basically the same
>> implementation but done as a proper git submodule command with some of the
>> helper code moved to git-sh-setup.sh
>>
>> There are a couple of questions for this. Technically I'm making submodule 
>> grep-aware, should I be making grep submodule-aware instead? I haven't looked 
>> at the grep code yet but I imagine its harder.
> 
> Nice work! IMO it would be even nicer to have it as part of git grep.
> Have a look at Jens branch about submodule checkout:
> 
> http://github.com/jlehmann/git-submod-enhancements (enhance_git_for_submodules)
> 
> particularly how checkout_submodule() is implemented. It forks a git
> checkout inside the submodule. In a similar way you could fork a grep
> there. Then you just have to teach the forked grep to prepend the
> submodules path.
> 

I'll look into it, from following Jens code it doesn't look too hard
(like you say just fork and pass a text prefix). I'm currently doing my
git hacking on my main development machine so I should probably setup
and environment where I can hack without affecting $dayjob work.

In the meantime I've got an updated patch for contrib if anyone is
interested (it just adds some grep options to be passed through).

Thanks,
Chris
