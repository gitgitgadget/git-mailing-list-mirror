From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] Move copy_note_for_rewrite + friends from
 builtin/notes.c to notes-utils.c
Date: Tue, 11 Jun 2013 19:32:40 -0500
Message-ID: <CAMP44s2pUW_+w6B_R-A=vxOg1Ay6iLmc4MQsA_sfDF+GP-XsWw@mail.gmail.com>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<1370995981-1553-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com,
	pclouds@gmail.com, artagnon@gmail.com, john@keeping.me.uk,
	vfr@lyx.org, peff@peff.net, torvalds@linux-foundation.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 02:32:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmYzX-00009K-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 02:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab3FLAcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 20:32:43 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:46574 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab3FLAcm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 20:32:42 -0400
Received: by mail-wi0-f181.google.com with SMTP id hq4so2443931wib.14
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iOp+rShTOpDxvDOAupR8DNS3NETtzF0oke8syAvWW1Q=;
        b=L9PNYigv5a3Gv4GWyPHm4zUriHjBLbwddSIJqnB2iYmfLyoCx+eTVE3Vt2MhW8r+B6
         0xdHu1WGXrcXg5gu3whIBeTkAFOJUGh3aIHSCwAmohcbJDHfzbSsDbD1+mNPFRAR46jo
         eCIrOrr1H6PNzwL+tu4jjgP8a2NOG32aSVdHgw7xwbZSURMjCmOlGQxiMlgaYEnA8M5F
         LLrdo9Rbg+fSrSYoB9/IN1PpfcjUF0/UuXdjIpJEHbytvGEaTuV60YANpD1zfuaPD0c1
         4//kgVGuSkje1yZpHRWoBMG0r5ZKDLyT43Xmd/zeFui81exs1DBPqtILYSJ3T242gbo6
         na0w==
X-Received: by 10.194.158.69 with SMTP id ws5mr9202790wjb.84.1370997161353;
 Tue, 11 Jun 2013 17:32:41 -0700 (PDT)
Received: by 10.194.216.199 with HTTP; Tue, 11 Jun 2013 17:32:40 -0700 (PDT)
In-Reply-To: <1370995981-1553-3-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227584>

On Tue, Jun 11, 2013 at 7:13 PM, Johan Herland <johan@herland.net> wrote:
> This is a pure code movement of the machinery for copying notes to
> rewritten objects. This code was located in builtin/notes.c for
> historical reasons. In order to make it available to builtin/commit.c
> it was declared in builtin.h. This was more of an accident of history
> than a concious design, and we now want to make this machinery more
> widely available.
>
> Hence, this patch moves the code into the new notes-utils.[hc] files
> which are included into libgit.a. Except for adjusting #includes
> accordingly, this patch merely moves the relevant functions verbatim
> into the new files.
>
> Cc: Thomas Rast <trast@inf.ethz.ch>
> Signed-off-by: Johan Herland <johan@herland.net>

I wonder where you got that idea from. Did you come up with that out thin air?

And here goes my bet; nobody will ever use these notes-utils outside
of the git binary. Ever.

-- 
Felipe Contreras
