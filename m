From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] string_list: Add STRING_LIST_INIT macro and make use of 
	it.
Date: Fri, 2 Jul 2010 16:47:28 -0300
Message-ID: <AANLkTiltCRnezNdL-ueNGfM87mRlbtK6fn1fYMcv5M0G@mail.gmail.com>
References: <7vbpawifwa.fsf@alter.siamese.dyndns.org>
	<bcb1b64b5db55dd11a398da3cf2c95145852ddfb.1278097858.git.tfransosi@gmail.com>
	<20100702193002.GB6585@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, srabbelier@gmail.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUmD4-0001PS-3F
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab0GBTra convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 15:47:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48431 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab0GBTr3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 15:47:29 -0400
Received: by gye5 with SMTP id 5so584951gye.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BCrFu6I+inIpdbtrvX0C4j9G3vzBYHoggqe6pHuPoqA=;
        b=iYQIL4XCwE3f60EeRPZbctSYWXQGlmSDIv/nI2MrH+obmnnBgai9x/ahe4U8TWjmhW
         ebSi2ZRxwezvPuCNyLXMpBwNoi22uBDEU1T7UUEnCrwbpJFPbPn8aUpb6NIasIzLU1c0
         o0wYNp/CTesCfl6Upn9dsixi/arCwyxc+G2I4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hAKOZXCO4TNcqKMDR2RNxwlei5b/c1f1UnNBlZROp+PaN6kFxNdpEu2YxDhH3klwcw
         LJizM2OccbQd8viNLe2qf5AjZ4tQXCFCk87kdfRNB4qV3H+wj7BlEunlXBSGw71ZaC/w
         EbjY7ZmXHkK5L3Yrzh6ORmfF+aTxbW4RGMku0=
Received: by 10.229.183.84 with SMTP id cf20mr862836qcb.93.1278100048706; Fri, 
	02 Jul 2010 12:47:28 -0700 (PDT)
Received: by 10.229.245.208 with HTTP; Fri, 2 Jul 2010 12:47:28 -0700 (PDT)
In-Reply-To: <20100702193002.GB6585@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150160>

On Fri, Jul 2, 2010 at 4:30 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Thiago Farina wrote:
>
>> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Um, I am not so fond of this one.
>
> The argument to STRING_LIST_INIT is hard to interpret without
> familiarity. =C2=A0What did you think of Peter=E2=80=99s suggestion t=
o use an a
> different macro for the strdup_strings case? =C2=A0Something like
> STRING_LIST_INIT_DUP_ON_APPEND, but perhaps shorter.
>
If we are fine, would be the following?

#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
#define STRING_LIST_INIT_DUP { NULL, 0, 0, 1 }

> It would also be nice to update
> Documentation/technical/api-string-list.txt with whatever you choose.
>
Sure, I will update it.

> That said, I do like the goal of making it easier to reorganize
> struct string_list later if needed.
>
