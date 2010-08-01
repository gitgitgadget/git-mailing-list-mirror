From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 02/16] list-objects: limit traversing within the given 
	subtree if core.subtree is set
Date: Sun, 1 Aug 2010 11:30:25 +0000
Message-ID: <AANLkTinXhfSzVtcjHVzpdV_GUK+mbpVEezGY2aDXRk1-@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 13:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfWkX-00046A-AQ
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 13:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab0HALa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 07:30:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55043 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab0HALa1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Aug 2010 07:30:27 -0400
Received: by iwn7 with SMTP id 7so3046348iwn.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lMpY2+F5CwBun/08E0t/tuJAnwptXvb1O27b1X7SMvQ=;
        b=IIz4NvsJcio5doHqf9+xICUxU3HiJ4gCeSV1cuMGsEwJQTyehFpRGy230PY08y59Mu
         kRTmFOCza4WuctwOG7mtoR9efSZmC10I3jPbQGr+Cq11R5gS5pWEo7UE965Z6K9a8MW4
         +utMKTOUw/5yeluLA2pTsspiSn2kSCLhnXvM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z59FzFnvfNqs9+oJk/DAdw2zA7F8QnghdPuXH0H2IIsLxCDEVn5/taNSBeYYC9FEkK
         akqDcqrGT6xx8QwckdGDpHAMjY8avJpF/rOKUwFcsfXIAitiphRJxnH1/3cL43peZQyN
         gl2O2R4YBQnvbkQ7FhRSivqAyf5oQU+5h3Q58=
Received: by 10.231.19.3 with SMTP id y3mr5011875iba.156.1280662225479; Sun, 
	01 Aug 2010 04:30:25 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 1 Aug 2010 04:30:25 -0700 (PDT)
In-Reply-To: <1280593105-22015-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152377>

> + =C2=A0 =C2=A0 =C2=A0 int subtree_len;

Shouldn't that be size_t? strlen returns size_t, and strncmp expects
size_t, not int.
