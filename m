From: Lee Hopkins <leerhop@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Mon, 3 Mar 2014 09:21:10 -0500
Message-ID: <CAJHY66Hmq6ffv73MuK85k4_11TO_hysncZ5SveeW4WF52ZfTkA@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de>
	<530FBB1D.3050505@gmail.com>
	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
	<53102FB0.6040603@viscovery.net>
	<5310959D.709@gmail.com>
	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>
	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com>
	<CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com>
	<53118436.5080507@web.de>
	<53145375.4040802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 15:21:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKTk9-0007g8-4F
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 15:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbaCCOVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 09:21:14 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:62652 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbaCCOVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 09:21:11 -0500
Received: by mail-qc0-f171.google.com with SMTP id x13so2556740qcv.16
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 06:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4mUmG3KQRk0ofMRv+y8WvQ/33oT2PSHpCwFAR5DNbBc=;
        b=U/4vyFR67wEWeXDjujtLBK++ClTj2NmOxs1sh/mg97YGojZCqLBypKQWsnEjW8E2mU
         LJNIifC5IBWEOxmhKupWll5tiyV1Sej5j7vpdjdxLeDjABZoRi87uzvpqu9iLt7usLYk
         9MATIIUwdXelgiKv9d1BfjCibvrzuXMyZTA1tvst6GfW1ZQugcEU+pyfhK32Ax4dMjOW
         Apup5EYq0YLlRgzlnmg2E8bBXOVtwM23QGmp7yx86ehU48Ikgo6xeJ7AoAmRKRjH9zxV
         QbaICqQOvTCmWtbBphtrc0hxPJpHllXKfOAQj81TeymG1hwB4ZX7vs74Ow6LhAFY6VVy
         /28w==
X-Received: by 10.140.39.50 with SMTP id u47mr22784325qgu.46.1393856471023;
 Mon, 03 Mar 2014 06:21:11 -0800 (PST)
Received: by 10.140.106.69 with HTTP; Mon, 3 Mar 2014 06:21:10 -0800 (PST)
In-Reply-To: <53145375.4040802@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243223>

> I don't think this distinction is necessary, either you have a case-insensitive file system or you don't. The case
> that the .git directory is case-sensitive and the worktree directory isn't (or the other way around) is
> probably so exotic that we can ignore it.

I think Torsten's use case was for someone who is carefully curating
their loose and packed-refs, e.g. gc.packrefs = false. This could be
for backwards compatibility (existing ambiguous refs whose names
cannot be changed for some reason) or simply because they want to.

> If you want to prevent problems with Windows/Mac OS, you should set core.ignorecase = true. I don't see why we need
> yet another config setting for refs (and logs?).

Since refs.ignorecase falls back to core.ignorecase, you could just
set core.ignorecase = true and feel safe when sharing with Windows/Mac
OS. I think having the distinction just makes Git more flexible, OTOH
I can see how having both refs.ignorecase and core.ignorecase could be
confusing and possibly redundant.
