From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Bug: t5813 failing on Cygwin
Date: Sat, 07 Nov 2015 12:11:29 +0000
Message-ID: <563DEA71.1080808@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 13:11:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zv2LL-0002kX-Ik
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 13:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbbKGMLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 07:11:34 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37626 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbbKGMLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 07:11:33 -0500
Received: by wmll128 with SMTP id l128so60411693wml.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2015 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=u4GnVCDusG97wqEF/f1LOu/FwnfJsSEWrw3ZhTEC2Lo=;
        b=uwhvOkMbDLsLLD4oPs2r4t2m0qSMcetqaKkSXq2Ixvr9XwPNNq1Lqs+GnNUtZpkBPV
         uG2+wOIXj6LGowhPjpG7udVQp47dFneXhjJnXuw6y8E/iLrJxfVb9dOjez7S/vMBGlpD
         X19IH0QWKWGaTgXdSa2KgOhOg29QEt6R92DrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:content-type:content-transfer-encoding;
        bh=u4GnVCDusG97wqEF/f1LOu/FwnfJsSEWrw3ZhTEC2Lo=;
        b=JEYbc9P0TZa/JK9qbvVduwq/Px6TaLPJh3D73EG4ljgJIzEsRiqcLC1Qzl1NCeY06K
         SpUxpJUoHG3pNK63fW7iU9GYCqG0eCH2wwHgrSaPFsDKBzaD/10qjBbeniMGSWh7xgFL
         Wz3es5N1vKjz0zG0cKtqIa5Y1jzrQX/U5DveS4yevYOGjhwQ8OK/X5Gy5jtoalqEO6jQ
         QQjzFTrU6UGtd/cgNWXaJ+AXeFqYZIdRjHqEPiLsstAGTw6oeO/+abkhSZJKHmIKTcI7
         TM1nXJ7f8ke6Q8ZgZz7Ci91arSXD9cy8nUuYefKu7/zwcmq+mV76sb42iUqu9OSbZ+zl
         SLTw==
X-Gm-Message-State: ALoCoQmUvSzEjQ3B4jVZl39lOUtkrd3G2ZTJDAaOnH7nlme2uuo5yMFc90qqTo1nfOAJBpbD9lh+
X-Received: by 10.28.4.144 with SMTP id 138mr16422988wme.32.1446898292330;
        Sat, 07 Nov 2015 04:11:32 -0800 (PST)
Received: from Wheatley.lan (19.207.199.146.dyn.plus.net. [146.199.207.19])
        by smtp.gmail.com with ESMTPSA id h7sm4844284wjz.7.2015.11.07.04.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2015 04:11:31 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281017>

In the process of pulling up the Cygwin Git release from v2.5.3, I've 
discovered t5813 is failing, and appears to have been failing since it 
was first introduced in a5adace.

I've not yet done any significant digging into the problem myself; I'm 
reporting here now in case in the hope someone else will have a better 
idea what's going on.

Specifically, I'm seeing t5813 subtests 9-13 and 15-19 failing. This 
happens with a clean build straight from the Git source tree (git clean 
-dfx && make configure && ./configure && make && cd t && 
./t5813-proto-disable-ssh.sh) as well as builds using the Cygwin 
packaging paraphernalia.

Adam
