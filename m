From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 0/3] git-cvsserver: Add support for some binary files
Date: Mon, 19 May 2008 10:38:21 +1200
Message-ID: <46a038f90805181538v56aee5b8y33d68b226a62494f@mail.gmail.com>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net>
	 <7v7idteqzn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthew Ogilvie" <mmogilvi_git@miniinfo.net>, git@vger.kernel.org,
	"Martin Langhoff" <martin@catalyst.net.nz>,
	"Frank Lichtenheld" <djpig@debian.org>
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 00:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxrXZ-000323-V8
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 00:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYERWiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 18:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYERWiY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 18:38:24 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:15205 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbYERWiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 18:38:22 -0400
Received: by py-out-1112.google.com with SMTP id u52so1605228pyb.10
        for <git@vger.kernel.org>; Sun, 18 May 2008 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=U3jxRRuAAwFJOA9KCD9dAbx2n1UzdcSm0+aCdsn8RJ4=;
        b=WjRSQbDKOlaUWji4//2PX2VoWW1/hB8wWOMhExMLDfROGZnLO+TANCnAb+ucS0EdiOnwKL7nKq2EF9CRWau+MeS5bIJCydqr2bsYdsh/GJ9MTNoEYgGcjqKosJX/4MXhwCb034yxLDqo37cGs0wdFDDQSI6slClCD0VOfX/gCTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d8IDUa05xmEAGE03+0tYpBypJHwrW17jri+MAw16GjHwvQwk4DTqHvucbrqaG+/3Q96LZgIyPqqCyi+udv45K5b5OBXnoED0mg9t0e9SjKRDXqIhBF1lcnbVLW3WeiCa0MzPWEkbBQbOPDErDCsl3TLiM9Ie9l9wZrAIkZp+7Jg=
Received: by 10.142.240.9 with SMTP id n9mr2564668wfh.6.1211150301152;
        Sun, 18 May 2008 15:38:21 -0700 (PDT)
Received: by 10.142.128.16 with HTTP; Sun, 18 May 2008 15:38:21 -0700 (PDT)
In-Reply-To: <7v7idteqzn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82399>

On Sat, May 17, 2008 at 12:03 PM, Junio C Hamano <junio@pobox.com> wrote:
> Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:
>
>> This series of patches extends git-cvsserver to support telling the
>> CVS client to set the -kb (binary) mode for files that git considers
>> to be binary (and not for text files).  It includes updates to
>> documentation and tests.
>
> I am unfortunately not familiar with this part of the system and I'd need
> to summon help from experts, but it looks rather nicely done.

Looks good.

I was at first a bit troubled - "cvsserver doesn't do keyword
expansion anyway" was my first thought - but it makes sense to have
this to help newline-munging clients.

IIRC, one thing that is _not_ handled well in CVS -k flag changes on
the server side (since -k modes are not versioned). If we are
guessing, this may be more likely to happen, or at least more likely
to _surprise_ people.

Matthew, have you had a chance to test k mode changes against clients?
Are we reasonably bug-compatible with the original turd^H^H^Hhing? ;-)

Sorry about the latency!

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
