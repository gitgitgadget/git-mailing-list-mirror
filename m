From: Mikhail Zabaluev <mikhail.zabaluev@gmail.com>
Subject: Cloning of submodule with --depth should follow the branch option
Date: Mon, 2 Nov 2015 09:55:41 +0200
Message-ID: <CAKUkx92jfjti4WGmeOHdXi2uCGTu0AifL23NzKCWg7n1vJZDmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 08:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt9xz-0005UG-He
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 08:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbbKBHzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 02:55:43 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34965 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbKBHzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 02:55:43 -0500
Received: by wmll128 with SMTP id l128so53161334wml.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 23:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=TnRgH9RVpxfUXK/6Z4qQzEi69VUiqgNsS9so1C6GR9A=;
        b=NhjH9q5eRdusxdv2wJYsOpDv2I9+FPbJyWZgLWTUl2KQMK2jTdh9zzEw3M0ENS8B9B
         7ud7FMkCOhkmEdrulM9CuxvDTWcTXEThmj7q4cyq2sW2GDQoFkUgMiD09ob/7ReSRRDF
         fj+nTzWdtHohUNCF448Z7qg3OFgCwQgbqBQAt185R+CbfA1/lsiFdZPwMCsknarcmaBi
         vPMMfd9QnziNznnTtX18KJN74Rq90xHpp305kJ0y+AH+1duRq/tLWp5p88+hgwWuL0C1
         GEQ+FBofw1w/HrYwBq7Fo+m+lKFIlcWUGOMCWscHYR8+k+4obmtmq8DYSSqxbQ3K/Zt9
         S9Rg==
X-Received: by 10.28.138.148 with SMTP id m142mr12529682wmd.2.1446450941942;
 Sun, 01 Nov 2015 23:55:41 -0800 (PST)
Received: by 10.27.137.139 with HTTP; Sun, 1 Nov 2015 23:55:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280686>

Hi,

I have an issue with git 2.4.3 when trying to limit the amount of data
fetched when cloning submodules. The --depth option is useful, but
when .gitmodules specifies a non-default branch, the submodule
repository clone invocation (which is a single-branch clone due to
--depth) fetches master regardless, and then checkout fails due to a
nonexistent tree reference. I think it would be sensible in this case
to pass --branch to the submodule clone command.

Here's a repository to exercise: https://github.com/gi-rust/gir

Best regards,
  Mikhail
