From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Sat, 1 Mar 2014 06:22:09 +0700
Message-ID: <CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
 <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com> <530FA0C1.3000109@web.de>
 <530FBB1D.3050505@gmail.com> <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
 <53102FB0.6040603@viscovery.net> <5310959D.709@gmail.com> <xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Lee Hopkins <leerhop@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:22:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJWlQ-0004uJ-Ey
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 00:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbaB1XWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 18:22:40 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:47976 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbaB1XWj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 18:22:39 -0500
Received: by mail-qc0-f176.google.com with SMTP id m20so1257528qcx.35
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 15:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6QZlwt5QUWtTQG2EhICspCfpk5Xwq022DC8S3gOMBsc=;
        b=NFQIc5SlDMpj4gz+ZlfZCGMP9J2EGB7Mp5lYe36G2AMH82Gov0JVvpAyvIcytSaVoA
         MBD0/WO4+Q/wBtj8QBKltLtgUirguSvCU3+L04Eij3gB5mt3PkxEXbNo8zSG6d3XqEUC
         c/EiFXjpHpTrqdXlnNmCawu9pTI8Bkbt7zWQJtLEO0ahrfks4TKCMZORt72T08RnqH9c
         cCfgsVaMCwRST0YacjP1/ZYDP9fWQkgxX6+9uFBLQESqu1WevduciZmbnhG+iOgADC+h
         27hFZdCX368f1ZXy4lCT8JSBpxZw+YQsyFoT6cHnalrngPPDmpTafwxlIlRS6XKaSLYa
         mZ7A==
X-Received: by 10.224.112.6 with SMTP id u6mr7405232qap.78.1393629759079; Fri,
 28 Feb 2014 15:22:39 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 15:22:09 -0800 (PST)
In-Reply-To: <xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243025>

On Sat, Mar 1, 2014 at 1:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karsten Blees <karsten.blees@gmail.com> writes:
>
>>> If you are on a case-insensitive filesystem, or work on a cross-platform
>>> project, ensure that you avoid ambiguous refs. Problem solved.
>>>
>>
>> So its OK to lose data if you accidentally use an ambiguous ref? I
>> cannot believe you actually meant that.
>
> I think he meant what he said: "you avoid ambiguous refs".  He did
> not say "it is not Git's business to help you doing so".
>
> I think it is prudent to warn in the end-user facing layer (read: do
> not touch refs.c to implement something like that) when the user
> creates "refs/heads/Next" when there already is "refs/heads/next",
> and I further think it would make sense to do so even on case
> sensitive platforms.

That does not help when the user creates "next" and pulls "Next" from
elsewhere, does it?
-- 
Duy
