From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 7 Jun 2013 23:00:14 +0530
Message-ID: <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org> <20130607000006.GA25731@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul0VL-0002ou-27
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab3FGRa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 13:30:56 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55353 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079Ab3FGRay convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 13:30:54 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so11126846iec.19
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qLI1sW2ck30FiRcuzHSWFePcyz8zd9Sv+O3K7OKTK44=;
        b=CsvyKxXv7cCfAKoMWrEwkgS2/f9AY9577jcx2b7yWUVuyqLI4CuCbl1GDWECTxbeCm
         fDNx9q+m+dZJY9K3752oKDFxQCVZUIDyoSpQA4W4jNHLJXLIMtkqkeFvUdtvl1vuEdPR
         8MK+XquTOa9M3K1enDsHfCiuQUnvc6E+i0x7Cyx/msSi7oYi2mzY6l/ANUjFRvF7l6si
         BPA2Xb078Dr/sAuGGed/cPydb/a1Eg+MCTboEhwA4q0V8v3CqH5mKJ/hV9SByDTvs2g3
         m4jjcKMyDTn7iCooQdKK2dvjVM1ISmVMJaY3dsWlIG/c9+TcVcEKSRmfP6/k439OHvd0
         bU+A==
X-Received: by 10.42.31.69 with SMTP id y5mr19376908icc.44.1370626254217; Fri,
 07 Jun 2013 10:30:54 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 10:30:14 -0700 (PDT)
In-Reply-To: <20130607000006.GA25731@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226653>

SZEDER G=C3=A1bor wrote:
> the one at the top because
> of the reasons given in $gmane/226272

Sorry about the delay: I went to sleep for a couple of days :P

> the one at the bottom because
> of the misleading commit message (__git_complete_file() always
> completed refs first as part of the ref:file notation, so it worked
> just fine except for the ref1...ref2 notation; the real reason for
> calling __git_complete_revlist_file() for difftool is to make clear
> that difftool takes ref1...ref2:file, too).

How am I (or anyone else) supposed to know the "intended" meaning
__git_complete_file()?  The implementation is just an alias to
__git_complete_revlist_file(), so I looked at the name and guessed
that it was supposed to complete files; now you tell me that it was
intended to complete any revspec except revision ranges (what does
that have to do with "file" again?).  I suppose digging through the
history would've told me, but I really didn't bother for such a
trivial non-functional change.

If you ask me, you should clamp down on spurious completions
everywhere uniformly, if that is what you want (I personally have no
interest in the topic).  I see no reason to keep a badly named
function around.
