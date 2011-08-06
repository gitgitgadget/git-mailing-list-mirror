From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: Re: Why do some commits not appear in "git log"?
Date: Sat, 6 Aug 2011 20:43:59 +0300
Message-ID: <CA++fsGE2JfnHc2JCsJg21FLXGfMWnzCjpUdwk+dcK72e5P18eg@mail.gmail.com>
References: <CA++fsGGG7pLt4xoeJozGnYEwOrs6NuzStYPKF_L5k49uzFB-4A@mail.gmail.com>
	<CA++fsGEht+UDp9EnFyfvn-uT1DYPcnhpwmPy_H4PTWvsvUceAQ@mail.gmail.com>
	<CAMOZ1Bt+Z4XDPNBQyUeVk30aEOuXFAuh8jhdhFke-CDZt2pEDg@mail.gmail.com>
	<CA++fsGGhzVkXTPLui+DfTFcjve7w80Kud4RxC0p=5AenOcBSDw@mail.gmail.com>
	<7vipqeb9wg.fsf@alter.siamese.dyndns.org>
	<CA++fsGG1xHm2ubXB-EL56L6xSau9AQX=o8fvmZb_7zNFkqdW2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 19:46:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpkx8-0003LH-C1
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 19:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab1HFRoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 13:44:00 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:54914 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab1HFRoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 13:44:00 -0400
Received: by iye16 with SMTP id 16so5847254iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=at65dwsOrWIBRgAo7KPQ/LomEsgsUEr1unsWehfYhdQ=;
        b=IGUclkoE5GqYmDdqp3Kootr04mjSIcAycGcpuhae5xuEdAtop6OJwscF7n2ITfuEkS
         56P8NmdHEBuwTLhUNIDT5R4DQSSZqEhyEmKTwrgSsCFNTAXXkfbvJBfvpgEr19Ed7yJG
         D/RJbeUAJhP+zIjklwQ/xnnl0XO61nQ15TMYI=
Received: by 10.42.133.8 with SMTP id f8mr3801572ict.176.1312652639369; Sat,
 06 Aug 2011 10:43:59 -0700 (PDT)
Received: by 10.42.218.137 with HTTP; Sat, 6 Aug 2011 10:43:59 -0700 (PDT)
In-Reply-To: <CA++fsGG1xHm2ubXB-EL56L6xSau9AQX=o8fvmZb_7zNFkqdW2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178885>

Ok, now I grok it. Indeed these "substantial changes" by mistake
undid another large change. So the net result was zero, which git was
smart enough to figure out, and therefore these two changes +D and -D
cancelled one another and none of them were shown.

Thanks a lot!
Dov


On Wed, Aug 3, 2011 at 21:57, Junio C Hamano <gitster@pobox.com> wrote:
>
> Dov Grobgeld <dov.grobgeld@gmail.com> writes:
>
> > --full-history indeed made the missing commits show up! So why was the
> > commit pruned? It contains some substantial source changes...
>
> I suspect that these "substantial changes" did not make any contribution
> to the end result. Read
>
> http://thread.gmane.org/gmane.comp.version-control.git/89400/focus=90659
>
> These days, the --post-simplify option implemented in that discussion
> thread is called --simplify-merges or something, I think.
