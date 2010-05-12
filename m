From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: restrict tags used
Date: Wed, 12 May 2010 11:23:02 +0800
Message-ID: <AANLkTim8SRUEaNWyBF_iRQstu84r9eAaUd0a9KLj6OtR@mail.gmail.com>
References: <1273599198-1008-1-git-send-email-rctay89@gmail.com>
	 <20100511230100.GB31163@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 05:23:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC2Xy-00068P-39
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 05:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab0ELDXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 23:23:05 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60342 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748Ab0ELDXC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 23:23:02 -0400
Received: by pxi5 with SMTP id 5so2655213pxi.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nS73SKl4H7H1CdwW50sUL6BwMqaMCkqT+ak/MflOs0k=;
        b=l12IL/ibQ6vvNuGMIL+lXrHc4jEfI7ck2RyR0pM0v1jIAWJ9TmGI0oxw+mh1F+x2GC
         2xN1vuGrwJ8iBRoHmDuxtie/i6K73sV8eYAI3In26/m4/y1nVBWksBMiPodK5FUKhpxU
         JmyGB6TC2xHDBwwspKTtTeIczG9iBmn6S0NOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tz0XROCJpDoqbMZIaqoBaWegEZWQ1PYRBUT4WfEVS4DLR2nyXbkaLdBU/U57WJo6mL
         3kMZ0k0gd5qagU7jV9iZXrNAJpz95py5FVMnlGWpohmfvth9u0+hQDrXMQ4sVy4Guold
         4d8ok4fnkwCnCPxz3ionbb8ArCfaIgOHY6d9E=
Received: by 10.142.195.9 with SMTP id s9mr4599680wff.55.1273634582121; Tue, 
	11 May 2010 20:23:02 -0700 (PDT)
Received: by 10.142.169.10 with HTTP; Tue, 11 May 2010 20:23:02 -0700 (PDT)
In-Reply-To: <20100511230100.GB31163@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146917>

On Wed, May 12, 2010 at 7:01 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Tay Ray Chuan wrote:
>> This is to avoid using private tags by the user in a clone of the gi=
t
>> code repository, which may break certain machinery (eg. Makefile).
>
> Not to mention gitk:
>
> =A0set git_version [join [lrange [split [lindex [exec git version] en=
d] .] 0 2] .]
> =A0if {[package vcompare $git_version "1.6.1"] >=3D 0} {
>
> This requires =91git version=92 output to have the form
>
> =A0introducing 1.2.3.otherstuff
>
> or there will be errors at startup time.

Thanks for the heads-up, I'll put that in the patch message.

>> =A0 After this patch, perhaps we could advertise somewhere to git ha=
ckers
>> =A0 that tags beginning with "v" should be avoided.
>
> Maybe v[0-9]* would make this problem harder to trip.

Oh, I didn't know character classes were allows. Sounds good.

--=20
Cheers,
Ray Chuan
