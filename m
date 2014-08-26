From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Tue, 26 Aug 2014 19:22:30 +0200
Message-ID: <CAPuZ2NGTQoKnSfeN2zte5=fqswN5PcfAULdFy9WnGWPtc2Zskg@mail.gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
	<20140825194430.GI30953@peff.net>
	<CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
	<CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
	<20140826122008.GC29180@peff.net>
	<xmqqmwarjiq7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKS3-0002XD-AD
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbaHZRWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:22:31 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34599 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbaHZRWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:22:31 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so23742357pab.6
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mjzwqnPPnzj39k2yMpoOl8p6pbCaRzdL/SlDHy1ruaw=;
        b=EdW3D2N3Bn3jzk96QjI8ENz0WYVLZtWRpXZPTRMYYbomyCgzl4WfDUr1VF07q70DZj
         2lpqC/h/+R2M8blboovAlF6OjsYundeO3D73032dLlW4NAMQSNPbU3RnFq3knsufIF6V
         8/cuQs7QblNVkhJsDRsXupSyQ77BWLv7/vEe8aW68hgx4oICOu5wXXRN1Lid7OeCgkax
         3yZSjVuVbfjo7dR9rtUuEB5O3V5qyzjZizoaKzsbgEwNJjbFR4pt1Lt+tS+SSwB55aMy
         P9d/NIKCeQDuKd0idKMcEtUiDNRLVYHQbwUEcCYZIdcrYyjkz1E9aaLjZNiVMqnPAVk0
         2Veg==
X-Received: by 10.68.215.67 with SMTP id og3mr39142726pbc.30.1409073750590;
 Tue, 26 Aug 2014 10:22:30 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Tue, 26 Aug 2014 10:22:30 -0700 (PDT)
In-Reply-To: <xmqqmwarjiq7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255921>

On Tue, Aug 26, 2014 at 6:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Yes---that is what I meant by the "virtual stuff".  Unlike resolve
> work by Daniel (around Sep 2005 $gmane/8088) that tried to use
> multiple ancestors directly in a single merge, recursive limits
> itself to repeated use of pairwise merges.

Ok, I see now. Then what about checking also in check_ce_order() that
only stage #1 can be repeated?
