From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.7.2] Please cherry-pick "upload-pack: start pack-objects
 before async rev-list"
Date: Thu, 26 May 2011 12:11:10 -0500
Message-ID: <20110526171110.GE24931@elie>
References: <20110404053626.GA26529@sigill.intra.peff.net>
 <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
 <20110406175413.GA8205@sigill.intra.peff.net>
 <20110406213333.GA18481@sigill.intra.peff.net>
 <20110526064547.GA18777@elie>
 <7voc2pxutw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 19:11:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPe5h-0005Ip-5D
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 19:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522Ab1EZRLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 13:11:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48542 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab1EZRLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 13:11:15 -0400
Received: by vws1 with SMTP id 1so698559vws.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zl7sfIMJYxsEZmA8H0AooyH8tnrEGbGmORvvPEfihaM=;
        b=aeImOJESi8grgmVnMwvAW5//pkll4Lm7F+G2ojgir83rS8iwGtewGvD4wFhyblCM1Z
         FYIG98V/NwbSG7gG6JEsMu6kaQiAunDQa8njd2XWovIsLiN2620R9SYBxyed05xuk+T5
         wmuRLSXlvEqNFUiAO/7rTIpyfW8cDvUIM689I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q22n2IWFoVbYTdsfXJYsDIDii98noXA+/sm0IU+o3piP5F9vNvbTAjX+BHxNoqPpfS
         RPKzcKx4O30fHFcBcxgMO2gj0f80QvakRbxbdWBJypxlcsVofVcM4NWwmuIqx9X94CsE
         YwL8gmcFYuoJErK+ukO1wemL0BLSV/vQJMT1Y=
Received: by 10.52.0.130 with SMTP id 2mr1590922vde.180.1306429874871;
        Thu, 26 May 2011 10:11:14 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id a1sm175365vce.24.2011.05.26.10.11.13
        (version=SSLv3 cipher=OTHER);
        Thu, 26 May 2011 10:11:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7voc2pxutw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174550>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> This server-side deadlock started being triggered by shallow clones
>> when sv.gnu.org upgraded to v1.7.2.5 a couple of months ago[1].  So it
>> might be worth thinking about how to help upgrade-averse server admins
>> to fix it.
>
> Upgrade-averse people can be fixed by keeping them closer to the tip, no?
> I don't plan to issue any more maintenance release on 1.7.2.X track beyond
> what is already released, unless there is a high priority security fix or
> something.
>
> Placing it on 1.7.4.X and newer maintenance tracks is a separate matter.

Ok, that's fine with me.  (To be clear, I was suggesting
cherry-picking to the branches but not making a release, though I
realize that would mean more time wasted the next time it is time to
make a high priority security fix.)

I'll cherry-pick it as a Debian-specific patch, which should be good
enough to get shallow clones working again on the affected servers.
