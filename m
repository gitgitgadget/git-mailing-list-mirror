From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: Re: [PATCH 3/5] git-cvsserver: take care of empty passwords
Date: Tue, 6 Jul 2010 20:21:37 +0200
Message-ID: <AANLkTinkg-i3KczWliWymP1FWYx0_YeoLGLHq2h2jLa-@mail.gmail.com>
References: <3594077658746039911@unknownmsgid> <AANLkTinpjbOStczVo7NaPlxqyAh_32kLy0kWKc_AsLiI@mail.gmail.com> 
	<AANLkTilSvEf6DIM_JZql8pTnSCrnFQ2tAOGuqownVl4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?B?TOFzemzzIMFTSElO?= <laszlo.ashin@neti.hu>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 20:22:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWCmT-0002HT-6h
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab0GFSV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 14:21:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50950 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0GFSV6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 14:21:58 -0400
Received: by bwz1 with SMTP id 1so3713994bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=B59+xo4YTSahLmhiz/j7dvnzO1MqwukcbByPshTOv2s=;
        b=NO7sVfwOdibcmnyYeKKsxtYfzKLJ3o5i/Mp+MlsYOfVxRsRdtld04HarqN62ad4W5G
         SJ6ayjdGcEj3u4EoVEmf0Cnwu7wBEofFXwgPb8He9Fm3Nk8lPbJnNmYYBFen+cikysZp
         tljyoKDbd3aOPXafBVgdhzAKkq6jrnb2xi2uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OSRquZm8b6m1/+2+y8MV12Bpk6wMGIcJAcqHkbTRJd6CGPiIv9jy+uRAleEEwPY7to
         Z5EroI2w6N/L1swlfDSsNFuVitZIALulE3CP0iJ+i4djugSNoGWmP8Wcmsdecu9i1EL0
         hU8hEUOAcH9XQ0oPi5D9SEij8e3SfPpTxfUWM=
Received: by 10.204.26.208 with SMTP id f16mr4125186bkc.71.1278440517309; Tue, 
	06 Jul 2010 11:21:57 -0700 (PDT)
Received: by 10.204.79.19 with HTTP; Tue, 6 Jul 2010 11:21:37 -0700 (PDT)
In-Reply-To: <AANLkTilSvEf6DIM_JZql8pTnSCrnFQ2tAOGuqownVl4e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150384>

descramble() dies if it is called with empty string as an argument.
This patch only fixes this.

The test case written to check empty passwords only checks the case
when the user is not in the authdb, so the old code doesn't even call
descramble().

On Tue, Jul 6, 2010 at 20:05, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gma=
il.com> wrote:
> On Tue, Jul 6, 2010 at 17:37, =C1shin L=E1szl=F3 <ashinlaszlo@gmail.c=
om> wrote:
>> Do not try to descramble them.
>
> This commit message isn't very revealing. What does this do exactly?
> Is the behavior with empty passwords changed now? Does git-cvsserver
> no longer support empty passwords? Is the on-disk format in the authd=
b
> just different? (I.e. "" instead of "A" or something). Or something
> else?
>
