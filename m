From: Jianyu Zhan <nasa4836@gmail.com>
Subject: Is there any efficient way to track history of a piece of code?
Date: Thu, 8 May 2014 14:54:56 +0800
Message-ID: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 08:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiIF2-0002Lu-Oj
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 08:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbaEHGzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 02:55:37 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:58518 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbaEHGzg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 02:55:36 -0400
Received: by mail-ig0-f179.google.com with SMTP id hn18so2131935igb.12
        for <git@vger.kernel.org>; Wed, 07 May 2014 23:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=n7qmzim2DoT2cDMmoqzgx4ztm8SUb7YpX+WJVqRFlxs=;
        b=HviXhfnymb+F41uppYLn1umLJJR5b38D27VQxXgfQAps4K6eajHPpPCJCN3I48i/Ku
         9UDBqVA9hBFT2eL1/IZKD5A4ORnBTfJS1iq8OoLjZOFdh9ZV2DF038wNeDi+kMQvn5FO
         iT3mkw/A1iZ6auotl46XcOlbgAc/hBfOFHL+oUZNUVT+fzRMcdI5u6RsjL1iqLz12gFu
         p/JC2YwYM2EzLdQLL1DUww1IjKAV+ZYXY/pBlNJJKJEVdcev6nXks5ypXys8JXP2HdrU
         vis/mjvnfmfHTLrLtZa7TtsumkdtKhFwb4jMMb8cemSwoXc+GyBxJhd3b4DwSqXhyO56
         vMQQ==
X-Received: by 10.50.23.52 with SMTP id j20mr4878789igf.13.1399532136178; Wed,
 07 May 2014 23:55:36 -0700 (PDT)
Received: by 10.64.12.143 with HTTP; Wed, 7 May 2014 23:54:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248408>

Usually, a trivial change(like coding style fix) may bury a
original change of the code, and thus git blame is of less
help. And to address this situation, I have to do like this:

   git blame -s REF^ <file-in-question> > temp

to dig into the history recursively by hand, to find out
the original change.

Here, REF is commit-id that git blame reports.

git log -L is a good alternative option, but sometimes it seems
too cubersome, as I care only one line of code.

Is there any current solution or suggestion?

Thanks,
Jianyu Zhan
