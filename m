From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/9] Add infrastructure to write revisions in fast-export 
	format
Date: Thu, 24 Jun 2010 23:14:33 +0200
Message-ID: <AANLkTimt-nKl_ibb0Ol925luTPwCAR0QJkKFuirDUDIx@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624110217.GG12376@burratino> 
	<AANLkTikyjq7HQY1hUTOGF_oBsGDj_jUI-GwDBRdacCzG@mail.gmail.com> 
	<20100624194927.GB2065@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 23:15:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtlK-0007nL-6v
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 23:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab0FXVO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 17:14:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62475 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab0FXVOz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 17:14:55 -0400
Received: by gye5 with SMTP id 5so4681699gye.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hn0UfuJ55DIvpGOHOR2GX74Q7OMh+C6D7W1xqldtoRc=;
        b=VwdiuCYU9QpdMfLgpGsL1ur1nqou23x2lrxPDgZrCEip3XLZ6uEWWNRlBIPURxFmg6
         5TJsT3Bw6smd3PrIGk23hoIwH1YKB+/zl2vUdcW1QdIh5/i2LmIIRCYeSWzhBqO/qt6K
         myU9PHxtIENRoJ1Q+RFx+ijTIBRLtOq6PAGTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SZzzrqx3L/dYLLEyqgd1hFnsLV3DhppU5yFzUxxzExnUqOv8kId1PRj8sQfcFtuubT
         K2QEvaVaGBAckm2UmS/s2tvA8zMWBCYGV6lfXVA4uHFIF1N/LM23hzRxvqnKtxunj/W7
         V1Zv/Grf8VbtBJSMvq8E4EtiwMPthxqB3gQaI=
Received: by 10.229.182.16 with SMTP id ca16mr5675171qcb.88.1277414094154; 
	Thu, 24 Jun 2010 14:14:54 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 14:14:33 -0700 (PDT)
In-Reply-To: <20100624194927.GB2065@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149650>

Jonathan Nieder wrote:
> A more terse summary, to save readers time:
>
> =C2=A0. repo_add, repo_modify, repo_copy, repo_replace, and repo_dele=
te
> =C2=A0 update the current commit, based roughly on the corresponding
> =C2=A0 Subversion FS operation.
>
> =C2=A0. repo_commit calls out to fast_export to write the current com=
mit to
> =C2=A0 the fast-import stream in stdout.
>
> =C2=A0. repo_diff is used by the fast_export module to write the chan=
ges
> =C2=A0 for a commit.
>
> =C2=A0. repo_reset erases the exporter's state, so valgrind can be ha=
ppy.

Looks good.

-- Ram
