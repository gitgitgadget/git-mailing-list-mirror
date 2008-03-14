From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 04:21:39 -0700
Organization: Google, Inc.
Message-ID: <20080314112139.GA12846@bulgaria.corp.google.com>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org> <2008-03-13-20-05-55+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 12:26:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja83s-0006hm-EL
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 12:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYCNL0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 07:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYCNL0R
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 07:26:17 -0400
Received: from smtp-out.google.com ([216.239.33.17]:35030 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbYCNL0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 07:26:16 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id m2EBPZtl025768;
	Fri, 14 Mar 2008 11:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1205493936; bh=Sz4uUczp9ekNAuOAqelZ3U+2O6A=;
	h=DomainKey-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 Organization:User-Agent; b=fAFJ5WH5MNTx9/3AZQ76ybU79LceSaIS/kq58ch
	yyQKCOBbaS0RkOejW5SkTFNG3hQc+Huw2Vi54TRXksfjvNQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:in-reply-to:organization:user-agent;
	b=UzdCzFcbw/vQE/j9nPw0wq3bOV+7MhAFsYN2c8YzRV/FMsiWfJBWxcdEnlsNSmfAY
	csYRm0CEmF00eAaM4Zspg==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps75.corp.google.com with ESMTP id m2EBPWRP007832;
	Fri, 14 Mar 2008 04:25:34 -0700
Received: by bulgaria (Postfix, from userid 1000)
	id 503841224A4; Fri, 14 Mar 2008 04:21:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2008-03-13-20-05-55+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77209>

[Samuel Tardieu <sam@rfc1149.net>]
> On 13/03, Junio C Hamano wrote:
> 
> | Samuel Tardieu <sam@rfc1149.net> writes:
> | 
> | > Add MIME-Version/Content-Type/Content-Transfer-Encoding headers in
> | > messages generated with git-format-patch. Without it, messages generated
> | > without using --attach or --inline didn't have any content type information.
> | 
> | Isn't that job for send-email (or user's MUA)?  I really do not think we
> | want to clutter format-patch output any more than necessary.
> 
> Only format-patch knows what encoding has been used by itself to
> generate the message. Doing it at any later stage would have to guess
> what the correct charset is.

When the encoded string is entirely ascii except for one or two characters
(such as occurs in a lot of patches I handle from people with names
not represented in plain ascii) guessing later on seems to run pretty
high risk of guessing wrong.

I've taken to manually adding UTF-8 content-type/transfer-encoding
headers to avoid the routine mangling of my coworkers' names and
would welcome a change to do this automatically.

Considering that UTF-8 is the expected default encoding (right?) for
git metadata, it seems to be the sane thing to indicate if the default
is unchanged.

Brian

> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
