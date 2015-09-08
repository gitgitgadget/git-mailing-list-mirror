From: Raymond Jennings <shentino@gmail.com>
Subject: Bug in default commit hook (improperly forbidding a single blank line
 at EOF)
Date: Mon, 7 Sep 2015 18:37:29 -0700
Message-ID: <55EE3BD9.7020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 03:37:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ7r0-0000A0-Md
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 03:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbbIHBhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 21:37:33 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35687 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbbIHBhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 21:37:32 -0400
Received: by pacfv12 with SMTP id fv12so111383905pac.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 18:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=o86HaCZCAcF7aSQkvn4exIAN4TuyJSfGz5UDm8/29R4=;
        b=lU+snauWrMWpMHTOuH1f2rD1whDL2zqFoRjn9ilhFx8/3ljYBNNYbvtAxvaWGZJOZL
         tdmD+sYCYRZQqkv6xfIhwWBJ+IQoXyBe38jEl5V/63phxZ7Q3UMh+FR910VMMQhnqE4r
         /Agn36FWi2eMZLt6rpYb7TNeSqiUXlygXImDF+ADlJLxzwCVUoBuv84ATJJ4vR4LPHcK
         SckudOuzHa5nEQF/cq67mxOjGmhR7x/HGaV5f8NaO0qn+/Np6ZXoEZdVEBqNmuo118HF
         z8xXOMx2GOp8v/LPjuw50mlDAucMGI5gImUgdCgHkiHdUMySq77Y4XbKFDw6ohWOjR7R
         B9AQ==
X-Received: by 10.68.111.3 with SMTP id ie3mr52664036pbb.63.1441676251649;
        Mon, 07 Sep 2015 18:37:31 -0700 (PDT)
Received: from [192.168.1.3] ([104.36.236.78])
        by smtp.gmail.com with ESMTPSA id tq6sm1172707pbc.57.2015.09.07.18.37.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2015 18:37:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277482>

Please see https://bugs.gentoo.org/show_bug.cgi?id=559920 for further 
details.

Files *should* have a single blank line at the end, because a line 
should always have a newline at the end.

Adding a newline to the end of a file whose last line doesn't have one 
should be legal...as long as you don't create empty lines at the end.
