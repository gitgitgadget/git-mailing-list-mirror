From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 00/13] Eliminate 'top' and 'bottom' files
Date: Sun, 16 Sep 2007 08:28:53 +0100
Message-ID: <b0943d9e0709160028h41a67474g6b379a45c4c88432@mail.gmail.com>
References: <20070914222819.7001.55921.stgit@morpheus.local>
	 <20070915234244.GD25507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 09:28:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWoYt-0008CU-71
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 09:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbXIPH2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 03:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbXIPH2y
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 03:28:54 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:14115 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbXIPH2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 03:28:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1028584rvb
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sf5B2304Srify1JFs/uI1gz3ySB6Lsk3pxyu5ln6Kko=;
        b=Ku4WsIxfeyXUGro1n9TSadr8J1BTaFzSV3XKgEhRfluOacEn7vbAIV+pu4rgo4IWxKhiP2XTb38/CfMeHYuh/7RKCshUT5eUsDvczTN/ubTar/JVqAvY/ayujInbyKLIjYlEEftnEheiu47QexWp/j2QRzYark5bffP+h8DX+i8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oFh934CuR28PYs7QOkbi8Blm0a9pY+UFMRd+UxQDSgRfZ4KloFE6iXG35awPBKrs9CqTVAWHSIoQ6+OewldE7EKRj9wrhOA/MxlP9aSWS9WLKjaMJgwJ1YqVgqd/X1lJubt/iR6jrct8em7h4zzCp4UTuqK2lEDRGlENlYLaJWU=
Received: by 10.141.78.14 with SMTP id f14mr488382rvl.1189927733253;
        Sun, 16 Sep 2007 00:28:53 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Sun, 16 Sep 2007 00:28:53 -0700 (PDT)
In-Reply-To: <20070915234244.GD25507@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58301>

On 16/09/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-09-15 00:31:09 +0200, David K=E5gedal wrote:
>
> > The following series removes the 'bottom' and 'top' files for each
> > patch, and instead uses the commit objects to keep track of the
> > patches.
>
> Wonderful! Does this ensure that there's a bijection between patches
> and commits at _all_ times, or am I missing something?

We should get rid of top.old and bottom.old as well.

My question - does this conflict with the DAG patches in any way? I
intend to include the them at some point, once I get a chance to test
the performance penalty with a big tree like the Linux kernel.

> Hmm, wait, no. Right. We also have to create commits for those patche=
s
> that don't have exactly one commit object. Not that there'll be many
> of them, but better not make assumptions ...

Is there any patch which consists of more than one commit? Maybe only
uncommit could generate one but I think we put some tests in place.

--=20
Catalin
