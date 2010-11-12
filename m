From: Ferry Huberts <mailings@hupie.com>
Subject: Re: git clone / git pull to USB memory stick (FAT) and symlinks
Date: Fri, 12 Nov 2010 16:06:19 +0100
Message-ID: <4CDD57EB.7050200@hupie.com>
References: <ibh605$adm$1@dough.gmane.org> <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Gelonida <gelonida@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 16:24:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGvUm-00081f-45
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 16:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456Ab0KLPYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 10:24:50 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:51561 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932100Ab0KLPYu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 10:24:50 -0500
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2010 10:24:50 EST
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.40.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id A49F458C993;
	Fri, 12 Nov 2010 16:06:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Thunderbird/3.1.6
In-Reply-To: <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161346>

IIRC then a FAT filesystem will screw up your repository.
Is that still the case?

We had a few problems with that at work which is why I advised against it.



On 11/11/2010 06:54 PM, Junio C Hamano wrote:
> Gelonida <gelonida@gmail.com> writes:
>
>> I thought about cloning a remote git repository onto the stick
>> and performing
>> - regular pulls in order to update the USB stick
>> - occasional pushes in orderto publish changes performed on the stick.
> ... missing is the reason why this is done to a USB memory stick.  More
> specifically,...
>
>> 1.) Ignore skip / symlinks
>> 2.) Avoiding file permission issues: Is this sufficient
> These become non-issues _if_ the reason you are putting this on an USB
> stick is to safekeep and sneakernet the project data, and are not
> interested in having a working tree on the stick, which I often find is
> the use case after grilling people who ask about placing git repositories
> on an USB stick.
>
> And the commands to interact with such a repository without a working tree
> are to "push" (into it), and "fetch" (from it).  IOW, you do not "pull"
> into USB stick.
>
> If you do need a working tree on the stick, and the stick has a FAT
> derived filesystem (which would be the most common), then you would need
>
>> git config --add core.fileMode false
> and perhaps "core.symlinks false" also would help
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


grtz

-- 
Ferry Huberts
