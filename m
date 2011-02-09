From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Add support for merging from upstream by default.
Date: Tue, 8 Feb 2011 19:48:46 -0600
Message-ID: <20110209014846.GC24346@elie>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <20110208223359.GB17981@elie>
 <7vpqr2oyy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Bert Wesarg <bert.wesarg@gmail.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 02:48:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmzAu-0004qE-JH
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 02:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab1BIBsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 20:48:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56296 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab1BIBsv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 20:48:51 -0500
Received: by iyj8 with SMTP id 8so3900499iyj.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 17:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zgcXFAtdAlzoPkdJEeAN1jbSOVcKGHWAZ+Zm4zG8T8I=;
        b=DyWLQ+F+3ebIQfpFkPEdJLmzbWjlNZOWVL060HKdfqDyKH8J9T0g5LvueTmlDOmR2k
         cmewqYupBacJ3DyvoVC4tZ/tG/rJ+yYN/IkfMXkeq620E0X2tLwL4uSVeiGYwx15lEjk
         zJIoGH7wR2j5kFjaPwGtlnIr1n2T4ICQ3/3UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oLfjiAlFZoPMdNZG4FrS1GbrxWb0zTh4C0B5rsApnFri2i42NPKtR2BScuD16r1FIa
         hhNSKodpma3FKmQ2kE/WumoOVorAnyqhimljlRtZbZsB1jTi9Mml7in1cg30DUxwH3Xe
         gYKEkmy/id9/nrBku3U6yAN+tlXQY0wAkPuZQ=
Received: by 10.42.169.133 with SMTP id b5mr21222118icz.189.1297216130656;
        Tue, 08 Feb 2011 17:48:50 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id z4sm187994ibg.13.2011.02.08.17.48.48
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 17:48:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqr2oyy3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166386>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Could you give an example of breakage this configurability is designed
>> to prevent?
>
> I think there is no "prevent" or "breakage"; the patch is to give people a
> way to turn the feature on; without the configuration, "git merge" will
> keep the traditional behaviour, no?

Yes.  One answer to my question is that a person might try

	git fetch git://some/random/repository branch
	git merge

and at least for now it seems sensible to make that error out by
default rather than doing something unexpected.

In other words, another possible rule is "default to the last fetched
branch" (FETCH_HEAD), so the intent behind running "git merge" without
a branchname for the first time is not as obvious as I would hope.
