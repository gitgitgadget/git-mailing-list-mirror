From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/2] cat-file: add a '--literally' option
Date: Tue, 17 Mar 2015 10:43:18 +0530
Message-ID: <5507B7EE.1070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 06:13:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXjol-0005kC-Rp
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 06:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbbCQFNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 01:13:23 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34863 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbbCQFNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 01:13:22 -0400
Received: by pdbop1 with SMTP id op1so79179556pdb.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 22:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=9BB+D8GzvyeFjfPWa+1eVUzg62Zm0OLWUNndnlgudYg=;
        b=nkGeKyLBM7HtF7X2MUniLQDAsi1ic6ta/81xJCllFwogs9mxNmRVXtWiQkzcl8kBxW
         TcIvf4TOtty5b1tPiGW+QAUws8z9KwgrHNhvp593GyP1vF1OS0Mu1omSOnUFbzAWzjCM
         YNOW4Aje4UIOSCbCWVhUx1frSK/p1zBUMloFvD1iOoLMKfLYajbS6EE0kH9QcH9SeTCv
         6ZOYYgdY2FON+22el6aqylyUca2u95h0/hkXSpj3mfrUACz52Pxm6sONxlFBSYpnMurW
         JLYI06HFa9+9A+PgxLexRwnoqwyfSFLXGSB4x6ygDCeqeO3y3Pzv4DXIWN32ufYnjyTv
         F0AA==
X-Received: by 10.70.125.129 with SMTP id mq1mr145380959pdb.70.1426569201631;
        Mon, 16 Mar 2015 22:13:21 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id h9sm6777211pdo.5.2015.03.16.22.13.19
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2015 22:13:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265604>

Based on Junios and Erics suggestion I have made various
changes over the previous iteration of the patch[1].

Changes in this version :
* Add a object_info::typename to hold all the typenames.
* Add a wrapper around parse_sha1_header() to get type and
   size of broken/corrupt objects without throwing an error
   whenever the type is unknown.
* Also add an option for 'cat-file -s --literally'.

Thanks to Junio and Eric for their suggestions and guidance.

[1]http://article.gmane.org/gmane.comp.version-control.git/264853
