From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] revert.c: defer writing CHERRY_PICK_HEAD till it is
 safe to do so
Date: Thu, 6 Oct 2011 18:02:59 -0400
Message-ID: <CAG+J_DyPThjC1Mt-Hh9nke+U=ZT91AW0uWCO5sFZpZC_LbgDig@mail.gmail.com>
References: <1317923315-54940-1-git-send-email-jaysoffian@gmail.com>
	<CAG+J_Dw8w9UGBzq4xK+i+QtA4ZuwJ5w1+mPg15mPNcGLuRaXyg@mail.gmail.com>
	<7vzkhdyecy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 00:03:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBw1x-00081g-Ce
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 00:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759341Ab1JFWDA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 18:03:00 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35836 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758929Ab1JFWC7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 18:02:59 -0400
Received: by ggnv2 with SMTP id v2so2182142ggn.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7Y1E9unOD1MVeMWKIxcENsHNzLmJkJGDdKhF0iz7SSw=;
        b=VisLmhWNqoGJ96V6mcpsW/XwA52ILtRFAv+DkweJhGk7so5CRcmQjPTAtPn2OBP93o
         bP/iA64G/d3p8/LKutpy5MosOXthIbtv6mpRoai200vrOsSQaTgfoWV6rYMgm97sMeWS
         wQrGT857gGel09lbY0rWdr57mhyYwvc3e9+DM=
Received: by 10.147.154.12 with SMTP id g12mr944112yao.36.1317938579394; Thu,
 06 Oct 2011 15:02:59 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 6 Oct 2011 15:02:59 -0700 (PDT)
In-Reply-To: <7vzkhdyecy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183043>

On Thu, Oct 6, 2011 at 5:55 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> On Thu, Oct 6, 2011 at 1:48 PM, Jay Soffian <jaysoffian@gmail.com> w=
rote:
>>> Note that do_recursive_merge() aborts if the merge cannot start, wh=
ile
>>> try_merge_command() returns a non-zero value other than 1.
>>
>> Maybe you want this on-top:
>
> Good thinking.
>
> commit 4ed15ff067b548011b1eda8b12d46d887c4f056c
> Author: Jay Soffian <jaysoffian@gmail.com>
> Date: =C2=A0 Thu Oct 6 13:58:01 2011 -0400
>
> =C2=A0 =C2=A0cherry-pick: do not give irrelevant advice when cherry-p=
ick punted
>
> =C2=A0 =C2=A0If a cherry-pick did not even start because the working =
tree had local
> =C2=A0 =C2=A0changes that would overlap with the operation, we should=
n't be advising
> =C2=A0 =C2=A0the users to resolve conflicts nor to conclude it with "=
git commit".
>
> =C2=A0 =C2=A0Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Thanks. Care to sign-off?

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

Thank you for making it a proper commit. :-)

j.
