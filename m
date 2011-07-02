From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] advice: Introduce error_resolve_conflict
Date: Sat, 2 Jul 2011 05:09:51 -0500
Message-ID: <20110702100951.GC19090@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-2-git-send-email-artagnon@gmail.com>
 <20110621155555.GF15461@elie>
 <BANLkTik2A7K84dbeL5XkaGv8nbske=EmCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 12:10:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcx9F-0002hl-Vd
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 12:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab1GBKJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 06:09:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40994 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab1GBKJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 06:09:56 -0400
Received: by iwn6 with SMTP id 6so3382882iwn.19
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T2DXLsHQID0ghAondlgKgo+ldL5ojILZvbefMsI+p58=;
        b=VWmNTHdhRcYen1/h95tIt15F0ik4oagZ9SDKkG52FNl8ApoTXLG6NHvMV0hDfKTclT
         PMnT7S5b2CaYeC7PRpy0czTcYrPikPLS/ZkVcI3uIRuVx3LYShbjHvwAhr6gLjgoctm/
         zMdNz4fa/hkRyIMxGcqnh/coqrCRnTzOAxr2s=
Received: by 10.42.164.134 with SMTP id g6mr140189icy.442.1309601395688;
        Sat, 02 Jul 2011 03:09:55 -0700 (PDT)
Received: from elie (adsl-69-209-57-66.dsl.chcgil.sbcglobal.net [69.209.57.66])
        by mx.google.com with ESMTPS id e1sm4308780icv.8.2011.07.02.03.09.54
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 03:09:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTik2A7K84dbeL5XkaGv8nbske=EmCA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176551>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> Notice that after writing the above, a little detail jumps out:
>> namely, the second "error:" line is giving advice, so it might make
>> sense to make it say "hint:" instead.
>
> How do I do this correctly?

In an ideal world, it would involve two patches.

 1. first, restructure the code without changing output
 2. then, change output

Or:

 1. first, change output without restructuring the code
 2. then, restructure the code

That way, readers could evaluate the merits of steps (1) and (2)
separately.

Oh, you mean how to write a "hint:" line analagous to "error:" lines?
There's no standard API for that yet but there's an example in
builtin/revert.c (see v1.7.3-rc0~26^2~3, Introduce advise() to print
hints, 2010-08-11).
