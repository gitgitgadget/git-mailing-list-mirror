From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/2] Reuse the same temp index in a transaction
Date: Sat, 12 Jul 2008 11:24:24 +0100
Message-ID: <b0943d9e0807120324l7674c010w9a8e4a0bbdeeee65@mail.gmail.com>
References: <20080702060113.11361.39006.stgit@yoghurt>
	 <20080702061314.11361.28297.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 12:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHcI8-0004Qm-5B
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 12:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYGLKY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2008 06:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbYGLKY0
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 06:24:26 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:59729 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYGLKYZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2008 06:24:25 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2493738waf.23
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BJmtf6wBxraSiewaRSKpvMVWWeVKkxuDBVP7uQp5E5A=;
        b=joj4F/3nR24uqHqHajoGUWiHSs+AgOWpZjggqg0+4ROeErZBpkBbNt71010GUWdoTQ
         ch7u8vyPdefXqAqG7989o94GM3eJWHLiIUTjO9r7djJe7OhVQ3FHCkEZfsDHdhRAZpHq
         a25R9bjFIHbDku6DMobX1jC/u9YjVUdI7L5Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FpuiFRVJ2XPJVWmj/axv2bfB5cjbE9NMvEUHW3qpTkFguoBwbb7FR20NYh39GEWJj0
         Tap0pzjgV/iYRbPlwaASzkpNdaEObObVFEn3mQVfCDIl0EqubZVDUuuBTyzzn1VBhzad
         ZvaOcfCfyEuDan72MVNTJiRYF+rH2KgBC1Dfg=
Received: by 10.114.66.8 with SMTP id o8mr15438314waa.135.1215858264850;
        Sat, 12 Jul 2008 03:24:24 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sat, 12 Jul 2008 03:24:24 -0700 (PDT)
In-Reply-To: <20080702061314.11361.28297.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88232>

2008/7/2 Karl Hasselstr=F6m <kha@treskal.com>:
> Instead of making a new temp index every time we need one, just keep
> reusing the same one. And keep track of which tree is currently store=
d
> in it -- if we do several consecutive successful pushes, it's always
> going to be the "right" tree so that we don't have to call read-tree
> before each patch application.
>
> The motivation behind this change is of course that it makes things
> faster.
>
> (The same simple test as in the previous patch -- pushing 250 patches
> in a 32k-file repository, with one file-level merge necessary per pus=
h
> -- went from 0.36 to 0.19 seconds per patch with this patch applied.)

That's an impressive improvement (together with the previous patch).
Is this with the new patch log infrastructure?

Thanks.

--=20
Catalin
