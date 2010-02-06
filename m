From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 5/9] revert: add --ff option to allow fast forward when
 cherry-picking
Date: Sat, 06 Feb 2010 10:40:11 +0100
Message-ID: <4B6D38FB.9000307@gnu.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org> <20100205231112.3689.67634.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 10:40:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndh9N-0004Xv-6B
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 10:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab0BFJkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 04:40:18 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64874 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab0BFJkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 04:40:16 -0500
Received: by bwz19 with SMTP id 19so499256bwz.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 01:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=xsroTFYre44L7XiIRQUaKfihYyOaijwwUwuNdHmGa1U=;
        b=inzLOejaclLR2k3ZiOoahJbpuJTQVLRlhQA25aIe82bsv1f+kTQKb7Ou3qAsF0gBMm
         CNGK0864A2nMk9hOJZohHReTCOvSZ5LTsZbAZyPXDVGFsVcRhECB2trRxvqSJzh3p1lx
         MWwweWnDRgPobWXRiWrlvPAwOIuaBwLEEn6X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KffjuIrbyv9KYKvKVWzrz3A+XFpDgNQyWscLHudErqCzQl5JVKYAxJDVfQda70NF7M
         IPrfPiaIJnzYAAVXNCA1WZs7wQfhMGKMLmVWK4ym9ApQTvp9Rff1oz9GdLaAcm6VM19y
         OhOYeU8VC46GuyZ2BOOVGZ3W8v2JRgejhwwBA=
Received: by 10.204.5.217 with SMTP id 25mr2551897bkw.114.1265449214683;
        Sat, 06 Feb 2010 01:40:14 -0800 (PST)
Received: from yakj.usersys.redhat.com (93-34-208-53.ip51.fastwebnet.it [93.34.208.53])
        by mx.google.com with ESMTPS id 16sm1051099bwz.3.2010.02.06.01.40.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 01:40:12 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <20100205231112.3689.67634.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139154>

On 02/06/2010 12:11 AM, Christian Couder wrote:
> As "git merge" fast forwards if possible, it seems sensible to
> have such a feature for "git cherry-pick" too, especially as it
> could be used in git-rebase--interactive.sh.
>
> Maybe this option could be made the default in the long run, with
> another --no-ff option to disable this default behavior, but that
> could make some scripts backward incompatible and/or that would
> require testing if some GIT_AUTHOR_* environment variables are
> set. So we don't do that for now.

I would still like to have a no-op --no-ff so that scripts that do rely 
on that can be future proofed (or also, scripts that do "git cherry-pick 
$blah -e COMMIT" could use --no-ff to avoid errors in case $blah 
contains --ff).

Paolo
