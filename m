From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Copy resolve_ref() return value for longer use
Date: Tue, 15 Nov 2011 13:06:04 +0700
Message-ID: <20111115060603.GA17585@tre>
References: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
 <1321179735-21890-1-git-send-email-pclouds@gmail.com>
 <1321179735-21890-2-git-send-email-pclouds@gmail.com>
 <7vbosfoiuy.fsf@alter.siamese.dyndns.org>
 <CACsJy8BnqoPVJiM6mbq7p3gKtLh-KGUuTshcukGokC3istTxMQ@mail.gmail.com>
 <20111114112440.GD10847@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:03:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC7B-0004rT-In
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab1KOGDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 01:03:21 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38498 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1KOGDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:03:20 -0500
Received: by yenq3 with SMTP id q3so229881yen.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bxWscyg2TjNCKAgBSlGPaB/Snpk3bbfhLIrIdN89rsk=;
        b=k3igvDs5tytzW4fEmOKbPV1yVLEWRd1z5G66WmPplG8clvHPWKSyMP7ZR+s0xGUriO
         RAzuS1EtGd823DQ6xjGtsOhnCeUMW04+5Dd2XJReV5EkqjJTRdVTrFt5oeN1ovEsrNLm
         nF8BtQW03ybkAqKk/60SPHyTuO6LFVgoAsDfY=
Received: by 10.68.7.9 with SMTP id f9mr44405359pba.47.1321336999908;
        Mon, 14 Nov 2011 22:03:19 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id f2sm33966879pbg.14.2011.11.14.22.03.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:03:18 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:06:04 +0700
Content-Disposition: inline
In-Reply-To: <20111114112440.GD10847@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185424>

How about an incremental approach like this? On top of 1/1.

[PATCH 01/10] Allow resolve_ref() caller to decide whether to receive static buffer
[PATCH 02/10] cmd_merge: convert to single exit point
[PATCH 03/10] merge: do not point "branch" to a resolve_ref()'s static buffer
[PATCH 04/10] commit: move resolve_ref() closer to where the return value is used
[PATCH 05/10] checkout: do not try xstrdup() on NULL
[PATCH 06/10] reflog-walk.c: request allocated buffer from resolve_ref()
[PATCH 07/10] receive-pack: request resolve_ref() to allocate new buffer
[PATCH 08/10] notes: request resolve_ref() to allocate new buffer
[PATCH 09/10] fmt-merge-msg: request resolve_ref() to allocate new buffer
[PATCH 10/10] branch: request resolve_ref() to allocate new buffer
