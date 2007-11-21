From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 15:54:05 +0100
Message-ID: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 15:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuqyD-00079m-5t
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 15:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756123AbXKUOyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 09:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbXKUOyJ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 09:54:09 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:55497 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755310AbXKUOyH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 09:54:07 -0500
Received: by rn-out-0102.google.com with SMTP id s46so3524754rnb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=QkX4310Yq7DrLxC8HzsSbkwD5FE7/lVTb9jgAXUOC0I=;
        b=XJHEyt6dzuCyoEju+D99VHz9cYPDDfMQr5WoiBY7DiyFvqygnfV8a+IrxgBs69pzMhZC9aOJz4Jt+wgYqn2rgm2XMUoM/Wgfjeq69oOTWZNSWlNPIC5/TWqd9eXkv8dUufK3dGJq/NjwrwFPugGqvG3XT6ILKt05BSdF6gaFPCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FWl+KtfQ3d7wNVJkQaudDMAM7TtHrgRtR9T9vsazdGk0Bj/cylwA7gzWhwY6Zxa11ej1MZOQUX+HlYh4spTn2jtwjz8Bi3vDH2mMN37p5+BFQdAbLk9ITKLZ35oUY6+z7brLPQgaAAE2fC7BVar0GtTW6yuL6jo7PdNwD/CUlg8=
Received: by 10.150.201.13 with SMTP id y13mr1301652ybf.1195656845565;
        Wed, 21 Nov 2007 06:54:05 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 21 Nov 2007 06:54:05 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65659>

Hi *,

  I have to work in a bundle-only mode, but there are some problems
with it, namely:

1) git-clone does not accept a bundle file, even if git-fetch does.
I've made a patch to use git-fetch in git-clone for this.

2) The bundles created with "git bundle" does not record the HEAD,
they resolve the symbolic name to a branch name.

3) I can "git fetch" a bundle but I cannot "git push" a bundle, so if I have:

[remote "bundle"]
  url = /file/to/bundle
  fetch = "+refs/heads/*:refs/remotes/bundle/*"

$ git push bundle

would create a bundle in /file/to/bundle with the same branches as a
normal git push, but considering the remote branches as the local
remotes/bundle/*

Thank you

Santi
