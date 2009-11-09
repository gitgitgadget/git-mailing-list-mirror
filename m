From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 2/4] Teach the --multiple option to 'git fetch'
Date: Sun, 8 Nov 2009 19:59:46 -0500
Message-ID: <76718490911081659u318ea362l29342a9b3d90f03f@mail.gmail.com>
References: <4AF6E7DE.1020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 02:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Ic5-00055P-3E
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 02:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbZKIA7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 19:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbZKIA7l
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 19:59:41 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:38792 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZKIA7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2009 19:59:40 -0500
Received: by iwn10 with SMTP id 10so2040833iwn.4
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 16:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ajtM58BuqefBHIkSi58Y86huCtyS1FERf1A7gl4pzkw=;
        b=Z29ME6PWMZTTLnvV+rvrhishLDeeq8gOvkFjDRmPI2Gzc5sQ00kH2z10qaxC/+xWJG
         DU9Rk9CckxRVvloRnJyatz18AkWhvkAEb91RoDMjkf7TJL809zFPQ2/LUdIOapeUbflw
         k6ZLM2fSsD9p3FJQI7FSrlPglFAc64gC0QJPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bbkn0LXrvSXFUR9niF6wOJVs3ItfWF4o8boDcGCNwlSPvlH3JNph+vryAq4axFhcJd
         HLsLhwiUJ2FTZDnBsV2E7Xr6e/A0T+2ij2tNDu3xT2v5kcf8oSrCqQ1NMiJAzByRAmuz
         wzBb+vAJ7kx0MUUG2lcIueFHpxGWNeKwWNXTA=
Received: by 10.231.122.36 with SMTP id j36mr8314630ibr.21.1257728386241; Sun, 
	08 Nov 2009 16:59:46 -0800 (PST)
In-Reply-To: <4AF6E7DE.1020201@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132433>

2009/11/8 Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>:
> Add the --multiple option to specify that all arguments are either
> groups or remotes. The primary reason for adding this option is
> to allow us to re-implement 'git remote update' using fetch.

Can't this be determined automagically by inspecting the arguments? I
believe there can be two unambiguous usages:

a) git fetch <repository> <refspec>...
b) git fetch <repository>...

If there is more than one argument, either:

a) arguments 2...N must be refpecs (i.e., each must contain a colon)
b) arguments 2...N must NOT be refspecs

"The format of a <refspec> parameter is an optional plus +, followed
by the source ref <src>, followed by a colon :, followed by the
destination ref <dst>."

j.
