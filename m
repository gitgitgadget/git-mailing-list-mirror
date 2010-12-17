From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 10/21] tree_entry_interesting(): fix depth limit with
 overlapping pathspecs
Date: Fri, 17 Dec 2010 17:05:32 +0700
Message-ID: <AANLkTi=4vnitj-U5M+V_ALVpAk0ncMG=09aAEqA=KD41@mail.gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-11-git-send-email-pclouds@gmail.com> <7vmxo5l2g4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 11:06:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTXCU-0002d0-OF
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 11:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab0LQKGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 05:06:05 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58062 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab0LQKGD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 05:06:03 -0500
Received: by wyb28 with SMTP id 28so445678wyb.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=SDv9ekzVokXQcuzNbJYcmucQK9HNXMiUnZXkE+wK+9s=;
        b=hYN6qc9HdNWrrV0elDRzQn0O4Y72IiRrv7uW8jyl1FL2BCGwRqtPx2DE8oR15MfxvT
         TkPtM/Xc237L8rjS4/Aw2banTvnFGUrzs7nXOSrlYByKUvi+OQeCjVvOXhPv7gajvjIU
         9C/pltaVVs+tcxgwzobDWhkG0G1qNSK/2sZ5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YwBCYLdxDuQ4VaUJn+RpDrIHTIU1EKk2vkpWFxfGEt/UA8VALeVWU2IRnpiWVteoz7
         PCf7gevpbSLNOwK6eT3/TeRjdUnko0WVj2WUqJBCTWMsHLtsH8CiU0K5fnLFYalXhmKE
         d/DRpoLMdgp7EBcT78Zy9JWCAqIpLBoAqBJO8=
Received: by 10.216.52.206 with SMTP id e56mr878955wec.19.1292580362170; Fri,
 17 Dec 2010 02:06:02 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 17 Dec 2010 02:05:32 -0800 (PST)
In-Reply-To: <7vmxo5l2g4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163870>

2010/12/17 Junio C Hamano <gitster@pobox.com>:
> One thing I am not clear is what it means to limit the recursion level
> when you have wildcards.

Recursion level does not affect wildcards at all. That was original
design, a91f453 (grep: Add --max-depth option. - 2009-07-22). I think
current git-grep still follows that.

> [Footnote]
>
> *1* In addition, perhaps you may later want to introduce some "negative"
> match operators to pathspecs; while I am not particularly fond of that
> direction at this moment, I would like to leave the door open for that
> possibility, in case it turns out to be a good thing to have.

It's a essential thing for narrow clone, otherwise I can't widen a
narrow clone. But narrow clone must prove it's a good thing to have
first..
-- 
Duy
