From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Mon, 03 Mar 2014 11:03:33 +0100
Message-ID: <53145375.4040802@gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>	<530FA0C1.3000109@web.de>	<530FBB1D.3050505@gmail.com>	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>	<53102FB0.6040603@viscovery.net>	<5310959D.709@gmail.com>	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com> <CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com> <53118436.5080507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Lee Hopkins <leerhop@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:03:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKPin-0006FQ-Fx
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbaCCKDh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 05:03:37 -0500
Received: from mail-ee0-f49.google.com ([74.125.83.49]:53585 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbaCCKDg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:03:36 -0500
Received: by mail-ee0-f49.google.com with SMTP id b57so3869400eek.8
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 02:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iuonXa2cu6tphHnA4F9lKq4nGinrQiiRrwBO8kkdUI4=;
        b=Q0xHfjH4dvnoZHIBvlBIBTxUHFOOjf00KK4o6BRy6pJ58ZXiARmj+yE/22AccmwFDR
         gC1ss56wz34S/4T7NpXVzQB7BlyYqpp7up1BZOYW+ZynqcA0HConDqNWG96GfuYFEbJq
         SzHDeY8m8GP7YhsRgeFbxxlnojPh9rBE2TiMrpSsI0vqMoBofwggMbW86Ad7wn2ZZEcL
         7cDzZ7q0IGZgcKuOU7hQ58b52+nIDVfyYB7A1ROxCnPc6oCcVxXNHCSh89kseJvox/yC
         hfZaWZ9C6/Qbx+ys8VCtvJbVHjj9fwURuRAoobJigLfYmqgYM+dAJc3Ve1ZItPkwiHHw
         eQ2A==
X-Received: by 10.14.218.70 with SMTP id j46mr25284313eep.11.1393841015275;
        Mon, 03 Mar 2014 02:03:35 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id k41sm48021947een.19.2014.03.03.02.03.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Mar 2014 02:03:34 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <53118436.5080507@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243208>

Am 01.03.2014 07:54, schrieb Torsten B=F6gershausen:
> On 2014-03-01 03.42, Lee Hopkins wrote:
>> +
>> +    if(ignore_case)
> Only looking at ignore_case here closes the door for people
> who have a branch "foo" and "Foo" at the same time.
> (Which means that they are carefully running git pack-refs)
> How about something like this:
>  +    if (refs_ignore_case < 0)
>  +      refs_ignore_case =3D ignore_case;
>  +    if (refs_ignore_case)

I don't think this distinction is necessary, either you have a case-ins=
ensitive file system or you don't. The case that the .git directory is =
case-sensitive and the worktree directory isn't (or the other way aroun=
d) is probably so exotic that we can ignore it.

> (And then we need the diff further down on top of this.)
> (And of course Documentation/config.txt)
> The main motivation is that you can set refs.ignorecase =3D=3D true o=
n
> e.g. Linux, to prevent to have branches "Foo" and "foo" at the same t=
ime,
> which gives problems when pulling into e.g. Windows/Mac OS

If you want to prevent problems with Windows/Mac OS, you should set cor=
e.ignorecase =3D true. I don't see why we need yet another config setti=
ng for refs (and logs?).
