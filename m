From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Try an uppercase version of $prot_proxy env var
Date: Thu, 26 Apr 2012 07:04:26 -0700
Message-ID: <xmqqipgma8t1.fsf@junio.mtv.corp.google.com>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
	<4F966F0C.6090504@seap.minhap.es>
	<xmqqipgpgdpl.fsf@junio.mtv.corp.google.com>
	<4F994AC3.2070708@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Apr 26 16:13:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNPRl-0001IX-PO
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 16:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606Ab2DZOLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 10:11:30 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:37553 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab2DZOLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 10:11:30 -0400
Received: by qabg24 with SMTP id g24so284175qab.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 07:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=t2DZ4b6RsVLJNZkETXK+MPFrjTFUPxX6jwDfs54+Cgg=;
        b=UQydI/QsNKXQaw9BUGtf7RFVyDo0GxNFXRbBNwhwqXz2Mf+rwlePYrHgPup2gSsS5l
         LtI6+68b0QevEN3eAPvO/wowmEvBERU3Pg4S9Crag6aJWr0lgAfarK/C179bK9X2Svsx
         Nmda5cq+C/XEE+GHBcpqwH5+M9QNF0rPwS9Kk8h0NasroEIphWXda3QmwoNEmnSI6IuA
         vIz1+COLc35rdr0KGgPn8whmzdBXOU00jUXihuTVR9sm9L2Pu9WINH8fKqoZXPAMzAlq
         qDSNHslWh2h/BvwPSiu1BZvvoJ6gW5efONjRv0dlLO79/KunHg3be9id6GM6Xv7JFo42
         89Cg==
Received: by 10.236.153.5 with SMTP id e5mr8479982yhk.5.1335449066976;
        Thu, 26 Apr 2012 07:04:26 -0700 (PDT)
Received: by 10.236.153.5 with SMTP id e5mr8479966yhk.5.1335449066908;
        Thu, 26 Apr 2012 07:04:26 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id d47si3191008yhl.6.2012.04.26.07.04.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 07:04:26 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id C649110009F;
	Thu, 26 Apr 2012 07:04:26 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 6E661E125C; Thu, 26 Apr 2012 07:04:26 -0700 (PDT)
In-Reply-To: <4F994AC3.2070708@seap.minhap.es> (Nelson Benitez Leon's message
	of "Thu, 26 Apr 2012 15:16:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmGFRfaN+x8XkQkuRD6eX5hJBX8t05g0D0BY7GwcEZ4l1FKxArjYdpky278ZSpr8jnIbtRUc2Do1a4QT2bFTPoBsOGsaznQ2vmIUEjWVtzUGik+AuO3JR6SBtRlspOaAG415/wvrpmva5yHDA7GykfFIF5kGf6ZeiAaczDMS5fCTICRcFI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196370>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> Try an uppercase version of $prot_proxy env var when thelowercase version 
> is not found.

Yeah, something like that, but you should be careful not to try the
uppercase HTTP_PROXY which cURL explicitly ignores on purpose.
