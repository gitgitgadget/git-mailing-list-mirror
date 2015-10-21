From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 23/26] initdb: move safe_create_dir into common code
Date: Wed, 21 Oct 2015 15:47:40 -0400
Organization: Twitter
Message-ID: <1445456860.8302.15.camel@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
	 <1444938410-2345-24-git-send-email-dturner@twopensource.com>
	 <xmqq37x4vwon.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozN4-0001d3-1d
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbbJUTr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 15:47:57 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33877 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbbJUTro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 15:47:44 -0400
Received: by padhk11 with SMTP id hk11so63388735pad.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 12:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=+BtASbDTQTDg79eSNq3WbG/IqXXm5ljk0N7SSoCi3rI=;
        b=lkBcliTcrjqitZLvAwU0lHG6ts1WAuBqXsRPztXl/VlmZIyQBnl+isv+uyqGDmPSNu
         Fs6Kte/2C67maIo08okVX35pWvYlmN64+zwFgE9Y1wmV7x2K0Gn9dWgSne4DDxUwSNSJ
         zF7khTm27YxZq3Xc8zaP4rpIOcTtTh6Kaj/57vRaq+/WKFm9hXsKVw6OmQkJN260fFun
         sZA2ht78m+YyJd59sk5wq1z9Adta+apayspIu1FdNwv39t64UoXbObhsUE8rOtpzXACc
         3YE45kUU9mnpBMEN0+NfR4zICme/nah9PBnecmHTN43HmgOe9eQJe8XLt7w61yOdjDq3
         cu1Q==
X-Gm-Message-State: ALoCoQnI2wFBBWpAcXDfEr35iqwtBYlTXzij8R2oZhV8ic3e13FrTDhaMCoEjugH8+uv353T77fK
X-Received: by 10.66.160.194 with SMTP id xm2mr12252120pab.111.1445456863611;
        Wed, 21 Oct 2015 12:47:43 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id ah2sm10591935pad.10.2015.10.21.12.47.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 12:47:42 -0700 (PDT)
In-Reply-To: <xmqq37x4vwon.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280003>

On Wed, 2015-10-21 at 12:38 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > In a moment, we'll create initdb functions for ref backends, and code
> > from initdb that calls this function needs to move into the files
> > backend.  So this function needs to be public.
> 
> OK, but unlike the static function, being in public interface part
> can invite mistakes of using this for things outside $GIT_DIR [*1*].
> Let's have "Never use this for working tree directories" somewhere
> in its docstring.

Will fix in the re-roll, thanks.
