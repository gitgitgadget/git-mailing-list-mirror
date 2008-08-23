From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [bug] Segfault in git rev-list --first-parent --bisect
Date: Fri, 22 Aug 2008 23:20:31 -0400
Message-ID: <32541b130808222020v146e015dm8a98a005ad3e76a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git ML" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 05:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWjia-0008Ng-Qj
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 05:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbYHWDUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 23:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbYHWDUd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 23:20:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:63832 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbYHWDUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 23:20:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so460361yxm.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 20:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=WUh3LAcDnuSHjvtPSXMhg3e+e9c27YNHOLVdScvFPdo=;
        b=qNorgKx6Dkz52F546pnbStnLRKDI+VyQ3vUB/9px22H2TVGokkhCNnJsNgpNx329Oy
         +r6dUvyfzblnvKwveWpImteEt8hcv+ZfHnnl9fLjdo+ghoE3QAB6TNl3kL20EYOQK8e8
         4nuwcXs56XJeKWNDs6dw4k5dEde1UtF8ztSN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=bsOL/7R1/WX1IXB8e3B8J3aA7kd2m+/FjJnOuhjzAUTf58RrrZEN6at0z6tkzGXNKY
         EXGqAFa6taGRfGK1KPPTtMrGjp9bBc1Pt+cXTDNDPmNAzjmgjY8OJC6I5KyvobjVdG+n
         2DPsxHy64ZTC+ys3g1n93gzo8QGfMXdnNs2FQ=
Received: by 10.150.98.18 with SMTP id v18mr2946388ybb.144.1219461631938;
        Fri, 22 Aug 2008 20:20:31 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Fri, 22 Aug 2008 20:20:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93416>

I've tried the following command sequence in git 1.5.6, 1.6.0,
1.6.0.8.ga578a, and 1.6.0.90.g436ed.

    $ git clone git://repo.or.cz/versaplex.git
    $ cd versaplex.git
    $ git rev-list --first-parent --bisect 5109c91 ^d798a2bfe094
    Segmentation fault

Removing either the --first-parent or the --bisect makes the segfault go away.

Thoughts?

Thanks,

Avery
