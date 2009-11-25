From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 18:07:00 -0500
Message-ID: <4B0DB894.7010800@gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net> <7vtywiqmbs.fsf@alter.siamese.dyndns.org> <20091125222625.GB2861@coredump.intra.peff.net> <4B0DB29D.5010101@gmail.com> <20091125225318.GA10127@coredump.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQx2-0007rD-RF
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759826AbZKYXG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759510AbZKYXG5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:06:57 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:35071 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759504AbZKYXG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:06:56 -0500
Received: by ywh12 with SMTP id 12so228369ywh.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=TvWp7/PDx0VZSf54SiDTtNqkslRMQtVdzexgh6cJVnc=;
        b=BgRWxRNIypnAMAG7VJBSDY8jB5m16M16ynGRdouVzjXVhvognJ8TVvWdIALTBsxRnd
         mCNZYeiJBBs/UlWKnQ65xCemjFNm/B3M+b3pbolmmr5jM/R4yjR1qRsTNndSY9zfZzwO
         bkYE9byjB5wWCIXr3969hDsi2Prr8KbO8VNgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=SAnPiyZF+9c7f8/+39Tisb1QyU+bHMygktSoX70rVBRl+xnCXbk25P+9rx8hgwumFx
         jlySPiYQiFhzAq1Ib4G5vlkTohv6akTXZTCfaAJBEHU9GrQA6mNdB1AbuRA3z6muJJ58
         Dt2jrEgPX5+1efO0SDVVyn3nSKyGOgnh92sd4=
Received: by 10.151.95.25 with SMTP id x25mr13155953ybl.33.1259190422844;
        Wed, 25 Nov 2009 15:07:02 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 6sm47528ywd.52.2009.11.25.15.07.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 15:07:02 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20091125225318.GA10127@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133696>

Jeff King wrote:
> On Wed, Nov 25, 2009 at 05:41:33PM -0500, A Large Angry SCM wrote:
> 
>>> I agree with all of this as far as changing the default goes. But the
>>> point of my earlier messages was that I don't think there _is_ one sane
>>> default. I really do want it different per-project. And that means a
>>> configuration option.
>> Since grep is so useful, both interactively and scripted, outside of
>> git, this is a pretty convincing argument that git-grep, and all
>> other git commands with configurable behavior or defaults that change
>> over time, need a both a scripting form and an interactive form.
> 
> It is tempting to have scripts simply set a GIT_VANILLA environment
> variable to ignore config options. But I think it is not quite so
> simple. As a script, if I am calling "git log", do I want it to respect
> the user's colorization config or not? It depends on _how_ I am calling
> it. Is the output to be shown to the user, or am I going to process it
> myself?
> 
> Similarly, why is the script calling "git grep"? If it is because the
> script is a convenience wrapper (e.g., let's say to colorize the output
> in a particular way), then it probably wants to respect my configured
> choice of which files to grep. But if the script is just using "git
> grep" to get data to perform some other calculation, then it probably
> does care deeply about which set of files to grep.
> 
> So I think you have situations where scripts do want to invoke the
> porcelain version of a command versus the plumbing. But much harder, you
> have ones where they want to respect some options but not others.

<semi rhetorical>
So, what's the solution?

Have every command command take a list of configuration options to 
ignore/respect?

Have every command take an option to ignore/respect _all_ configuration 
options?

Have inconsistency between commands, like we have now

Have commands have all kinds of hidden/undocumented default settings?
</semi rhetorical>
