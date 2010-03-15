From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and 
	gid
Date: Mon, 15 Mar 2010 08:41:04 +0100
Message-ID: <81b0412b1003150041n5938556bqc127939622bfdb57@mail.gmail.com>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com>
	 <alpine.LFD.2.00.0904270757410.22156@localhost.localdomain>
	 <86skjudr6u.fsf@broadpark.no>
	 <201003142151.29969.robin.rosenberg@dewire.com>
	 <7v1vfm9iyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 08:41:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr4vL-0002Vd-4U
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 08:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781Ab0COHlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 03:41:11 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:65113 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab0COHlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 03:41:06 -0400
Received: by bwz1 with SMTP id 1so2632197bwz.21
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bpWryt7JwHU6ZYAvt6pANc5hypaNfmX72tU+gYM04fU=;
        b=C2c17bP3/NSFd18KSrANsNFv09DJUXrZ0TCLZfvh44oFinwksqswq2hkyNLwIchGtA
         hrM8jHdu93buivII9OWf6zmWrML5ZLqC5NNIX/YEorjd2KrDsdeg1mZu0NMlesAxlotk
         dmAZtgmu/SM8PrJXI893PXy0ziz3q0bgB7dJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i8T7xcEmxti2VOoS2wgoBUcjITtt1tZKYv4bJSBNb1TZXqoGYp7rwL84fRiW6cN1C2
         9N5CMqv897EBf9OfezmBcD6g+t9JYcOh5n/YQZ37U1BwMRnQQ4kOg59d0t65UC+l7LGh
         pTq7BqNsyrKMHD/9G5VSeNAJMZmizYdprfnVU=
Received: by 10.204.8.212 with SMTP id i20mr7298821bki.166.1268638864508; Mon, 
	15 Mar 2010 00:41:04 -0700 (PDT)
In-Reply-To: <7v1vfm9iyp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142175>

On Mon, Mar 15, 2010 at 07:50, Junio C Hamano <gitster@pobox.com> wrote=
:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>
>> Did something pop up that I don't know of that prevented inclusion o=
f this
>> patch, other than the NSEC option, or will it do if just refresh the=
 patch?
>
> I think all of us liked the general direction, and also all of us agr=
eed
> that we would want to keep NSEC support that was removed by Linus's p=
atch.
>
> Nobody had time or inclination to update the patch to implement the
> consensus (I still had the thread in my inbox, by the way). =C2=A0So =
"just
> refresh the patch" would be the necessary first step.

There is an awful lot of "trust-something" variables. Maybe they can be
consolidated into a bitmask/bitfields? And a config option taking a lis=
t of
filesystem features which can be trusted for a good measure (preserving
old "trust_something" options, of course).
