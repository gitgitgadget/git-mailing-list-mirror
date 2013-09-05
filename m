From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Thu, 5 Sep 2013 23:52:22 +0700
Message-ID: <CACsJy8DKL9KnPAXcf+NPU_Y5J1Dz_pYxSpONN4LxcQVi1JOBYw@mail.gmail.com>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg> <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
 <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
 <alpine.LFD.2.03.1309042350560.14472@syhkavp.arg> <CACsJy8BeU_01c0f5RJExcYo7xGETnduKOw-_shszHd0ZFgZDXw@mail.gmail.com>
 <alpine.LFD.2.03.1309050024090.14472@syhkavp.arg> <CACsJy8CX=4Oz_h2NtS3FRdK6_zdFksa+JR5C6Z-z3Y70PLAsyQ@mail.gmail.com>
 <alpine.LFD.2.03.1309050131000.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 18:52:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHcnh-0006TS-VY
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 18:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab3IEQwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 12:52:53 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:45295 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab3IEQww (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 12:52:52 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so2581226oah.34
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Yz/Fzx4dL89JXK6b07qdedCMN1He6c5TerXrkxXsZeA=;
        b=tcOvwyQxzGQB07qJKEiC5CLmusQKXm3T3NGdWkvsB6EbifU0iCJKLzcwB7rywho/ja
         nkd5XB6ELssQKESfo0qSHw2s6NXUlEnNkSJlwzuugr2nnt1+GoK44ww7FydRSCXOT5Jf
         JXV/jzb8Rwt/amdr2SGJBUP+q23YQYpZn3Yx+du5RzadpXMsaamwQAFqqgMU7trkytXN
         9h5XIjBac/0ZV7p33Q9R66JKSEsy+dwPE3hJd3AnGTfBxvG0GLRF8tjcswqB9N6r0IL0
         zUuCOpUBdldXSwiNtFpbRn54T2AHGULm/K76PaF95gPgBUAaMceIaHHEdn5I7VWsNYXa
         S8Pw==
X-Received: by 10.182.96.169 with SMTP id dt9mr7039859obb.76.1378399972407;
 Thu, 05 Sep 2013 09:52:52 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 5 Sep 2013 09:52:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309050131000.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233968>

On Thu, Sep 5, 2013 at 12:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Now the pack index v3 probably needs to be improved a little, again to
> accommodate completion of thin packs.  Given that the main SHA1 table is
> now in the main pack file, it should be possible to still carry a small
> SHA1 table in the index file that corresponds to the appended objects
> only. This means that a SHA1 search will have to first use the main SHA1
> table in the pack file as it is done now, and if not found then use the
> SHA1 table in the index file if it exists.  And of course
> nth_packed_object_sha1() will have to be adjusted accordingly.

What if the sender prepares the sha-1 table to contain missing objects
in advance? The sender should know what base objects are missing. Then
we only need to append objects at the receiving end and verify that
all new objects are also present in the sha-1 table.
-- 
Duy
