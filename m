From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 14:36:13 +0200
Message-ID: <48B54A3D.3080708@gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <20080826074044.GA22694@cuci.nl> <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com> <20080827091800.GB484@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 27 14:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYKHQ-0001wM-T9
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 14:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbYH0MgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbYH0MgS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 08:36:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:47278 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbYH0MgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 08:36:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1545422fgg.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=OSZ2cwkvT587d91jd3rNIYUPx7aIm2URnMljszIrvb8=;
        b=RBEC84hQAAa2RbZgDXzLyDZWYyPHXDpvU2HnveFoaRMwodIDINX4NmYWjyIxCM511A
         XHjo8NLoZ+eZrhvqiZXHW98X4dJb+C/Ocs8vvXrESTo6Hy85t4LWT8HLxU82ovYL3/Su
         Lgybu2bd4CMz5uGT/+ZrcK4jfNIZwHbBIfOeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=LIJFndQ2FE8SRjXZcE/AVR7HzwxJgopLNAOgAIkAEobERW/qT5BAmRRVDnzsJvDwPw
         nOLbzGPk7/5ZYC+iJ4sSajeUv3Iydbk89lbIJowEldEkj3g5QWRCtvklo6SL2qZu2S3j
         UxpVIQAYxqOY28ZJkoWFm5MqPr6MoaNDN3/1I=
Received: by 10.86.23.17 with SMTP id 17mr19504fgw.44.1219840576236;
        Wed, 27 Aug 2008 05:36:16 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id e20sm7387243fga.1.2008.08.27.05.36.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 05:36:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080827091800.GB484@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93890>


>> But it's harmless to have both.
> 
> Considering the fact that daemon authors might not get pointed at their
> mistakes as soon as possible, it is harmful to try and hide those facts.

Agree.  OTOH what about opening fd's 0/1/2 to /dev/null only in
git-shell.c, now that it's not a builtin anymore?

Maybe it does not fix Karl's use case, but it seems sensible to me.

Paolo
