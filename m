From: Carlos Rica <jasampler@gmail.com>
Subject: On writing builtin-reset.c, a question about git-reset.sh
Date: Mon, 20 Aug 2007 01:45:08 +0200
Message-ID: <46C8D604.4090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 01:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMuT9-0002SN-0k
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 01:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbXHSXpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 19:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXHSXpd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 19:45:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:62332 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbXHSXpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 19:45:32 -0400
Received: by ug-out-1314.google.com with SMTP id j3so459353ugf
        for <git@vger.kernel.org>; Sun, 19 Aug 2007 16:45:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=IxxEluh7lC1+BZX7YmF477/m1CrK/PpUIW5MRYP/gVDHvkCx9bH4/4hA6z0i8LeSk7LjD4r7ApsVAF6t9CHrvC5BViyy3D0AD3XxZpyGVdKYIHL42USIA8ortEgtixLiRF4M0wj9hMbGHv+T0lyMZqkShxuLRYNlMJO6eeiexqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=KwLmIpa2l1Cq+2uH+A/JQvjyugzUmxtYwWDSVZtiR7JrdrG/p8tP0ZHaca1R149WU9BnNkeIGBMEn/Mzq3S3qVYVn34s6F//nO2dbNZwdbcq/Fm+EFUslS9QwqjhTQWHCJyOE9Enohlc0ZU2xD8XEpLytyY0qDicc5o45XK+SHI=
Received: by 10.66.225.1 with SMTP id x1mr4932792ugg.1187567130395;
        Sun, 19 Aug 2007 16:45:30 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id h4sm2995003nfh.2007.08.19.16.45.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Aug 2007 16:45:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56158>

Hi, I'm writing builtin-reset.c and
I'm really stuck with a little code in
git-reset.sh:

if orig=$(git rev-parse --verify HEAD 2>/dev/null)
then
	echo "$orig" >"$GIT_DIR/ORIG_HEAD"
else
	rm -f "$GIT_DIR/ORIG_HEAD"
fi

My question is about when this condition
could fail (and then the rm executed), and
if you would be able to reproduce it in tests.
I couldn't, and asking for this in the IRC
didn't help me at all.

This code was introduced in 45d197, when
different reset types were introduced,
and it seems that there was a reason for
doing it that way, looking at the change.

Thanks in advance for your support.

--
Carlos
