From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv4 15/15] Replace "unset VAR" with "unset VAR;" in
 testsuite as per t/README
Date: Thu, 30 Sep 2010 15:51:49 -0600
Message-ID: <AANLkTimmSLwZaGvM1j7CQtTzd7mJXSiBDHztj4S97rOr@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-16-git-send-email-newren@gmail.com>
	<7viq1omiv8.fsf@alter.siamese.dyndns.org>
	<AANLkTimgTAerCNcSHBR9t-s-ThWHLMXdsb2T=E2w8gpB@mail.gmail.com>
	<7v39srkyax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 23:51:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1R2i-0002Ow-13
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 23:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501Ab0I3Vvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 17:51:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63612 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab0I3Vvv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 17:51:51 -0400
Received: by fxm14 with SMTP id 14so271931fxm.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HyJnwN/pIHF+I5GiOo++omxGtxQLLcpdayhEPY3SGmE=;
        b=SgD3toHbOMyNfZo52giklWybZQmlhCU7FCRCdBQMyXqOR9iPhFIVJqnmdroBDJUbLk
         iZNXShA4i0nRVL4uEz6+lMk+W9tbkyQgBRp57k2nABxtiaRBcvMhsO+Qm5nMlUlGW6tq
         YKZPeqPwbrdNUH+nPBfD2DIFw91z1U8ZfvJpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bmU7uwZ6JQV2qJRnJR0/oFNh95qZR3jb7NWWkBdvJ2Wls5xRUztbgupctOmn7+UBLD
         Aa3OknNMUTiKglf+ERlZtU+rVu2k8RBM1BbD8XOoH/2Kce9VEtQFg8UkpCED/nVGGAYn
         YQ4fRaTUiXxTzv1qevtuLoNgbvQxyrGc7Q8j8=
Received: by 10.223.124.148 with SMTP id u20mr4534433far.57.1285883509503;
 Thu, 30 Sep 2010 14:51:49 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Thu, 30 Sep 2010 14:51:49 -0700 (PDT)
In-Reply-To: <7v39srkyax.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157715>

On Thu, Sep 30, 2010 at 10:09 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Elijah Newren <newren@gmail.com> writes:
>
>> They break the && cascades, but aren't the && cascades already
>> inherently broken due to the unportable return value of unset?
>
> Of course; that is the breakage you are trying to fix, no? =C2=A0My c=
omment was
> that I understand you are trying to, but the patch is not actually fi=
xing
> it.
>
> If anything, it is making it worse. Earlier we would have got a false
> breakage that would make people notice and take a look. With your pat=
ch
> applied, we instead would let a breakage in parts earlier than these
> "unset VAR;" go unnoticed, no?

Right.

What do you think of the previous suggestions in this thread for a
portable_unset() function, or for using test_might_fail in front of
all these unset commands (despite t/README saying that test_might_fail
is only for running git commands)?
