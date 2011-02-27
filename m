From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 3/3] mergetool--lib: Add the proper executable name for
 ECMerge
Date: Mon, 28 Feb 2011 08:25:07 +1300
Message-ID: <4D6AA513.1050002@gmail.com>
References: <4D68DAC4.9060100@gmail.com>	<4D68DBB0.2020909@gmail.com>	<4D69E628.5040007@gmail.com> <AANLkTi=CuyNLNuuootcd8_H9Zh=WqAwiS+S6PJjPAfcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, charles@hashpling.org,
	Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 20:24:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtmDs-00041t-1l
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 20:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab1B0TX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 14:23:59 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:56865 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab1B0TX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 14:23:58 -0500
Received: by pxi15 with SMTP id 15so523136pxi.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6OVyB2pnxVseUgwZjlWLjjZFJ5G9rpzjKRFRlxU3SuA=;
        b=e8zYqmW77c1aE4BrS5HcW52elpmHfqaddwwgPNTIvi0DdVMaTULezkCFXyWkNzOGk1
         MRF6cuF3l2XXsHY2NOFvHthJ5gHf89klzr5WnOQFs2rFFQltqIJdvIE0VAqFEUvr+aXF
         AI6tuOOhxM1AgakGX7dF12pwJzuHRifC2uzXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=NenXPWuegq1IQhbYdXlJOf1xMmUGMcLEGTUkTVKBrB779LmRC8V5apqfjRZKmR3xeA
         1hih7MvJrSvzAFPwLxWSjE5bIqthpERwoNH1wPMZRoPQzXjArfRl0axl7cyo7y+DUN6h
         zMMwNrzWYq2GEmUi3PGfQWdv/yd+rN2croV5c=
Received: by 10.142.218.13 with SMTP id q13mr3562202wfg.416.1298834638029;
        Sun, 27 Feb 2011 11:23:58 -0800 (PST)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id m10sm4769799wfl.23.2011.02.27.11.23.54
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 11:23:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <AANLkTi=CuyNLNuuootcd8_H9Zh=WqAwiS+S6PJjPAfcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168050>

On 27/02/11 23:37, Sebastian Schuberth wrote:
> On Sun, Feb 27, 2011 at 06:50, Chris Packham <judge.packham@gmail.com> wrote:
> 
>>> +     ecmerge)
>>> +             echo guimerge
>>> +             ;;
>>>       emerge)
>>>               echo emacs
>>>               ;;
>>
>> I think this is another case of linux/windows versions of the
>> application having different executable names.
>>
>> chrisp@laptop:~> tar -tf Download/ecmerge-2.3.123.linux.x86.tbz
>> /usr/local/bin/ecmerge
>> /opt/elliecomputing/ecmerge/guimerge
>> /opt/elliecomputing/ecmerge/guimerge.exe
> 
> Indeed, well except that Linux has both "ecmerge" and "guimerge",
> whereas Windows only has "guimerge", which is why I went with the
> latter. Giving it a second thought, my patch is a little inconvenient
> for Linux users, as it will stop making ecmerge work out of the box
> (without first setting mergetool.ecmerge.path), whereas Windows users
> need to set mergetool.ecmerge.path anyway.
> 
> I've also contacted the makers of ECMerge and asked them to unify the
> naming across platforms. Maybe we should just drop this patch until
> they did.
> 
> Chris, what do you think? 

If the ecmerge makers can get 'ecmerge' to be a valid command on windows
then that'd be the best solution for now.

I have a different idea for handling this going forward (maybe for
v1.8.0). One benefit of having built-in knowledge of a mergetool, as
opposed to using config variables, is git knows when to do a 2-way merge
vs a 3-way merge. So instead of having a single mergetool.cmd maybe we
need mergetool.cmd2way and mergetool.cmd3way, all of the existing
supported mergetools could then be expressed as a set of config
variables (maybe installed in system or global configs by the git
installation process).

I'll try to write that up as a proper v1.8.0 proposal when I get a chance.
