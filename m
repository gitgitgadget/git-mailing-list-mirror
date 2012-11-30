From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Fri, 30 Nov 2012 08:45:51 -0800
Message-ID: <CANiSa6i2f-4jXFUpYV6+fYnpG-tSRRA3cRg_v-v=UrgfwfFz_g@mail.gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
	<1354213975-17866-1-git-send-email-martinvonz@gmail.com>
	<1354213975-17866-2-git-send-email-martinvonz@gmail.com>
	<7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
	<7vzk20p6ik.fsf@alter.siamese.dyndns.org>
	<CANiSa6hWYsfm0t+s_q7=CcD78yNfpuduxkRc35xW8qDOy97W3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 17:46:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeTj6-0007hE-0E
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 17:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561Ab2K3Qpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 11:45:53 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35192 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab2K3Qpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 11:45:52 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so342891qcr.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 08:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4sndch+JZIPTumA+acV2guYdT0+A103X2IG4TKSSgGE=;
        b=kugxHyEenR1Q/fi89Wold0PvfZAiE3CWZMvQ46uCdtlxnUxqkJhudLPHBGsO7J2sZu
         YjMwIXtv+fjZaNWKyW/ZO02yz620v3zOqSpg+M3B4CusF95D2oTGkZ6ImKQcrL06mRHE
         2ElkHKZgSZlTiOy4jMAUnfDfMVXdWJoPbtQoBwTNqWr7CltlTyw1U36P5JwL2EaQK6MN
         AQ2wD9qk5AXfudI+VBWh0x5ckJ7Qd5tkOu4wixQz2NSCOOhW4scpLEiZWWqRC74dN6tc
         8AditbuDnlq9YeqXQbmgjT2NymySeOet6njmP1Iy8s1AxequGbMNegZr/u2sQwJjQcT4
         torw==
Received: by 10.224.27.212 with SMTP id j20mr4073280qac.1.1354293951799; Fri,
 30 Nov 2012 08:45:51 -0800 (PST)
Received: by 10.49.2.195 with HTTP; Fri, 30 Nov 2012 08:45:51 -0800 (PST)
In-Reply-To: <CANiSa6hWYsfm0t+s_q7=CcD78yNfpuduxkRc35xW8qDOy97W3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210929>

On Thu, Nov 29, 2012 at 2:00 PM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> Slightly off topic, but another difference (or somehow another aspect
> of the same difference?) that has tripped me up a few times is that
> "git checkout $rev ." only affects added and modified files (in $rev
> compared to HEAD), but "git reset $rev ." would also delete deleted
> files from the index.

Actually, what is the reasoning behind this difference? It almost
seems like a bug. I think I have just thought it was too obvious to be
a bug before, but thinking more about it, I can't see any reason why
"git checkout $rev" should delete files, but "git checkout $rev ."
shouldn't. I hope I'm just hallucinating or missing something. Can
someone shed some light on this?
