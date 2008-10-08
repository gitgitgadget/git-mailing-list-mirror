From: "Imre Deak" <imre.deak@gmail.com>
Subject: git-am: can't apply to an empty repository
Date: Wed, 8 Oct 2008 16:24:27 +0300
Message-ID: <500f3d130810080624g23b4ed1ckde5d63082dca9040@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 15:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnZ30-0008TO-6L
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 15:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbYJHNYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 09:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbYJHNYg
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 09:24:36 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:33664 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbYJHNYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 09:24:35 -0400
Received: by gxk9 with SMTP id 9so8009407gxk.13
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=uM4DbCDXLjpkFT2rGg95iJg4FthhqW6fj1Jp6rz4Zec=;
        b=VjgFviKGRfZ0IMqQA8U+4wu+0NPnF8RKqiQQCz/8x172Zmu7K5tvCI9BTpw6ZgQVVC
         HZS016SfP052RsiEBcfNl/XTDm8l0iJD/Vf4TOpTuVOk9llyC6jb2FV9GFBO4w9EFbB4
         DC5xqAsW4zRcjyuo7U8morMoauhm3rPYmJpYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Zj+njeoItbCTfWyum3OHXiObcZ847Zs/BPKt6qxsHF4eT9/mju6sjJgLcCFEi0AR0A
         u+DHwelR9rzYpjN/QB/sAD0WJwzbgsEfXl2xV8ZH4iraO6pcZBOSzv2V6H/40yWBhEey
         DIbClxzAotUESG7/2CstdLfPNY6PueaFE1S6w=
Received: by 10.150.216.3 with SMTP id o3mr515755ybg.218.1223472267427;
        Wed, 08 Oct 2008 06:24:27 -0700 (PDT)
Received: by 10.150.123.11 with HTTP; Wed, 8 Oct 2008 06:24:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97798>

When trying to build a repository from mbox format patches I have the
following problem:

Creating a hypothetical mbox patch:

$ echo "From: imre deak <imre.deak@gmail.com>" > 1.patch
$ touch a
$ git diff --no-index /dev/null a >> 1.patch
$ cat 1.patch
From: imre deak <imre.deak@gmail.com>
diff --git a/a b/a
new file mode 100644
index 0000000..e69de29

Apply it to a newly created repository:

$ git init
Initialized empty Git repository in /home/imde/conv/git/.git/
$ git am 1.patch
fatal: HEAD: not a valid SHA1
fatal: bad revision 'HEAD'

Is this supposed to work at all?

--Imre
