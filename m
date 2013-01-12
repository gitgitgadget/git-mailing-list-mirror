From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: git-completion.bash should not add a space after a ref
Date: Sat, 12 Jan 2013 19:35:59 +0100
Message-ID: <50F1AD0F.7080503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:36:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu5wS-0007tT-Cm
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 19:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab3ALSgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 13:36:07 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:51002 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab3ALSgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 13:36:05 -0500
Received: by mail-bk0-f52.google.com with SMTP id w5so1364799bku.25
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 10:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=KkDMn8GSyABZ93Trt3CN0KYER9sLtNccZwhIZeTECoM=;
        b=seaazsPSyt8GITaBuoOYrI3NQe7Vl1RUvWwFUpcSCY9hSAb8BdKBv5muKaU1rp+lg5
         yii7UWcRQ8U6t0YeyH4Qo8pAQ7F8DprtMspspxWjMbmNwiioef6tomC802FNRlVu9pRu
         hnxC0BaMWnK8Cht4aYYLYb8qPyzzdHZRPWmMFU4JKdgN6xmdXXxjJ/FemKJ30sWK7HrV
         8PuAlVpOWHDnJ36l9kfcmSky29p3II8xslF4A4j9I4Xo8IfM0Ql2bvhFJwJ9z/Sj4X6f
         bOyMRYl4iFtht9Wy4jOq3+AZCTDm9meBWhWzXQhflCoGZUvizO1VwSaxx1Z9jdiU00UQ
         GPNw==
X-Received: by 10.204.154.202 with SMTP id p10mr37667939bkw.29.1358015763315;
        Sat, 12 Jan 2013 10:36:03 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.78])
        by mx.google.com with ESMTPS id 18sm6638916bkv.0.2013.01.12.10.36.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 10:36:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213300>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

This is not really a bug, but a small usability problem.

When completing a reference, Bash will add a space after the reference name.

As an example in:

    $git show master<TAB>

The problem is that an user may want to show a tree or blog object from
master:

    $git show master:git.c


A possible solution is to define a new __gitcomp_nospace function and
use it where appropriate.

Probably the __gitcomp_nospace should be used when git_complete_file is
called, and __gitcomp_nl should be used when __git_complete_revlist  is
called, but I'm not sure.

P.S.:
it seems that __gitcomp_nl is **never** called with 4 arguments.



Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDxrQ8ACgkQscQJ24LbaURHmACfRXoM+uEVDgFUtZFzUcPC5oSZ
FGsAnAxQf+SN7GrNljxU1io4IuayHmed
=JRVU
-----END PGP SIGNATURE-----
