From: David Turner <dturner@twopensource.com>
Subject: reflog: weird options
Date: Wed, 24 Feb 2016 19:00:33 -0500
Organization: Twitter
Message-ID: <1456358433.18017.35.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:00:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjMF-00054Q-SE
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbcBYAAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:00:36 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34550 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbcBYAAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:00:35 -0500
Received: by mail-qg0-f51.google.com with SMTP id b67so28020767qgb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 16:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:organization:content-type
         :mime-version:content-transfer-encoding;
        bh=XHl6Y3S9P5si4lKu3XDHQfjmkaaq8MARRRBKi8iF0u0=;
        b=bA9ka4Lo5RsWGrkwLGxRcZdSVfB9mB7kMDhaRCm1iE80P9CEhgCXvlJhzisBcSJQFb
         HuKWqufSROPX2kjiSBRxQuDiiojAPgVzRhs6PTlf6VsP1QasDlEHSco4Is0MdwpByTE2
         EkN76lIRHlCMGbh2OLLu/987MhWfAO+TsMMpIPB8hW4ymWGvQ+JDlVnkgjQw1soAlSb5
         syIYZLm0RtuhuveexIkxpBpYFhCl2wC7WvO1CmTJuPHx7LJ/9IwpBp2YKUzblwjr44kz
         KAokwVTEFGUFB7XEPy2cjIqjzb6IjhVTfXBKGitfWkir63Ov2TZVaapmUij7+9JXXGPk
         //fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=XHl6Y3S9P5si4lKu3XDHQfjmkaaq8MARRRBKi8iF0u0=;
        b=DlHLB2fzEJ1w1O3qpjlUZuDIc8jUBXq7o3/5LNPhFWtBHqcxD83AhHB61RPyin6XmZ
         uQ2o8KavX1p0Uz9d7hKzno+3FsaC34IyqHqjYnAdrZnWQk6JNp1NEx0VA9MewA1oZhJy
         DWbsO84fp2Qwg9c5HH4PaklzTjR7BMGu1DzQWbh3PhiStZQAMO+cTnNcui/UxTciHYde
         2pXS0LOWyS+I6VyKUuiQbonyzIvEOKrfk+9QqZhWA2pG10i63CfoT5IhojIpqhD08RSJ
         DT9D3qrA+4Z4KiSiL2vAMqA6MVHaHY2a5cGkYIG6l/Gu8o+job4MKfFmVfLz28ZcTwCD
         mziA==
X-Gm-Message-State: AG10YOQSuun+RuRW/51T+bW1+PW4HaHByeBuxV87tryt8RDnaVyQ6ihDjqrZM48SJ1YNJQ==
X-Received: by 10.140.133.133 with SMTP id 127mr55347469qhf.42.1456358434663;
        Wed, 24 Feb 2016 16:00:34 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b85sm2249655qhc.9.2016.02.24.16.00.33
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 16:00:33 -0800 (PST)
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287287>

The manual for git reflog says it takes "[log-options]".  And it does,
sort-of.  For instance, you can give a path, and it will only show you
reflog entries that touch that path (I'm not sure why you would want to
do that, but you can!).  But you can also give --merges, which will
silently give you no reflog entries.  I don't know why.

One useful option that may or may not exist: show the time the reflog
entry was made.  I'd really like to say, "well, I know it was working
as-of last Tuesday...".  I know the data is in the reflog, but I don't
know how to show it.  I can show the committer date, which is usually
good enough when I'm rewriting a patch series, but that is not quite
the same thing.
 
I know I could fix these issues, but unfortunately I don't have the
time right now. It might make a good starter project for someone new to
git development!
