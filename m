From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Sun, 14 Apr 2013 10:33:39 +0200
Message-ID: <516A69E3.2090805@gmail.com>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com> <7v38uvcrjl.fsf@alter.siamese.dyndns.org> <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com> <7vehed7ilu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 10:34:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URINw-0003Ea-GK
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 10:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab3DNIds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Apr 2013 04:33:48 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:58357 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3DNIdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 04:33:43 -0400
Received: by mail-ea0-f172.google.com with SMTP id z7so1817765eaf.31
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ripiNnllwDqkh85NuAcIsqPAOTfZXEovg3UDrOwCM4g=;
        b=dBvTRQGeUh2xsAmXMUynPgy/N6B7QFJICgtlLWqGRr8Z3xN0Wyb9S4ulrk/jaFaTyf
         X9fnVXKN0K7Uj7NVqLo48d3jjEgrVgjQHyv1XYI2XgCvaTyPqMG4Bz1X/ptq50tMKW1t
         4eD6vZDDbNK5F2+5vXRZxUbm5p499Dpqsl0Nqjl4Z3MlJZu+IMPpcaiJzYN0ku7uZU4J
         W+6tBGy/Y4hmKkfjSZLx/XjhxrbdcpovT6F/QcILB2zVAOnFbD0595DCHuPiXNyzQ54h
         EO+3MZSVBeOUT8dlMfMBcNvmK/an7FS7eq+zvZRNBXoXrc0eTs25ekIYPTkhn/K4XivU
         MUIg==
X-Received: by 10.15.24.71 with SMTP id i47mr36932567eeu.0.1365928422086;
        Sun, 14 Apr 2013 01:33:42 -0700 (PDT)
Received: from [192.168.1.14] (dji243.neoplus.adsl.tpnet.pl. [83.23.242.243])
        by mx.google.com with ESMTPS id b5sm20313524eew.16.2013.04.14.01.33.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Apr 2013 01:33:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vehed7ilu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221087>

W dniu 14.04.2013 06:42, Junio C Hamano pisze:

> I personally think it is much more sellable to use an even simpler
> rule than what Jeff suggested, to make
>=20
> 	git push -- <refspec>
>=20
> go to the remote.pushdefault (falling back to remote.default that is
> "origin"), without even paying attention to what branch you are on,
> and ignoring branch.*.remote/pushremote configuration.
>=20
> That is sufficient to support the triangular, the publish-to-mine,
> and the centralized workflows, no?  In any of these cases, the
> repository you push out to is _one_, even though it may be a
> different one from where you pull from.  If you have a very special
> branch that goes to a different place than all the other branches,
> you can always push out while on that branch without any refspec,
> anyway.

I think it also supports users of 'matching' that have push default
correctly configured.  Currently they can use "git push" in all cases
but first push of a branch, where they had to use "git push origin
branch", or "git push pushremote branch", and with those changes can
now simply use "git push -- branch".

Nice.

Here I think simpler is better, especially that diferent users
have different expectations: push to remote based on current branch or
push to remote or remotes based on branch or branches being pushed.
--=20
Jakub Nar=C4=99bski
