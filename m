From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/3] completion: fix alias listings with newlines
Date: Thu, 08 Oct 2009 01:01:42 -0700
Message-ID: <4ACD9C66.1080308@gmail.com>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com> <4ACC6055.1070204@viscovery.net> <4ACCE417.5080907@gmail.com> <20091008042917.GX9261@spearce.org> <4ACD961D.9080401@gmail.com> <4ACD9ABC.4070809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 08 10:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvo3p-0004ZN-Mc
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 10:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbZJHIAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 04:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbZJHIAj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 04:00:39 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:59098 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbZJHIAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 04:00:38 -0400
Received: by qw-out-2122.google.com with SMTP id 3so2139188qwe.37
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=IIDKBA3mKQ1bB1wxjQ8bMhdhfW0ije4ZjtJQ0PVWn+c=;
        b=ToI1ffQrklYvzIrHg5qu2qz9EIrm+Nd6oHfSJr94y6wUax/cb/qVb4GumYeHDSGiPk
         BmQemFetZoJC75kukrUmPMHSh0xEwQ3aQL/bKRcxEynIggrGJFAfMUv38TO/aoUZieMA
         1bqnCN0ebwDO+YU0wJS6Ogp6EHfn++xiMTmZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=WWMJYC/nW/Bi+xCndMI5srUuVZZBkBm6P5Y3YSKmPl5ko08d6o+qlhdqZeyH79Hk/M
         ekkEkK7MrN0+P30MiaSo1ZSVIKgUJ4h2kPtEIJ6IgupzqOZDCwSLTPluh+D/E4u0jrCv
         QBlQYG/q5MTIeKTTVGBjcQphLi27csMU81Lf0=
Received: by 10.224.12.198 with SMTP id y6mr801459qay.207.1254988771062;
        Thu, 08 Oct 2009 00:59:31 -0700 (PDT)
Received: from ?192.168.1.2? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 7sm367074qwb.55.2009.10.08.00.59.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 00:59:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <4ACD9ABC.4070809@viscovery.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129681>

Johannes Sixt wrote:
>
> OTOH, you can simply revert the hunk from 518ef8f (completion: Replace
> config --list with --get-regexp, 2009-09-11) that applies here, or even
> only reinstate the case statement in the loop body without changing
> anything else.

I'm not opposed to the idea, but then it wouldn't work with something like

[alias]
    whowhat = "log --format="%an\nalias.broken=foo'"

although that actually happening is probably rare, it can still happen.
