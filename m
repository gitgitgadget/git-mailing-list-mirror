From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Tue, 24 Aug 2010 17:37:42 -0500
Message-ID: <20100824223741.GB2376@burratino>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 00:39:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo29b-0007fZ-PY
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab0HXWjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:39:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37317 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0HXWj3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 18:39:29 -0400
Received: by vws3 with SMTP id 3so923647vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=I3mks1Ck90Q15NR3b/BaoV35VqKlZpf1ooKtSNITDY8=;
        b=B2q6aMPpPQQJmLv0MUSk1ukck6FP5WMX4tn5JpFIreI3Lvg8GKY7ZGC4ACJ3GPVqWy
         oA/VotWFiA86uRBNw0nzpGhR+dOkpKxFp7NDSEelyNV7xgN8lfsuYVxwdyk8XnpFdvGL
         pbps7mXfWswHipDcUMmYlHPN60supnS7z1Ld0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HUGVckIatA4hEbTqY82y8p0OQuBOMhg3O1PA7tFxlFBA5tUsnvdwlZU+vAHU8WoM46
         iecwyrnn8t7puHDi3CMQLTve4a9+wULhgOqyInD6YH0bkt+c/FzT0nQDOeEpXzzcpLK9
         CHOERE2wOEhcKfYXMDeur/BZHRi9JQjpzvveY=
Received: by 10.220.127.37 with SMTP id e37mr4272526vcs.171.1282689568947;
        Tue, 24 Aug 2010 15:39:28 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n9sm343594vch.19.2010.08.24.15.39.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:39:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154377>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Patches 26..30
>   Add upload-narrow-base command
>   rev-list: traverse some more trees to make upload-narrow-base happy
>   narrow-tree: add oldest_narrow_base()
>   Add command fetch-narrow-base
>   merge: support merging when narrow bases are different
>=20
> Remote merge part.
>=20
> Split a merge operation into two parts, the real merge will be done
> within narrow tree. Conflicts can happen and be resolved in the narro=
w
> index, locally.
>=20
> Everything outside narrow tree will be merged (trivially) by
> server. Then server sends the base tree back, so join_narrow_tree() i=
n
> patch 20 can be used to create proper commit.
>=20
> Server can disable this remote merge feature, which means users are
> forced to do rebase/fast-forward. Not too bad.

Yikes.  Na=C3=AFve question (please forgive my laziness): is it possibl=
e to
merge without remote contact in the boring case, when no changes have
occured outside the narrow tree?
