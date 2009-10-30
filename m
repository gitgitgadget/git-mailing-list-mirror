From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC PATCH v4 11/26] Move WebDAV HTTP push under remote-curl
Date: Sat, 31 Oct 2009 07:20:03 +0800
Message-ID: <be6fef0d0910301620x2e80864ft67b7d067b00005f2@mail.gmail.com>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
	 <1256774448-7625-12-git-send-email-spearce@spearce.org>
	 <be6fef0d0910300910me43c77fue6dcb6034dd0ea5b@mail.gmail.com>
	 <20091030190655.GA7442@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Oct 31 00:20:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N40lO-0000QU-Rv
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 00:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbZJ3XT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 19:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933036AbZJ3XT7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 19:19:59 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:45856 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933028AbZJ3XT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 19:19:59 -0400
Received: by iwn10 with SMTP id 10so2492141iwn.4
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=AQceOikgvxvXmFaQ2BnwnvtnLV+dJH+B4TMX15GRUEs=;
        b=gvbjwa3UV3GLgb78RZ4p/GAAnWQCVpWaJxH7DJzNGfhK6MQXAIG0vhOsN6zSBPazB0
         LJFApGQ2truE5yWdKLwwkqWNnRWFs+6dQQw6vH0djeTqSyhJgDta9UN18cLOYN6Tg8ui
         BmxMpW7VBFM0fAzqLajYlTdimCr388x2WOGAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=i2r1qzLa+WsQ/bj+L2W9C3D0cLf8CQ1Ozc1UP4MmuZBCWxUMiiPAbtU3bzA637RZHK
         lQTp2RmMeeh6zm5ahESjWcH3VlfER5Qm6kWZHKLlG1Kty67uynBDCiZXNm7mcQKUU1Tt
         8cES2+rUPyH1pR/yEMBm/A/VftsXZ4DbuA9P0=
Received: by 10.231.125.28 with SMTP id w28mr4733198ibr.50.1256944803641; Fri, 
	30 Oct 2009 16:20:03 -0700 (PDT)
In-Reply-To: <20091030190655.GA7442@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131776>

Hi,

On Sat, Oct 31, 2009 at 3:06 AM, Clemens Buchacher <drizzd@aon.at> wrote:
> How can the changed result of one test suddenly make another test redundant?
> The two are testing different things.
>[snip]
> No, 'git update-ref' correctly reverts the earlier push, so we can push again
> and 'git update-server-info' is therefore necessary for the test to work
> independently of its predecessors result.

I said "redundant" because in the first push, we've already 1) updated
/refs/heads/master (which is what the 'git update-ref' here does) and
2) updated /info/refs (which is what the 'git update-server-info' does
and 3) pushed changes. To me, the "unpacked refs" test reads as a
trivial test of http-push's ability to update /refs/heads/master and
/info/refs (something we've already done in the first "packed refs"
test), rather than its pushing per se. Is it your intention to keep
the "unpacked refs" test due to the former?

-- 
Cheers,
Ray Chuan
