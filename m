From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANNOUNCE] git send-series v0.1
Date: Sun, 18 May 2014 19:37:43 -0500
Message-ID: <537952579dba1_10da88d308ed@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 02:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmBl7-00080S-O2
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 02:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbaESAsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 20:48:50 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:64036 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbaESAst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 20:48:49 -0400
Received: by mail-oa0-f51.google.com with SMTP id n16so5397843oag.38
        for <git@vger.kernel.org>; Sun, 18 May 2014 17:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=1P/RI0h8VRQXmhe6tb0FgEd4OyrJzzxOSYWvJe19XSE=;
        b=lsvvAsuEqhLh8/K7gVSp33afVO9d/FdGABRWP+vpt3eRAeDTIIr8S8NeYlnHz9Z0v8
         sKVShqoCL2TL+buOmHWwqUjDBMub4i1z6eYOp+7VHITf8Cb2odfZkzUtStnYDcZOc248
         C9ypEkfJ9IO8AMB4vc5Q3fbYBpFEP4Roe7fJVc5rMxjhkPp7ZgcB5EUVwTvI7CtY6VXO
         VW/NLgwSewo4ZB8Xz6YZTG/tyAabuS3vxWzeVanInBroAwz0LSNArWNEhVfjNDMbeS0V
         u6c89u81zj0XEzqrbzHG2SpS7xDK0Ux8TlxPQegjxVa49lOCKjELbZ4odPLW27o19KTe
         gCnw==
X-Received: by 10.60.74.163 with SMTP id u3mr32988179oev.2.1400460528847;
        Sun, 18 May 2014 17:48:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm31802202oeb.3.2014.05.18.17.48.47
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 May 2014 17:48:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249556>

Hi,

This tool allows you to maintain a patch series more easily. You can store the
cover letter, the cc list, version of the series, and other metadata.

By default it will use the currently checked out branch, and show you a
template like this:

------------
version:
cc:

Subject

Content.
------------

The first part is a YAML document with all optional fields, such as 'version',
'cc', 'to'. You can store any information you want using the YAML syntax.

The second part, delimited by a blank line, is the cover letter. The first like
will be used as the subject of the cover letter email, and the rest as the
content of the email.

Then standard tools will be used to send the emails: `git format-patch` and
`git send-email`, which you must have configured before using this helper.

In the end a custom ref will be created to save the current state of the
branch. For example, if you want to see what was the status of your series of
the branch 'feature-a' in version 2, you can use 'sent/feature-a/v2', for
example to create an interdiff to see what changed between one version an the
other.

Enjoy.

https://github.com/felipec/git-send-series

-- 
Felipe Contreras
