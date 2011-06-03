X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Fri, 3 Jun 2011 00:36:50 -0500
Message-ID: <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
References: <20110603050901.GA883@sigill.intra.peff.net> <20110603051805.GC1008@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
NNTP-Posting-Date: Fri, 3 Jun 2011 05:40:14 +0000 (UTC)
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/rF9Xt5MViB6hvyzQnpssPmGKryqhWL/uWEgvi2Okvg=;
        b=O6Z3Hxy1iNqdUNS7bZdfEMZbUt2d3SiNrmosnglPnspo0sBhCd7S0CqeTmcvuY4s79
         eXKMJo1TBWrN2arVbP2Cvb/k09F0Imb0kQ1JiqfOFUBpvMiP2euvUlxNcTlg9hDSuyOP
         1iVPsxo+PDK/dMTXAQnUcfNsCFxsvC1bVA57Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=blMD7VHEcyTQ4Pr35YdUV89cBGyfHxYJ9cg+sHVaEv3D2du6nVmOtYfVhVMZs8eOTg
         orDB6s3Ue2sXP8ChwcARKhPfIV+iO04o3zl88r75HBDG+Fe4C82b8vjT0AHa2AVv5xS9
         O/kxKixXjVuzADmwYat4S2Bfius5fYIreBqVI=
In-Reply-To: <20110603051805.GC1008@sigill.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175000>
Received: from vger.kernel.org ([209.132.180.67]) by lo.gmane.org with esmtp
 (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id 1QSN75-0000iI-FP
 for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 07:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751256Ab1FCFhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2011
 01:37:31 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43061 "EHLO
 mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1750890Ab1FCFhb (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Jun
 2011 01:37:31 -0400
Received: by qwk3 with SMTP id 3so678623qwk.19 for <git@vger.kernel.org>;
 Thu, 02 Jun 2011 22:37:30 -0700 (PDT)
Received: by 10.229.140.195 with SMTP id j3mr1225004qcu.5.1307079450117; Thu,
 02 Jun 2011 22:37:30 -0700 (PDT)
Received: by 10.229.20.6 with HTTP; Thu, 2 Jun 2011 22:36:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org

Heya,

On Fri, Jun 3, 2011 at 00:18, Jeff King <peff@peff.net> wrote:
> So I guess it doesn't like us asking for HEAD. But the fact that it
> sends weird data to fast-import instead of saying "hey, HEAD doesn't
> exist" has me confused. I'm not sure if this is something one should not
> be doing with remote helpers, or if the testgit helper is simply buggy
> or incomplete.

Definitely the latter, quite possibly the former. I don't know if
asking for "HEAD" makes much sense in a remote-helper context though.
In Mercurial it does (e.g., tip), and in svn sort of, but I don't know
about other vcs-es. Perhaps it should be guarded by a capability?

-- 
Cheers,

