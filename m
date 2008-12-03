From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [PATCH 4/5] support reading uncompressed loose object
Date: Wed, 03 Dec 2008 12:09:43 +0800
Message-ID: <49360687.4060701@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org> <493495B4.5070304@gmail.com> <20081202155806.GM23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 05:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7j4s-00076c-GV
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 05:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYLCEJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 23:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYLCEJu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 23:09:50 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:12337 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYLCEJt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 23:09:49 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2115846tic.23
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 20:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ZBpdfCm/hVm3kJGo+dnPJNrfBbbGKQEiWSJqzIn4iCU=;
        b=b0HLv0Aj76u/nQ8bXBbMxeCkbfr0XIYY0NHgcWgg4m5ujFXkD8DwStGVBEFtHRQdVH
         diseO5ux9CaNrk6wmTJBnBYMV3cO+cKHTby3MlnQ2oLMnEl+BXLIRH3mwZcDcPdgtQcY
         Em+ueSr5YiiFGgZGcv4MAOQdmV0v5p79gBKEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WQPIjHacv4nDH4qd8KHboqeYUAK9CMMRPhq69c9x6AIuFDlZ8VtaABQTS8vcx63847
         Aue3fFw800kuOPv03A4OXYk+iZ3tFLQlct4mnC1VpRACJBPsGQBowAcQP9/M4BTID/zv
         mq/4R9Csrm3NiyBVZF9E0i56EMdxgKtz7NeYg=
Received: by 10.110.63.17 with SMTP id l17mr4117084tia.40.1228277387684;
        Tue, 02 Dec 2008 20:09:47 -0800 (PST)
Received: from ?10.64.1.78? ([211.157.41.194])
        by mx.google.com with ESMTPS id a14sm738223tia.12.2008.12.02.20.09.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 20:09:46 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20081202155806.GM23984@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102213>

Shawn O. Pearce wrote:
> Liu Yubao <yubao.liu@gmail.com> wrote:
>> Signed-off-by: Liu Yubao <yubao.liu@gmail.com>
> 
> I'd like to see a bit more of an explanation of the new loose
> object format you are reading in the commit message.  We have a
> long history of explaining *why* the code behaves the way it does
> in our commits, so we can look at it in blame/log and understand
> what the heck went on.
>  
I mentioned in the cover letter sent as patch 0/5, indeed I should
have mentioned it in the commit message again.

An uncompressed loose object is just an uncompressed loose object:

loose object = deflate(typename + <space> + size + '\0' + data)
uncompressed object = inflate(loose object)
