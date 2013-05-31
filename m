From: Roland Schulz <roland@utk.edu>
Subject: ls-files -i & directories
Date: Fri, 31 May 2013 16:22:37 -0400
Message-ID: <CAO2Twbk5cvEa2uNKMg+n4DFokJ607yRDF0dUeBJkUOAY6BAD2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 22:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiVqo-0006F1-83
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 22:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429Ab3EaUW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 16:22:59 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:50289 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220Ab3EaUW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 16:22:57 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so2785780pbc.37
        for <git@vger.kernel.org>; Fri, 31 May 2013 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rschulz.eu; s=google;
        h=mime-version:sender:x-originating-ip:from:date:x-google-sender-auth
         :message-id:subject:to:content-type;
        bh=HzUImmPZytwZW2DySaHwvhxLFT8JLyt496cryLm0M5Y=;
        b=J45j75+PvtAHZSxp7cXtLOsEJ4XD903xSVh/GdmfzyoL+DY0VeROtL+PvS1wfjzRMZ
         D7BCnl8wzqxKhbaw6a0MHBvVDq/mu7TRftY8CzcXaFMB+5wogjGxFEvZBTtZeDy3Lf1K
         obbet56BSmnXJecWnW1X/TRKy2UejHQNkue+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:from:date:x-google-sender-auth
         :message-id:subject:to:content-type:x-gm-message-state;
        bh=HzUImmPZytwZW2DySaHwvhxLFT8JLyt496cryLm0M5Y=;
        b=hnJ8NJsm+8zSDdHizMU6u1AvUwGBqzN5JGuPF/tUoeUpZVulioJ61EK3mZhmGWK1lI
         ta17kREFH/UBIX7m8Vjb8xbuLUIvrgPh4KTuxVt4cdazdU04zFQqR0fkMa3Ovl5iVYBJ
         d789OyVaxSfKLZroT/AlELHhjp+h83lh0dWDqanste/NLW8bj9iI6GJpNbN6Py4EfWUt
         7voHmtkusmNVSN98ESYV2/uDvJUKK/METkx6tZIk7SwpgJlfHH71lIOe4Fg+R4XBOl1B
         Yg7kzWxlqSddZ1/RSy54hFm3/5Kp8alZFEFGv6rq5Od40WR7R4NBzGsrYjl2ikr+CNll
         Jt4w==
X-Received: by 10.66.230.130 with SMTP id sy2mr15341326pac.75.1370031777317;
 Fri, 31 May 2013 13:22:57 -0700 (PDT)
Received: by 10.70.65.230 with HTTP; Fri, 31 May 2013 13:22:37 -0700 (PDT)
X-Originating-IP: [99.127.198.190]
X-Google-Sender-Auth: 5o8e4r_KYkQBmOJJkiOaVivm5kg
X-Gm-Message-State: ALoCoQnptiLpXwBMxPTCINHVndochqRnZqfiKN1LhksoaHKDGJ1b+GzbyZll9At6LtZugBa3JB7+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226098>

Hi,

the gitignore rules work so that if a directory is ignored, all files
in that directory are ignored. While that behavior isn't clearly
documented in gitignore, this behavior is consistent across all git
tools (status, ls-files, ...).

An exception is that listing the ignored files using "ls-files -i"
doesn't behave the same way.

example:
$ mkdir d
$ touch d/f
$ echo /d/ > .gitignore
$ git ls-files -o --exclude-standard
.gitignore #d/f is correctly not listed
$ git ls-files -i --exclude-standard
#no output

d/f isn't listed even though it is treated as an ignored file by all
other git tools. That seems inconsistent to me. Is that behavior
intentionally or is this a bug?

A very similar question was asked before:
http://git.661346.n2.nabble.com/git-ls-files-ignored-and-ignored-directory-tt7570641.html
but without an answer.

Roland

-- 
ORNL/UT Center for Molecular Biophysics cmb.ornl.gov
865-241-1537, ORNL PO BOX 2008 MS6309
