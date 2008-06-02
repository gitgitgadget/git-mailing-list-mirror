From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [StGIT BUG] StGIT errors out on rebasing patch deleting file with Unicode filename
Date: Mon, 2 Jun 2008 09:39:05 +0200
Message-ID: <200806020939.05902.jnareb@gmail.com>
References: <200806011046.51872.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 09:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K34eP-0007nU-BL
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 09:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYFBHjN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 03:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbYFBHjN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 03:39:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:20623 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYFBHjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 03:39:12 -0400
Received: by nf-out-0910.google.com with SMTP id d3so378594nfc.21
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=moW7uys0Vn4nT3UZyZGwChe6NyduNcbdtWCHiyNc894=;
        b=vuCi7+qucxVZZ8iQ50B1edEmE34czmGFS7Ity3CzQMcbNZ8LVmmBpKnjSLk4IYdb/omjBN1Z2WQJGWa+XsnW2GxRv/hibSzeJ+Xnvqg3xpNaiGbpJcgCX7zYf5GiA1OSwP+AEF5AyYvFoxyHp0GO8maffXSk+OAeYcnjKvQVFMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PAe4xhe35YoA25gXsCwHt3np98bwfcJmKN3qCrI4irMWCA0TrGi/scQTldaVouzy6qnZfylUdSHt0OAEy5Jnv0cE4aZiiI9M83hCBApX9zLTBg2DPKDbDeLHFSEL0iJ2adlU/g+A18h0OmWwYFf5QPBfkFdU3tW95IeTJgj0owg=
Received: by 10.210.124.15 with SMTP id w15mr4192495ebc.106.1212392351233;
        Mon, 02 Jun 2008 00:39:11 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.195.117])
        by mx.google.com with ESMTPS id f13sm5430827gvd.2.2008.06.02.00.39.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 00:39:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200806011046.51872.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83498>

On Sun, 1 June 2008, Jakub Narebski wrote:

> StGIT errors out on rebasing patch which deletes file with Unicode
> characters in filename (with characters outside US-ASCII in filename)=
=2E
> The patch in question is patch deleting gitweb/test/* in git director=
y,
> and is present already on the 'origin' branch (the branch we rebase
> onto), so stg-rebase should result in an empty patch (as first patch)=
=2E
>=20
>  "gitweb/test/M\303\244rchen" |    2 --
>  gitweb/test/file with spaces |    4 ----
>  gitweb/test/file+plus+sign   |    6 ------
>  3 files changed, 0 insertions(+), 12 deletions(-)
>  delete mode 100644 gitweb/test/M=E4rchen
>  delete mode 100644 gitweb/test/file with spaces
>  delete mode 100644 gitweb/test/file+plus+sign
>=20
> I guess the error is caused by using unescaped (quoted) filename.

You can WORKAROUND this bug by setting core.quotepath to false.  This
allowed me to make stg-rebase.
=20
--=20
Jakub Narebski
Poland
