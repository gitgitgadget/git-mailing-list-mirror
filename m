From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Extending .gitignore
Date: Sat, 18 Aug 2007 02:43:50 -0700
Message-ID: <C0E9F681E68D48EB8989022D11FEE3D1@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 11:44:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMKqo-0005Fn-27
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 11:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbXHRJn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 05:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756295AbXHRJnz
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 05:43:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:22659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbXHRJny (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 05:43:54 -0400
Received: by wa-out-1112.google.com with SMTP id j4so149981wah
        for <git@vger.kernel.org>; Sat, 18 Aug 2007 02:43:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=rwSD48okAUKpGCtvENS9ktkmOWgrsPqmQrGytsNkJ4Hl4HtVPghR0ogwY3x7A5b/VYdrEtk+9QpQ/Xf6g4wxDdvFaXmOOmNvZ31eX03Y5HqqYX6ZHXGikEe2GeIXB4spnUhRrtbSUoE5KplclSANfOLcDiR4/3SvdXRDfZQUH2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=IOAZcCG0ufpe8pcuF9v1KcEki4vTlZWo2XVAZPU5n5+0/HxilhbrZAJuw0ymz7Da/LJpCoxnWJA4+QlV3GSghyS3mBajAHozyWzR7mJEu8C6LaOwxWYQgfqnWhDaw1lDlWoUtBrurU+OW95oUqqkhi+5v4OuqoEVhGAetsuWN1w=
Received: by 10.114.149.2 with SMTP id w2mr433548wad.1187430233273;
        Sat, 18 Aug 2007 02:43:53 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id j26sm3255222waf.2007.08.18.02.43.52
        (version=SSLv3 cipher=OTHER);
        Sat, 18 Aug 2007 02:43:52 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56104>

Currently .gitignore serves (at least) 2 purposes:
1. Specifies which files to ignore during git add
2. Specifies which files to ignore during git cleanup, but still deletes them with git cleanup -x
So it effectively splits files in 2 categories.

I always find myself with 3 categories of files:
1. Important files that I want tracked by SCM (normal files like *.c)
2. Unimportant files that I want ignored by SCM and cleaned (usually build files like *.obj, *.exe)
3. Important files that I don't want to be tracked by SCM but also I don't want them to be cleaned either (these are usually 
machine-specific config files)

So I want to be able to say to git: don't track this file, but don't delete it either (even with clean -x).
What do you think? Does it make sense? Can it be done right now?

- Dmitry 
