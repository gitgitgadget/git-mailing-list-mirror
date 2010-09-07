From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] t1303 (config): style tweaks
Date: Tue, 7 Sep 2010 00:27:59 -0500
Message-ID: <20100907052758.GQ1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
 <20100907015317.GG1182@burratino>
 <20100907043050.GA13291@sigill.intra.peff.net>
 <7vtym2p34e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 07:30:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osql1-0007mP-10
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 07:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab0IGFaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 01:30:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54375 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab0IGFaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 01:30:03 -0400
Received: by gyd8 with SMTP id 8so1835210gyd.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 22:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EIqHbVoe38rPnmEpoGfIF8FzPjukbrCZ9hDJunukBIk=;
        b=Sz291CUfyxAv/yZB5qlGGkiSJI55yZkpf8d/ByFZD3xql/P4VytJJRV8ogfq7BJQao
         XGEkpmu1etzJcRQ1cvQETJEMlcAB7GMGOmFDT7d0scfMP2PK3zS5j/3OWIpjL6e25HDG
         fbMYJuBXfrksOMDNvx733ezcuy0j5Qal9u+No=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DwJJ4rUon+dNmc1l4FJKh2Z6CXFcDW4fCIBeoMRlidSiCscmX2jMRe+NOvsvfG3wSq
         PBSNYNeb+C8BKPmKRv4mF30duXDtUpMRyILZt9IjP53xyraY3KtYaKxl9RhdwXKU+uDj
         wbUfy3svNG2n9Wru9YXFF1P2NeAj4tB6f6Xso=
Received: by 10.150.192.19 with SMTP id p19mr526347ybf.312.1283837402483;
        Mon, 06 Sep 2010 22:30:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e7sm4575105ybe.4.2010.09.06.22.30.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 22:30:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtym2p34e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155677>

Junio C Hamano wrote:

> My gut feeling has been that any set-up that uses "git" should never be
> outside test_expect_success, but things like cat <<HERE / echo to prepare
> test vector are not expected to fail (we are not in the business of
> testing the build platform) and can be at the top of the script between
> the inclusion of test-lib.sh and the first test_expect_success.

Such a strategy sounds fine to me, for what it's worth.

(so:

	test_description=...
	. ./test-lib.sh
	cat
	...
	mkdir
	cat
	...
	cat
	...
	test_expect_success
	...
	test_expect_success
	...
	test_expect_failure
	...
	test_expect_success
	...
	test_done
)
