From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/5] Use variables for the lists of tools that support
 merging / diffing
Date: Mon, 23 Jul 2012 21:03:59 +0200
Message-ID: <500DA01F.20502@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com> <500CFAB4.4050905@gmail.com> <7vvchemnmn.fsf@alter.siamese.dyndns.org> <500D984D.4070909@gmail.com> <7vzk6ql3wk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNvS-0004Dn-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 21:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab2GWTEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 15:04:07 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60281 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab2GWTEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 15:04:06 -0400
Received: by wibhr14 with SMTP id hr14so3222248wib.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=JHGp+rRXj7+sjKlC1dJmyvrbr3JENxSk+tXVFoLBTPc=;
        b=RND44GEaLurf2cbS6Po0SF9Ti3Ptujn9J3Lf5y3/mXGQgXqPDmDe9ogfR4LhZsdGwo
         jZ8UVCYVfXfX4zZXXzwEa3poHpYwdGUF2WJfQO0sLtsYvP/pCAbg8IfsXUlpYvNky3sX
         L3mvMk1YinK2gHK8zuFN/aw/3Oo48g9sx0hfUfCuTlGn0Bqx1Sahxp93w4ZI+85I92Rf
         rmf3Mf8ygNChYYpBE8jQXuV8WcfnoXyHIT0M2jir8oYjCKtfv9ydwMkqFFTGYIdkC7h+
         6clv7An3W0A1T90DXha30ddsnAv/coNOdE+tT4lODd2h3JE8KXXfRkjSTkPiH52e5oyz
         msgg==
Received: by 10.216.113.4 with SMTP id z4mr8069213weg.201.1343070243952;
        Mon, 23 Jul 2012 12:04:03 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id bc2sm178713wib.0.2012.07.23.12.04.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 12:04:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vzk6ql3wk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201963>

On 23.07.2012 20:37, Junio C Hamano wrote:

>>> This patch makes sense to me, but at the same time makes [PATCH 1/5]
>>> a "Meh", methinks.
>>
>> Yeah, I can see why. So I've renamed __git_mergetools_common to
>> __git_diffmerge_tools and squashed with [PATCH 1/5] to make it
>> less "Meh" as it does not stand on its own.
>
> As you append kcompare or tortoise _after_ the common list, any code
> that uses the variable cannot assume that the list is sorted, and
> needs to sort the elements if it wants to give a sorted output, so
> squashing does not make the Meh-ness go away.

Well, that (mostly) sorted listed still helps to find out a little 
quicker whether a specific tool that can do both merging and diffing is 
already in the list. At least that's the case for me.

> By the way, would it make sense to remove these three variables from
> the completion code, and instead ask "git mergetool --tool-help"
> when it needs the list of supported tools for the first time?  It
> would be trivial to introduce --tool-list that gives a one tool per
> line output to both "git difftool" and "git mergetool" and we would
> remove the risk of separately maintained list drifting away over
> time.

Sounds like a good idea now that you've added "git mergetool 
--tool-help". But I'd like to save this for a future exercise to not do 
too much stuff at the same time.

-- 
Sebastian Schuberth
