From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/3] rev-list: remove last static vars used in "show_commit"
Date: Wed, 08 Apr 2009 09:40:12 +0200
Message-ID: <49DC54DC.3060408@gnu.org>
References: <20090407040819.4338.4291.chriscool@tuxfamily.org>	<20090407040854.4338.94304.chriscool@tuxfamily.org> <20090407040854.4338.40055.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 09:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrSQ9-0007Ew-K8
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 09:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759445AbZDHHkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 03:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757775AbZDHHkH
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 03:40:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:41370 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbZDHHkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 03:40:05 -0400
Received: by fxm2 with SMTP id 2so2657772fxm.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2M5RlvXT9Jr2aAkh4cvS80WhBhoFYOSxwPmpgU1nA/k=;
        b=tcPs7oLncgwSfIBXfZB0iVbvGWxiIV9GVgtJt2+txkmvh7W+MMDMO9JObhT8ocATqb
         NgrSzxltg39Y68405EwQ01Sfx0AYt/1lat/SxM07q/bC5Wt5e8UsnuOkQ0A3WwZI74PI
         mLfLiBwSaZ6jApKyhV6/iZsjRQV2DhB4X+stQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=g2Ryqi3+/xS05TBS1pKrUhDNVN3+Xo3zyrip+CWAW+4OuGIk3DZ17rmmIKUncD+IhY
         j4i1ffvRBRvpqN8QnKbzP/wEic1/WKCL9xDawcCbtFlDcA9Z8CtFQPgrqYxgEOvYEr+5
         YkOIXw6XRm+o0QHtq8waiW0BPA7ORF8Kn4EpM=
Received: by 10.86.79.19 with SMTP id c19mr848038fgb.20.1239176402718;
        Wed, 08 Apr 2009 00:40:02 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ([195.176.179.202])
        by mx.google.com with ESMTPS id e11sm9773582fga.25.2009.04.08.00.40.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 00:40:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <20090407040854.4338.40055.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116057>


>  	struct rev_info revs;
> +	struct rev_list_info info;
>  	int reaches = 0, all = 0;
>  
> +	memset(&info, 0, sizeof(info));
> +	info.revs = &revs;

Would it make sense to embed the struct rev_info entirely in the new
struct, without going through a pointer?

Paolo
