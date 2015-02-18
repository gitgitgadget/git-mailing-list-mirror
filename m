From: Eric Frederich <eric.frederich@gmail.com>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 16:38:55 -0500
Message-ID: <CAAoZyYOT_OQZ+rrwFvnsVBV_sYRA4Oti3vRNnE6_RaV9w8qxdg@mail.gmail.com>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
	<CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
	<CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
	<CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
	<xmqqfva341sf.fsf@gitster.dls.corp.google.com>
	<CAAoZyYOst-5cD7qtV=T3Oahja1JN1ZmeyAcELrn7xD0bMc7Mrg@mail.gmail.com>
	<20150218183251.GB6346@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:39:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOCKi-0008Sf-Jf
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 22:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbbBRVi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 16:38:56 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37994 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbBRVi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 16:38:56 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so7440083obc.6
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DxsP3qfzQuUlfAeYQcogy2/rA0+0qjU17yLrqs4puLY=;
        b=nMh3ONMxMHWLQkfLAobh7ulKTeD8n5oMfxHdE7YxDhDpFr/Q97SkVQzwufynV4rijU
         VdrGk38NORMadiGivr+hAAXR5e8rx7W64wf8qfEoG9kOp+vr0LHkZj9CJqAUgTXB1b1d
         pFQbKU0cIRgCv+0TMjGnXeis8wvmEKbjEP13guGATVq9B+mb19G6/20FRtE9ZK9S6a0T
         NTu2SAQ7Iohcdk7mhqB1u+pXF6lnpDCqXCbzzNRbE43LBrS0rY1/lyhN6r5sd62bSktn
         xGx79vERGwdXXolo8UUFh540HzDVBDNhs4GlWIu99pHBCO/Ni6own5UDmvDdV+lmu0iX
         GEhw==
X-Received: by 10.202.9.132 with SMTP id 126mr774300oij.77.1424295535493; Wed,
 18 Feb 2015 13:38:55 -0800 (PST)
Received: by 10.202.12.193 with HTTP; Wed, 18 Feb 2015 13:38:55 -0800 (PST)
In-Reply-To: <20150218183251.GB6346@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264064>

On Wed, Feb 18, 2015 at 1:32 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 18, 2015 at 01:27:50PM -0500, Eric Frederich wrote:
>
> If you can persist the index file for each working tree, this will be
> much faster in the long run, too (you can just refresh the index before
> each diff, which means that git does not have to actually open the files
> in most cases; we can compare their stat information to what is in the
> index, and then the index sha1 with what is in the tree).

Could you elaborate on "you can just refresh the index before each diff"
What command would I use to do this?
I don't want to store some object just to get a diff of it.

Also, how would I go about detecting untracked files the way status does?
There is no way to specify a HEAD per git command using switches or
environment variables.
I can't change the HEAD of the Git repo because other processes may be
using it at the same time.
