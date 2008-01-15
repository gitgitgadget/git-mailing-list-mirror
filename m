From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Tue, 15 Jan 2008 18:08:08 -0500
Message-ID: <478D3CD8.3040805@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>	<478855B5.9070600@gmail.com>	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>	<47885B2C.8020809@gmail.com>	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>	<4788BFA8.2030508@gmail.com>	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>	<47891658.3090604@gmail.com>	<alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de>	<47893F53.2070908@gmail.com>	<alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de>	<478AD5A0.50900@gmail.com> <7vabn9m30a.fsf@gitster.siamese.dyndns.org>	<478C3CD3.6010504@gmail.com> <7vy7a
 rhas9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:08:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEutf-0004Yd-OD
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 00:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbYAOXIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 18:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYAOXIP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 18:08:15 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:19279 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbYAOXIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 18:08:14 -0500
Received: by an-out-0708.google.com with SMTP id d31so5539and.103
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 15:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=QuymUmo7bBdWsMF/Z8otPbhHmvCKppELqfng6vFIph0=;
        b=KIMSQPgqiBH0z2z+5/jEAa3VfLHTaqzCIwCisWbwP11ZVk9ZQ/BnMgtcQCmpUhLrJBdPpBFx+9CijJcEidE8pehJy+PrVMHaddsmXhHzMUZlHwA7SSR3XPFPWCCBCWUMvM0cnGpHGrbQGdARhhiu4MWJ5/u/1hdJa4ImQjMjVo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kjE+r8U/AMitMwp2QXrfvFgiMBaJd1mLyl4xiQyCAqJQPzbTMahkkc4v2zkrakZMk/wdiiOlMTTg4RB7klxYMBLhUMORIvcY71vR2t0HgT34fjugP+aLt8zIunxIy0FLbmW+gWEYJSefCZ21vGNcOSLws1CmkerYDqmJYk1+F/k=
Received: by 10.100.216.3 with SMTP id o3mr73691ang.95.1200438489417;
        Tue, 15 Jan 2008 15:08:09 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id d38sm119938and.17.2008.01.15.15.08.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jan 2008 15:08:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vy7arhas9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70573>

Junio C Hamano wrote:
>> Nope, git submodule *still* requires origin (e.g., execute git
>> submodule init or update on a detached head).
>>     
>
> Now I am even more confused.
>
> The approach I suggested in a few paragraphs above, to which you
> just said "I like this change", is about making "git submodule
> update" to use the url configured in the upper level repository
> when it runs "git fetch".  I am looking at around l.238 of
> git-submodule.sh.  In the current code, it runs "git-fetch"
> without any parameter, which would allow it default to origin or
> whatever, which may or may not be desirable depending on where
> the 'origin' points at.  If you make that particular git-fetch
> explicitly say where the fetch should be done from, wouldn't it
> fix the issue for that codepath?  Why does it still require
> origin?
1) If top-level is on a detached head, then the remotes machinery will 
find current remote is "origin". This is what would be passed down the 
chain.

2) Absent the other changes in the thread, git-submodule-init still 
invokes   git clone *without* -o in the submodules, and thus still 
defines and points to remote "origin".

Mark
