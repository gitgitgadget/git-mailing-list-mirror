From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [BUG] merge-recursive triggered "BUG"
Date: Fri, 20 May 2011 08:29:13 -0400
Message-ID: <BANLkTinqWzD=HXWArAOqvuAvzgOpynXPHg@mail.gmail.com>
References: <7v4o7260no.fsf@alter.siamese.dyndns.org>
	<BANLkTimNnRrJ_2UJUSWWd1QS=e0YH2p=_Q@mail.gmail.com>
	<7v1uzu5a70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ciaran <ciaranj@gmail.com>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 14:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNOpV-0002At-6H
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 14:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab1ETM3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 08:29:15 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47221 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1ETM3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 08:29:13 -0400
Received: by pvg12 with SMTP id 12so1643076pvg.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0HCm+OvhP/DWxL1ZKixPuvzixsckPJS1hXAh5GsvqJQ=;
        b=JjYOfhn5Sp5kAiSGX0q7B7RT0CUwpjrDuiJNvh8sHZProcrbh/PJmtwbZqf22qmWEB
         p/mYN1Rt0LxaRSP8e5Sa0CZyk35Pzuk9XX4MM4p5Ny1mgtf8ukRXYnMY3RXqK7VC+snq
         jZb7cFuh2bhkx8p7eJ2yLhwDXURZSKBZCUVsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qFv8WLGcT/dzoc9IyW+GwhXN/cf0ExGzSR7p1/sL9Tw0TI3ZOBFqSzITX8Ua1c0mV5
         Nzp3/vTIVMCwyCM4Bp1ekAdnnhSnTwOM8rzvbLt2Ow6sUf+YDuIYd6wL+heNVEnqBf7e
         Qnr7SlYrUWC7tbS8zbF2u2nOruOgUOOJPE4cY=
Received: by 10.142.107.12 with SMTP id f12mr2598812wfc.226.1305894553393;
 Fri, 20 May 2011 05:29:13 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Fri, 20 May 2011 05:29:13 -0700 (PDT)
In-Reply-To: <7v1uzu5a70.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174057>

On Thu, May 19, 2011 at 11:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I just ran into this. It's not in a repo I can share however. But, why
>> did b2c8c0a make it into master with this known issue?
>
> Because it was patched by another band-aid, and apparently it was not
> enough?

Okay, I didn't see the band-aid, but I didn't look very hard.

> You are the second person to report the same regression, so let's revert
> the merge of the entire topic, ac9666f (Merge branch 'en/merge-recursive',
> 2011-04-28) from master for now.

I went to confirm the cause, did a merge with v1.7.4-rc0~102
(106e3afa6f) and did not see the "addinfo_cache failed" message. But
now here's the strange part, I then switched back to master
(11bc3e92bf), tried the merge again, and I'm still not seeing the
"addinfo_cache failed" message.

So now I'm trying to figure out what v1.7.4-rc0~102 altered about the
state of my repo that I'm no longer seeing the message.

Hmfph.

j.
