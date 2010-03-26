From: Paul Richards <paul.richards@gmail.com>
Subject: Enumerating all objects in the Git object store
Date: Fri, 26 Mar 2010 15:31:28 +0000
Message-ID: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:38:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBcC-00059V-GP
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab0CZPiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:38:23 -0400
Received: from mail-ew0-f221.google.com ([209.85.219.221]:45956 "EHLO
	mail-ew0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab0CZPiW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:38:22 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2010 11:38:22 EDT
Received: by ewy21 with SMTP id 21so2184570ewy.25
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=7s8MgoJhiw/P4DUJIVMTxjG8A2AWTVx2g8G40vPBD2s=;
        b=nyin4mLjIuYbm95aCG8my+8fXHRpvbGozbRuCRya0jN+7e+K0j7ptS44k2kjo5CSzM
         7KcR1BvRzswHhDIyNhfxjvLH9f9PG1SXz7AUrxJwwl+BIINEhVdFFu5SlDMlg0tj2TgH
         IzFDNrBKKuQ6KZNVFufmTG1oDxaX3EB1lSYm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Zgn2VsmBXTQS7i0EmYojP8UES9Sx1atBr56qjMHbCYSH4L8JEO7Imyj08LlA+ZxsCQ
         YvZ2LVZY4tBhsuwH2A9ICKCLIxa//eJZDZIzIp3uGxoktgB3uoaRCMSnGgzV5dq084U6
         njIiaPCWczcPKoMgP7qxjj3G561XKitYFNmmM=
Received: by 10.213.17.68 with HTTP; Fri, 26 Mar 2010 08:31:28 -0700 (PDT)
Received: by 10.213.49.200 with SMTP id w8mr310788ebf.80.1269617488237; Fri, 
	26 Mar 2010 08:31:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143252>

Hi,
I'd like to visualize the objects in a Git repository using Graphviz
and "dot".  I'd like to see commits as circles, trees as triangles,
blobs as rectangles, and have arrows linking these objects showing how
they reference each other in the Git DAG.  For small repositories this
may be a useful way to visualize how Git objects work.

I could not find a pre-existing script to do this so I am considering
writing one.  Is there a way to enumerate all the objects in the Git
object store, and for each one figure out its type (commit, tree, or
blob) and obtain a list of the objects it references?  If not, is
there a way to do this for a single object at a time?  (I can then
simply recurse through the whole structure.)


-- 
Paul Richards
