From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 11:54:06 +1200
Message-ID: <46a038f90808131654r228a1b57y964f7cdb9c77be5f@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
	 <87vdy71i6w.fsf@basil.nowhere.org>
	 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
	 <20080813031503.GC5855@spearce.org>
	 <70550C21-8358-4BEF-A7BA-3A41C1ACB346@adacore.com>
	 <alpine.LFD.1.10.0808131036590.4352@xanadu.home>
	 <m363q5t152.fsf@localhost.localdomain>
	 <20080813150425.GC3782@spearce.org>
	 <e1dab3980808130826m4870df3ctf09ecf0062ef6e7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, "Geert Bosch" <bosch@adacore.com>,
	"Andi Kleen" <andi@firstfloor.org>, "Ken Pratt" <ken@kenpratt.net>,
	git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 01:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTQBN-0006Pt-2V
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 01:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbYHMXyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 19:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbYHMXyI
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 19:54:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:59740 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYHMXyH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 19:54:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so305197wfd.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rUevlIK7FVoLZRb3+XCwPUYgQKt0jQAybgHWJQqKUjQ=;
        b=RLPf7+BXOPblLnlSGYsM85aMTtT/hV4JZ6n24dam6oKDVcsnjqtH7JJpsz//6HNVMQ
         Yq0ttPTy8rbSxJJiyLmqvYfP/YeViV4VhDhF6ZmsJ42xCxNw1luLVgORO2YY8vXDNzw8
         U24l+ghTyKQIwzM5mCJbUolE2rlg5wv5B5lKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Fzs5FXPb8E4C6knuUabXyrEq05+h4A2roB/TgTFJHl/YY67JRN+jj/Hae/bBLEiOMn
         6Ox9PSeI1Cha9tHEik3TR/e2gT1+SqVh3euA420E2pR2iasFqeIYrhfIXU4uRWLK023g
         xzmfs8Tf36IbeokUvdRYu1Efs3RFUJudzOMdw=
Received: by 10.142.135.16 with SMTP id i16mr175915wfd.286.1218671646122;
        Wed, 13 Aug 2008 16:54:06 -0700 (PDT)
Received: by 10.142.43.6 with HTTP; Wed, 13 Aug 2008 16:54:06 -0700 (PDT)
In-Reply-To: <e1dab3980808130826m4870df3ctf09ecf0062ef6e7c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92294>

On Thu, Aug 14, 2008 at 3:26 AM, David Tweed <david.tweed@gmail.com> wrote:
> FWIW, PDF format is a mix of sections of uncompressed higher level
> ASCII notation and sections of compressed actual glyph/location data

The PDF spec allows compression of the "text" sections - if a PDF is
uncompressed, it's a good candidate for delta & compression.
Unfortunately, within the same file you might have an embedded JPEG.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
