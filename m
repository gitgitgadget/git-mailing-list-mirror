From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] cat-file --literally
Date: Wed, 25 Feb 2015 16:36:49 +0530
Message-ID: <54EDACC9.5080204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 12:07:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQZnw-0000wl-4m
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 12:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbbBYLGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 06:06:55 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37760 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbbBYLGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 06:06:54 -0500
Received: by pabrd3 with SMTP id rd3so4500522pab.4
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 03:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=poWbNiRFpVCdk1iYd3OkcDWaUHD6m+biB2jwVgAvxjo=;
        b=SvVIBe6wLkUpKGXOrHcUAXfOT+BwSef3+TuHNa6soHpR+0dRfw0Y79OPvYfwsaxttK
         IqjlWsLVoSj13izRv3HVcweCUvc4YXprMjtDxjcXoyHmRFhe3D1mZtBjQN7HYBqsnfNQ
         5moacm2FyKr0Q40JX8dO5yYKnCXXHxFOq6uEKWWkKbnW3iblFAScRx4Ty7+O8H+QvrbN
         5aeyFRaDsSh7B4dU79UUgalDzE4qN3OVK836tDFdoDztxHYGBkbZQufghKAcNOxj6wlA
         nXhhl5YpdZjnM9nC2gHrqMfwZJ3VwJeXNhKcPn11MVe0tN2CabYAWnus8bI452CcN/Vw
         ZdFg==
X-Received: by 10.70.129.200 with SMTP id ny8mr4531961pdb.17.1424862414250;
        Wed, 25 Feb 2015 03:06:54 -0800 (PST)
Received: from [172.16.4.116] ([182.48.234.2])
        by mx.google.com with ESMTPSA id kp5sm15104582pbc.52.2015.02.25.03.06.51
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 03:06:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264383>

These changes introduce a "--literally" option to "cat-file" to
allow us to read the type of any loose object, mostly the ones
created using the "--literally" option of "hash-object".

For now it works with the "-t" option as :

     git cat-object -t --literally <object_sha>

Can be made to work with "-e" and "-s" option in the future.

The first patch adds "sha1_object_type_literally()" which is
called by "cat-object" to print the type.
The second patch adds the "--literally" option to "cat-file".

These patches are in response for the patches made here :
http://thread.gmane.org/gmane.comp.version-control.git/243560/focus=243628
