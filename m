From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: When to use test_commit (Re: [PATCH] checkout: add a test for 
	creating a new branch with regexp as a starting point)
Date: Fri, 30 Jul 2010 20:20:40 +0000
Message-ID: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
References: <20100729220111.GA28176@wo.int.altlinux.org>
	<201007300136.13501.trast@student.ethz.ch>
	<AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
	<20100730084428.GA9577@wo.int.altlinux.org>
	<AANLkTikan0hnUa-p-U1dfRKq+bORmrn7A3YTPOPe2N_k@mail.gmail.com>
	<20100730191357.GA2448@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 22:20:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oew4X-00040l-Oa
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 22:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760759Ab0G3UUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 16:20:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59051 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab0G3UUm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 16:20:42 -0400
Received: by iwn7 with SMTP id 7so1617890iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OCjfPt5A3MtuWip4Li2DiPXxhOLQy38xWdkNQD9v7jI=;
        b=Ecy5MXFhGqdxrOvKTbP7MCAtCb3NWpD6MT/B7Ew7uNCycnqo5wEZHPCy0CcklQezNM
         7gkOMlXj9EKLUxNtId3WR1HKuA9/nQgIt7KzIms4JSqplBDauRtxR9RAm5OhwN9fwLx6
         aOH8ew+/W9+rVt2u7/XF1ntxf+HIvArJvVNgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WY4aRo+8B2TuIHeYk59E4XyGwij4JFGbRNgpE1Acp7hkLbqZVgarCFTXBOZi0CFHZf
         BJ1k85ER2+cqdZFHloaCobg9xdhzo7C99qiZiRaK2xXqcGYUwHyU2atjNKwYqZAJkpwO
         E+qnWyJDRFcb1DB2HOKMHosXv82BrJtSkBGEc=
Received: by 10.231.157.207 with SMTP id c15mr2265680ibx.143.1280521241171; 
	Fri, 30 Jul 2010 13:20:41 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 30 Jul 2010 13:20:40 -0700 (PDT)
In-Reply-To: <20100730191357.GA2448@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152265>

On Fri, Jul 30, 2010 at 19:13, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> And actually, we should probably have a
>> test_commit_notag() then.
>
> I don=E2=80=99t know. =C2=A0What=E2=80=99s so bad about using "git co=
mmit" directly?

Nothing, it's just easier to write and read the tests when we have and
use functions for these common operations.

> I often find myself using "git commit" in tests because test_commit
> imposes all the usual restrictions for a ref name on the commit
> message. =C2=A0I would happily use an abbreviation for
>
> =C2=A0test_tick &&
> =C2=A0git commit -m "something" &&
> =C2=A0git tag something-else
>
> if available because I don=E2=80=99t like typing, but would that help=
 the
> reader and test runner any?

Maybe just introduce a fourth argument to test_commit, to make it
<message> [<file> [<contents> [<tagname>]] instead of <message>
[<file> [<contents>]] ?
