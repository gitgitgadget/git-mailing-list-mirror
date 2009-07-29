From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Wed, 29 Jul 2009 11:05:40 +0200
Message-ID: <cb7bb73a0907290205t6402c5dbob3d4a1663ec39135@mail.gmail.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vljm84htf.fsf@alter.siamese.dyndns.org> <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com> 
	<7vab2oynhm.fsf@alter.siamese.dyndns.org> <cb7bb73a0907290120x72d0ae99p7cfdd2b88264a24a@mail.gmail.com> 
	<7vws5rx4qt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW56y-0001Mh-Lx
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbZG2JGB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 05:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbZG2JGB
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:06:01 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39525 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZG2JGB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 05:06:01 -0400
Received: by fxm18 with SMTP id 18so253709fxm.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=c96Qp3gxN3+y3Y2rYknuiFBwC084iLySV+5nFxKMFuU=;
        b=DWoWtlQuO8rOfbz1DoTaPWy2cp3KxMPWLUf3fv2htOEbD6XBftM37TvYpqQ7l/E+GZ
         lvZ6ObkuUHwP/yQ+W39Dcu7056C3LlfrerPb0Ee0mGX1SEP13szxS5rvXKgD1Cw3EzOY
         yfL0dhoS4Qp9xWXRMVafVvkL579bJod02kVfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xmBS8njN6a3vJFB83Ki2BVHTBpOwL9mqMwHt5LIVwSv58uPubclMf/l88bNyAWUlyB
         lo/WP6wo64HaffzgiQFYYa9RNLYwTnxqxPbRGhNH+00cm6RXq68iCCDDzplgT+YVS3+t
         KXNa49GqJllkwY+ILlTK7B5sT6Ng0bBsZYkvo=
Received: by 10.204.115.5 with SMTP id g5mr5377313bkq.41.1248858360210; Wed, 
	29 Jul 2009 02:06:00 -0700 (PDT)
In-Reply-To: <7vws5rx4qt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124332>

On Wed, Jul 29, 2009 at 10:39 AM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> I was thinking more about consistency than 'correctness' =A0in this
>> case, actually. Typical scenario would be: patch is created for a fi=
le
>> using a given whitespace convention (e.g. 4 spaces). File is updated
>> to match the rest of the project (tabs). Patch would now introduce t=
he
>> wrong whitespace convention for the new lines.
>
> You are assuming that the patch is always based on a wrong convention=
 and
> the target always uses the right convention.

No, I'm just assuming that the lines should have consistent whitespace

> In general, however, you
> cannot tell which way the "consisitency" should go --- often you have=
 to
> apply a patch based on a fixed codebase to an older version.

Consistency should go the way of the context lines. So if the
convention changed and you're backporting changes, the changes would
use the old convention on the old codebase, and the new convention on
the new codebase, because that's what the context lines would direct
the new lines to.

Of course, this is all very abstract reasoning because I don't even
think the feature can be implemented at all robustly (too much 'AI'
work, IMO).

--=20
Giuseppe "Oblomov" Bilotta
