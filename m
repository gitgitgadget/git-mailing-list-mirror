From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-grep: Add ability to limit directory recursion
Date: Wed, 7 May 2008 03:34:17 +0200
Message-ID: <200805070334.18500.jnareb@gmail.com>
References: <1210094304-2450-1-git-send-email-aidan@highrise.ca> <m3iqxr54uy.fsf@localhost.localdomain> <20080507004719.GJ18081@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Wed May 07 03:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtYYt-0007WR-5x
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 03:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbYEGBe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 21:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbYEGBe0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 21:34:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:13510 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbYEGBeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 21:34:25 -0400
Received: by ug-out-1314.google.com with SMTP id h2so5167ugf.16
        for <git@vger.kernel.org>; Tue, 06 May 2008 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=7HKwxPaUlr3qtuRcobY8UFdnl2wSjn44T4psnkVbJ2k=;
        b=XTyfaICNCOQ8/cg8dXiNqhSOfNuuyHm+UlRRLzMbrQlOapO5uFfyJCYOkvx71eQR4+5XrwMaaapU1xMaWoaD2q7ULvOsKbnRR93cb8JSgze4RRzAgEm+ucM6tYuMrdBMzVmH3dXQXM+Tz24wc5wnzMHXHCbSelJN29w6T4DPh2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DTqr8Q6WZkQt1JuzJ+AE9PDOSUj3oyeTylnwrErjpxgBPuf20AuZew8hJgfgFw88Hpx16s6FJ5iakjQ840mvvIYmcYxP/aesSBb/aqqgVdEYzJjP5FFg+FPPR8yIIcLcR+AkWWpvExPVym19L+dTQa9Q/FLrhOzbJsLsrKKR9UY=
Received: by 10.67.15.2 with SMTP id s2mr1611045ugi.87.1210124063919;
        Tue, 06 May 2008 18:34:23 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.194.224])
        by mx.google.com with ESMTPS id z34sm1768800ikz.9.2008.05.06.18.34.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 May 2008 18:34:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080507004719.GJ18081@yugib.highrise.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81399>

Aidan Van Dyk wrote:
> * Jakub Narebski <jnareb@gmail.com> [080506 20:34]:
>> Aidan Van Dyk <aidan@highrise.ca> writes:
>> 
>>> This add a -R <limit> option to git-grep which will limit the depth of the
>>> directories recursed when git is doing a grep.
>>> 
>>> This allows you to do something like:
>>>         git grep -R 1 <pattern>
>>> and see only the results of the grep on files in the current directory.
>>> 
>>> It defaults to a limit of "0" which disables the limiting.
>> 
>> Nice idea, although I'm not sure if we shouldn't borrow "-maxdepth"
>> option from GNU find and friends...
> 
> Good idea - I hadn't thought of that, but I like it better.

Note that GNU find uses non-standard single-dash long options, and
that "-maxdepth 0" means do not recurse, but use only files provided
as arguments.

GNU wget on the other hand uses -l DEPTH/--level=DEPTH, and uses -l 0
(or -l inf) as in your patch, i.e. infinite recursion.

-- 
Jakub Narebski
Poland
