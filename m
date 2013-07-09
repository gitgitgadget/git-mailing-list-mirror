From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 9 Jul 2013 12:21:19 -0700
Message-ID: <20130709192119.GY408@google.com>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
 <7vk3l26695.fsf@alter.siamese.dyndns.org>
 <CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
 <7v38rnwuvb.fsf@alter.siamese.dyndns.org>
 <87ehb7d3za.fsf@hexa.v.cablecom.net>
 <CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
 <7vy59fv9zr.fsf@alter.siamese.dyndns.org>
 <87a9lvcztv.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 09 21:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwdTb-0001e8-Je
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab3GITVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:21:23 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:63218 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab3GITVX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:21:23 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so5550578pdi.13
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=U78a43OCa7TIPnbDMbHGWogcA9pfRmWJS8u7Alz/Tqk=;
        b=raGmdAr5hasfs6C9sBHkiO5qxPq6JiPbXh8qEEhKvUqfbHmUDibvnNQFOeiKNB+qO/
         C2/+Chm9o8w+VqDKmn60L9eYqwdsRkMYuyUKH2nqmEzqftFLt+VxCIeVa5JmgtI9u+Hw
         FQwOGe7mK9Q/B1pr6GwVgLdfnJfEJwhS/UzxUiud4ymH3IwxdEKBgB+yvPK2hOVjsN0H
         gGxXa1+Yc6p6qDb2Zqy9aueGtkJdjYMQ8JDkIUy+ZNwuF4B1mtBscv1sYX3YREHwO5vS
         kyzFTF6zqgJN8Ev6jnw3zc8X6sf66VbqRh6rT82LcxWhIsezTEQEpNyogbKpWm50YE0d
         Bs8g==
X-Received: by 10.66.246.194 with SMTP id xy2mr24925352pac.131.1373397682660;
        Tue, 09 Jul 2013 12:21:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ep4sm2133998pbd.35.2013.07.09.12.21.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 12:21:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87a9lvcztv.fsf@hexa.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229982>

Thomas Rast wrote:

> If you define it that way, the output of
>
>   git blame -L 4,6; git blame -L /A/,+20
>
> is significantly different from
>
>   git blame -L 4,6 -L /A/,+20
>
> Not just in the presentation or any possible coalescing, but in the
> meaning of the ranges.

I can see both meanings being useful.  I suspect that the "restart at
the top of the file for each LHS regex" meaning would be more useful,
though.

Thanks,
Jonathan
