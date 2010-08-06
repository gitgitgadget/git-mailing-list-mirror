From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH master 0/2] fix "check-ref-format --branch" from subdir of
 toplevel
Date: Thu, 5 Aug 2010 22:34:11 -0500
Message-ID: <20100806033411.GQ22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 05:35:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDim-0003vX-Er
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761051Ab0HFDfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:35:36 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61856 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab0HFDfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:35:34 -0400
Received: by yxg6 with SMTP id 6so2718322yxg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hqOoX+JcTwWdaoNgIRE84Roe53QUkf1DApUrcOybtgw=;
        b=t1AwC1IN4hX3CdDoMy1w37uBgHucvKcSWb6EDbXjJE+EXyrl0nwHHYIF9Tp5zLI4Fd
         Tjq63bVcrcRusanLxBvhXpNbCosgT+Bf2Qy8Mo1/b14BMf4S+3CRK6ooqmPOjuCbervU
         ZKOpafUHNE44qPk/r0vqrP5HRRuSf4j5Ut8SI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kMagVO06JlZIc9albDZhUtm3krnKQXz6vXCfaSuxo/4DAfokkG83I3GGF0LVmjj/rn
         MxWUR/pXFapjINr0D3Gwp6s5urLe6LexeZ9i/WG01Vh7kWO9n95EiCac7Atm57Xmswe0
         Q09pq126PwO5faNxy474ezzsfKuvjd38+dwsU=
Received: by 10.100.151.11 with SMTP id y11mr13058588and.4.1281065732149;
        Thu, 05 Aug 2010 20:35:32 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id k11sm1315698ani.30.2010.08.05.20.35.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:35:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152759>

Here=E2=80=99s a quick fix from the nd/setup series.  Tested against ma=
ster,
though it probably should be against maint.

Jonathan Nieder (2):
  check-ref-format: split off functions for subcommands
  check-ref-format --branch: run repository search

 builtin/check-ref-format.c  |   44 ++++++++++++++++++++++++++---------=
-------
 t/t1402-check-ref-format.sh |   17 ++++++++++++++++
 2 files changed, 44 insertions(+), 17 deletions(-)
