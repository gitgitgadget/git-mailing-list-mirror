From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 21:48:29 -0500
Message-ID: <76718490902131848sb335b8bn2694c3e569aa1acd@mail.gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-5-git-send-email-jaysoffian@gmail.com>
	 <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
	 <20090214002253.GA7769@coredump.intra.peff.net>
	 <7vab8p4w1u.fsf@gitster.siamese.dyndns.org>
	 <20090214021831.GB9907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:50:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYAbP-0003wL-EE
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbZBNCsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753682AbZBNCsb
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:48:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:59948 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbZBNCsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:48:30 -0500
Received: by rv-out-0506.google.com with SMTP id g37so898742rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 18:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Oppx/m+5W01SfHVqVgv2A7hvx+yXnlARD7for3zxk8=;
        b=UYTf3W+ll7sFi1OSMdGoZwCiD4kJ4aEazcBK1yM7sr8bgFTnsffNVZL7E/JDCjrv1H
         Nq0mGGC6cRwVr5yDlpvNPaBoWUdw3gSQwqgWY8zM5g4OfWI65PuglqlHAuflHwsMRpte
         Sj//hrmRoHl9vC08czxuL4c++BwWDpxU2xZg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wy2Tys8KVEVLIEofqZfInQGIXsA6Gfx/xUAQ6Q4UqydS0Fy7Ww+LOuN87nhl9NmUGL
         V1wIJEimg1uUGp9H1mTuUECrT9Z8wyewSDRegD7Wx2BWHPkZemtXB+7gsACAc1NRVCn1
         P+IpN6eZ5tfJaGrnT4NyykYn2B3VV2XQQ1/7A=
Received: by 10.141.84.21 with SMTP id m21mr1448075rvl.118.1234579709657; Fri, 
	13 Feb 2009 18:48:29 -0800 (PST)
In-Reply-To: <20090214021831.GB9907@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109810>

On Fri, Feb 13, 2009 at 9:18 PM, Jeff King <peff@peff.net> wrote:
> Test #8 is just a matter of updating output. But #18 is explicitly about
> checking that "remote show" does not show symbolic refs. But Jay's patch
> is about explicitly showing symbolic refs (just doing so as a ref-name
> instead of a sha1):
>
>  * FAIL 18: "remote show" does not show symbolic refs
>                git clone one three &&
>                (cd three &&
>                 git remote show origin > output &&
>                 ! grep HEAD < output &&
>                 ! grep -i stale < output)
>
> I guess we could tighten the grep to
>
>  ! egrep "HEAD: [0-9a-f]{40}" < output
>
> but it may just make sense to get rid of the test; the exact output is
> already covered by test #8. Squashable patch is below.

Thank you Jeff. I swear I ran t5505-remote.sh successfully but
obviously I am misremembering.

j.
