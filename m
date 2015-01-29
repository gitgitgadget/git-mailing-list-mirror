From: Valery Yundin <yuvalery@gmail.com>
Subject: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Thu, 29 Jan 2015 23:03:47 +0100
Message-ID: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 23:03:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGxBp-00066J-20
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 23:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbbA2WDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 17:03:49 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:40060 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbA2WDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 17:03:48 -0500
Received: by mail-qg0-f41.google.com with SMTP id q108so34971372qgd.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=Gn87kh54GIBkihkgWoSXbc8D03ERx+ueG+Kpkz86lQs=;
        b=H4vJn9t1d8VLy+89Oc8iylvPJPMlNlPg/0KGhZa/iA4RDIWIsS3NAGnb7DzH8ujKPM
         Tn6et8QYBraIeFcXzhy1cYIU8/DeQ4Dwr35BdH5DpUlA6a7CBHQPsnFHtvJBZWc3IjaG
         LRHzATbjW4eifDRvU+4ax3M1Z1l9Hie87dAvnJksiIIu+gw9Mqt6zOiwCczTcssn+FFe
         5yd0UCqKW3Gweu/XKND1m7fFakq16u+gZwOvRGS2uFoyCG/VdElOkc8LE+miW1KPJ3br
         bzpKnPZ8Bcsij2/tsqFnZMrqyaMbLfS/sMihIVZUOU2YTqWzlxdpiCRhgF6yxtqIEEZx
         lHjw==
X-Received: by 10.224.65.137 with SMTP id j9mr5581293qai.47.1422569027846;
 Thu, 29 Jan 2015 14:03:47 -0800 (PST)
Received: by 10.96.46.170 with HTTP; Thu, 29 Jan 2015 14:03:47 -0800 (PST)
X-Google-Sender-Auth: xjUc6Ib1yp5i12r_Q8s5_jEpDCY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263163>

Hi,

Looks like there might be a bug in SVN import code. Here is the
command that fails

> git svn clone --username anonymous svn://powhegbox.mib.infn.it/trunk/POWHEG-BOX

r217 = 2e6cdb1f4604b2256195590fa8275632971eac42 (refs/remotes/git-svn)
        M       lhefread.f
        M       Z_plus_jet/Born.f
        M       Z_plus_jet/powheg.input
        M       Z_plus_jet/init_processes.f
        D       JJ/madgraph_3_flavours/born/nexternal.inc
write .git/Git_svn_hash_bl5Cj3: Bad file descriptor
 at /usr/lib/perl5/vendor_perl/5.20.1/x86_64-linux-thread-multi/SVN/Ra.pm
line 623.

Tested on:
git-svn version 2.3.0.rc2 (svn 1.8.11) - FAIL
git-svn version 2.2.2 (svn 1.8.10) - FAIL
git-svn version 1.8.4.5 (svn 1.8.11) - WORKS

PS unfortunately I don't have admin access to SVN repository

With best regards, Valery Yundin.
