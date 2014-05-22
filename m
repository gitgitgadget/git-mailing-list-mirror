From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v8 0/2] format-patch --signature-file <file>
Date: Wed, 21 May 2014 18:53:07 -0700
Message-ID: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 03:54:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnICl-00087i-1c
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 03:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbaEVBxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 21:53:55 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35867 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaEVBxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 21:53:54 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so1967619pab.15
        for <git@vger.kernel.org>; Wed, 21 May 2014 18:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uT2U+tkYiMEp+cdV/np9fXX41cvmP3nlwrziRNARlE4=;
        b=Bsp6IBeF0yzUJJ+H2COiIJlqjxfm56x5C+fIFiHCp8Kn4wkc1t42X2CbGUYmQqh0PR
         6v8gIAwnFknS8rt3l7SznGLsA2IhrEHYWTiC5SkaqOetjuI7VWkvynmWgft2vakMkyz0
         HJ6MXUnmULfsRbWJGCBuyYBvekNzQuWlb2E5uWDSWYXHx7hSjcc3NMdC7/C+rT+umqLr
         PO26yK3umLyNS2gbnX17IMH3QhsrCszFrhR+b4lDtI+6deVzP82HEItP6RibP2DXKDkE
         qOKx9HhrJxk7avgZGfZQNfYZiVbfdsDKvKf5hl7VXER7na+zmwTDgcJhvDi8D+/SVGhr
         cukw==
X-Received: by 10.66.150.69 with SMTP id ug5mr63063589pab.55.1400723634037;
        Wed, 21 May 2014 18:53:54 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ry10sm112433126pab.38.2014.05.21.18.53.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 18:53:51 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 18:53:48 -0700
X-Mailer: git-send-email 2.0.0.rc3.19.gd74db96.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249869>

v8 of patch to add format-patch --signature-file <file> option.

This revision includes more suggestions from Jeff King and Junio C Hamano.

  - Renamed variable which stores the signature to 'mail-signature'
	which better describes what is being stored.

  - Fixed a declaration after code (forbidden by ISO C90).

  - Simplified sed usage in test cases from a pipeline with
    three stages to just one.

  - Enclosed the creation of test data ('cat >mail-signature') inside
	a test_expect_* case.

  - Test cases now add one blank line to the actual signature to match
  	the signature output of Git.  Previously, the last of the output
	was deleted.

Thanks again for all the suggestions.

Jeff King (1):
  format-patch: make newline after signature conditional

Jeremiah Mahler (1):
  format-patch --signature-file <file>

 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 25 +++++++++++++++++++++--
 t/t4014-format-patch.sh            | 41 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 2 deletions(-)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
