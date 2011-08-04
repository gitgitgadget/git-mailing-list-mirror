From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Thu, 4 Aug 2011 13:16:35 -0600
Message-ID: <CABPp-BFx38gLQDn0sccp74Z=RtEVzaxWiVqopxkWwXTSGuYxxw@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<7v4o1y81sv.fsf@alter.siamese.dyndns.org>
	<CABPp-BE=9r+upGUD45J7fPshqQE97UMZzaA+cu_WJ1A2p_Bigg@mail.gmail.com>
	<7vpqkl3sok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 21:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp3PO-0003pM-Bn
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 21:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab1HDTQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 15:16:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44240 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1HDTQh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 15:16:37 -0400
Received: by fxh19 with SMTP id 19so2032359fxh.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GoycVmhq2+omA8nEG9S4wLqwTiMlC4319cmv5sgdbmQ=;
        b=puUQVWCWXPtyEhytfbQrQMycqDypYCgjSXawJSdvrouJ4YYOO8sOWjjX0NmRnAnsqq
         M1zpB0n6ZDz+M6Q7VspbhuAHWA2lbH5aX7WGoMvVCIyi68/asuEw2iKL9rly0lNKIu84
         SOyrMTCCpyVvoHXLDWeR7Kh0lOPIc0ar9roWs=
Received: by 10.223.91.147 with SMTP id n19mr759427fam.53.1312485395729; Thu,
 04 Aug 2011 12:16:35 -0700 (PDT)
Received: by 10.223.109.198 with HTTP; Thu, 4 Aug 2011 12:16:35 -0700 (PDT)
In-Reply-To: <7vpqkl3sok.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178764>

On Thu, Aug 4, 2011 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Elijah Newren <newren@gmail.com> writes:
>
>> ... =C2=A0It
>> would be nice to make use of the original index we had before
>> unpacking, but that is overwritten at the end of unpack_trees.
>
> I somehow thought that we can give separate src and dst index
> to the unpack_tree() machinery these days. Aren't you using it?

Ah, yes, it appears to be possible.  I have not touched that part of
merge-recursive, so it still reads:
	opts.fn =3D threeway_merge;
	opts.src_index =3D &the_index;
	opts.dst_index =3D &the_index;
	setup_unpack_trees_porcelain(&opts, "merge");
I'll take that route to fix this.

Thanks.
