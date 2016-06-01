From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Wed, 01 Jun 2016 15:50:29 -0400
Organization: Twitter
Message-ID: <1464810629.3988.11.camel@twopensource.com>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
	 <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	 <20160601074218.GB14096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:50:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8CA1-00030E-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 21:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbcFATud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 15:50:33 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33377 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcFATuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 15:50:32 -0400
Received: by mail-qk0-f176.google.com with SMTP id n63so23220995qkf.0
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=5qgNtdIM+HlW0QFRM+z/i2Ytw/hGzpFYFvXUt/CdZR4=;
        b=Uwn/yaH03+P9YWbjGyRzYkIPIBGVbZM2SpYjZkVUAfmhdvTNhl93f2UDr23vwN3r+Y
         t5I/YJH1apLh3ELXUv6oZbyNm6/q0rbKcf4UKUZx1P2b1udXFCR6rz02P4vVHnGS53Z1
         /puuV0CT29FCMwDRIoXTJHCOt6Undb1pH1CHH7lhwv84IoAZxuqaYPbPZzAbdsfxjR5O
         RZj2Lg0c45J82E3TD3nqqC+KjTBJYMJHXyTuqLY/htvpoZQLbUnqmYp8Cg7VU9S970wZ
         Wozm+TlSGeUmidEAdhsZD61u4AlYS5fBzrIGf5vJNM8xDYnslm2lay9wUBdxUlpuKO3i
         BBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=5qgNtdIM+HlW0QFRM+z/i2Ytw/hGzpFYFvXUt/CdZR4=;
        b=CLCsighuPq3cUBf2nck8oHtvBeU9QfBKjSwhvIK5d/dLVOCE+qk93DVyvDvqkVryF7
         jQz7eEfUDZquwX+vyjd+aK10n7KNCD+zNhvqclKsHvxQtECuf1Om2Aj7+h+vSQMt85zc
         iWdcp7dxe2FZwUtnX/70cQbF5QgQ+Cs/jkt/CWdRO8D1WIFsOEQj3OcJDvaYkCizZleW
         Q5ZpGv46EiZOCSH6GIXiC6ysVyXdkJVfxLn3neWAkQYCBIJ5+QvNaxTSnWc788BEaAPs
         EHeNxXiMFW4bjlfs6YCl494w36j5Rv1Hz7PDJhVgNtsDGgpgzPXSlbKgpjwpwbamdc/D
         Irvw==
X-Gm-Message-State: ALyK8tKBt3qjWaFi0qegaEUCHCvrfywkwCPD3pOC9apyJ2yf4nU+WBtETTfMn4woGd2fxw==
X-Received: by 10.237.46.1 with SMTP id j1mr5710329qtd.62.1464810631639;
        Wed, 01 Jun 2016 12:50:31 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id e32sm13001477qtd.33.2016.06.01.12.50.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2016 12:50:30 -0700 (PDT)
In-Reply-To: <20160601074218.GB14096@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296154>

On Wed, 2016-06-01 at 03:42 -0400, Jeff King wrote:
>   2. Do caching tricks for strbufs used in tight loops. For example,
>      have strbuf_release() throw its buffer into a last-used cache,
> and
>      let the next strbuf_grow() use that cache entry. This cuts
> malloc()
>      out of the loop.
> 
>      You'd probably want to protect the cache with a mutex, though.


... or make the last-used cache be thread-local.
