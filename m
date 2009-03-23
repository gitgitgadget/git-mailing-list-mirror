From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git repack: --depth=100000 causing larger not smaler pack file?
Date: Mon, 23 Mar 2009 10:05:14 -0400
Message-ID: <eaa105840903230705i5c8bcd7ar363a6836d67be66@mail.gmail.com>
References: <867i2ot1fu.fsf@broadpark.no>
	 <alpine.LFD.2.00.0903171608080.30483@xanadu.home>
	 <86y6uwzgzo.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:07:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llknj-0005Rl-DW
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbZCWOFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 10:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZCWOFS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:05:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:28484 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbZCWOFQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 10:05:16 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2100282ywb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=o5zKA0k7H78BeG7DLyEHTtFA4v7esmm6agB0d/1aNRw=;
        b=o15Cf+nRLsBq/YoDOjcLJvFnM+jiscqb4nubQCSI8sNG5EhJRFzF8O+yHx6DqEEjIG
         LQUG5Q9FZGbuZUwlzi0eptDyeRi8zPs3lgU2a1D02cs+M5y0/e9unTBmjSTP4HMIwzhS
         Yig6fvhUrlHPK/V0Xuqffklmz9HesWbtrxx/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=DbvFxn9fWUwbGxf68JAhp3kBZRnFAaJC8EHsHfLNevRb65hlRPFGmN3X/ghQEK9Qnv
         TUMSEW9GasvgRDOS8VIVcngK/LNIXhKSJ3Y9S2Kcyu64Vtoj7iOsF75fX4/yRJ1hKkAv
         IdHV88CYY+R46YGhsQnd732jxbi3ITmL2EN6k=
Received: by 10.90.53.5 with SMTP id b5mr4143225aga.44.1237817114325; Mon, 23 
	Mar 2009 07:05:14 -0700 (PDT)
In-Reply-To: <86y6uwzgzo.fsf@broadpark.no>
X-Google-Sender-Auth: 2c5827756a08a2d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114306>

On Mon, Mar 23, 2009 at 6:11 AM, Kjetil Barvik wrote:
> =A0Question: is there some low level GIT command I can run to compare=
 2
> =A0pack files to maybe be able to see the reason behind the above tab=
le?
> =A0Maybe to see some details about how many delta's, how big each are=
,
> =A0total sizes, etc..

git verify-pack -v <pack.idx>

The columns are: SHA1 type size size-in-packfile offset-in-packfile
depth base-SHA1
(the last two columns are only present for deltified objects)

Peter Harris
