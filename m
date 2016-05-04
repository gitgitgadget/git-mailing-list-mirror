From: larsxschneider@gmail.com
Subject: [PATCH v4 0/2] travis-ci: build documentation
Date: Wed,  4 May 2016 10:38:34 +0200
Message-ID: <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 10:38:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsKW-0006fz-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728AbcEDIil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:38:41 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36921 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757686AbcEDIik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:38:40 -0400
Received: by mail-wm0-f45.google.com with SMTP id a17so80362084wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N7rSo9YjRCpjdnP5YdFK3uSqZ636M+CdVyc92BPUcKk=;
        b=tc1kxnhG9Z7v5q+8u6JVv2hWGbrczY3YocLacp7tXCHCKHcrf28lVF93snXtoXi0KX
         cH03V5nRDF6mR4IX5eg9GbQq9dFeFsbK3c9CvgPLSzXm5h/bX757RcJ/ANtSo2t/0IR/
         iaNPKn0ii6X7Kh3LHyhpXfN5o1ms6L69g83CL0cPciHGTTK/WINYhUXQ468t0YwpkPNR
         DnPoCR++OyJq3Fk+Bk8vMdJB+UD9Xt3GMXv1n2kEVGi9uG5ywUNlo4XD/QKAWzBC4umn
         keNgJux0PEqLSr1IfRyAY9BEIXrNNclGGfFqkLnO8x4GGJahjazsv+avOAj9mXDuKRnl
         Ymgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N7rSo9YjRCpjdnP5YdFK3uSqZ636M+CdVyc92BPUcKk=;
        b=HBu2lXaNL5kUDQKReh3A4hvVcK1GaZvQBwZmTY87Ws1bvMIJqOBsh5ue1gSSEzvMwf
         oqf+Qitua80ONr9789w7/Fh/P4Eh8wy2Q8jXgXJf2OIconO/4ycL1jxxwBJvFqsCc94r
         rQYAt/pYvX6ktdG3DUfUTZpUXcAzXBlRTENaDArs8NLWMNbWPsEOxuqf0Du9btWlOeiw
         YGllGjqIaKcVYXE89QEg2qTQ9N5IOgBVBNVHXf/i05erO05qQZcx38pJPF3s10lDD5Np
         jTG3L+lFE7GLn9r5kOF7YNTeR3cZ8B4sgL6l7dmpxqYQFYOdPgpURYDT9QjKQgyOTeAl
         8Zmg==
X-Gm-Message-State: AOPr4FXAOuJUfaSLrCoVsdyEepI2otlEth6q4yzeF+/SyRQPy4g4AXzvhHyZkTkkEH9ysQ==
X-Received: by 10.28.210.4 with SMTP id j4mr7861522wmg.30.1462351119019;
        Wed, 04 May 2016 01:38:39 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB740E.dip0.t-ipconnect.de. [93.219.116.14])
        by smtp.gmail.com with ESMTPSA id d23sm2983014wmd.1.2016.05.04.01.38.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 04 May 2016 01:38:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293522>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v3:
* Revert the change from "{litdd}" to "--" in the documentation.
  "{litdd}" is rendered wrong in some HTML output [1], but "--"
  breaks the roff output ... I will investigate this and try to fix
  it in a future patch.
* I removed the doc link checker for now. I will try to reintroduce
  an improved version of the link checker as part of `make check-docs`
  in a future patch.

Thanks Peff and Junio for the review,
Lars

[1] https://git-scm.com/docs/git-config

Lars Schneider (2):
  Documentation: fix linkgit references
  travis-ci: build documentation

 .travis.yml                         | 15 +++++++++++++++
 Documentation/config.txt            |  4 ++--
 Documentation/git-check-ignore.txt  |  2 +-
 Documentation/git-filter-branch.txt |  4 ++--
 Documentation/git-for-each-ref.txt  |  2 +-
 ci/test-documentation.sh            | 14 ++++++++++++++
 6 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100755 ci/test-documentation.sh

--
2.5.1
