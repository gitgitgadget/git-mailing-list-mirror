From: Dmitry Gutov <dgutov@yandex.ru>
Subject: 'git diff-index' doesn't honor the 'diff.algorithm' variable
Date: Sat, 14 May 2016 02:45:21 +0300
Message-ID: <9d15b6c8-ed97-7352-3df1-efab1b4ffadb@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 01:45:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Mlw-00084a-MJ
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbcEMXp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:45:27 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37568 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbcEMXpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:45:25 -0400
Received: by mail-wm0-f52.google.com with SMTP id a17so52464968wme.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=1uINis1Fr5UY63jfxeKG8PS5P4EGaBPQhABSHFjWRys=;
        b=Am5/2BzruAr0WNvHgIEhwexFLR0w640LdO0QvfZWUcM0NVkgovDngt03XjYjPtueON
         rPdFk05CTEuovr4JLSudIfHm0eegp5p/2OeOtlQhFr/NhP1/QVXtLqUn0Wt5sgfIUyf/
         VgqyzX0sReAwugDqksyxq08T5n56UgwrSTNyxDOs7q0rKoTntDA4j+PYRqAkVRw39Dst
         OsWTEaQ7v5F0Kice9ZB6hWH69HJUGT7u8DI27TrisYAFCfKsLTpt+HLr7yTopnzICADa
         omR/OXKsU7V3KfSEpOUi/7hlfLH96+notxzeW0Ii8AFGZdfrkd/Zu7cQYnF5uZgsDrCK
         2YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=1uINis1Fr5UY63jfxeKG8PS5P4EGaBPQhABSHFjWRys=;
        b=L1OhFXB9rQiRkT23RZcj0HgcG5IMDgCOByvV8H7VwlL16OOaboKG1rtROR8SV/gmsz
         ihDP/YqTaBCkjjwdNuq/+wVYbywMTNIk3wlNuB/w39bCxZgtkz7TKVHt8L3SLAWF6X/e
         B3RYapcZA4Qow6lDB5Bd716x2wdwD5FbxigOjBaxv8Wgq1Aas2VadoV9tMeR/DFN5haJ
         +SAhsWf+ys3K1MzwIYBrbKaIkSFIWBfX/qq8itrGpol8CL1zWj8866jOhi/gNCSbETeg
         xN91kB9hc6OJkI2v3FxDu3CDhvzc7KHW8gQI/W53wYKHPLAViyqoDSp3AHfrpDi7sUIu
         687Q==
X-Gm-Message-State: AOPr4FVGjDoIKIXoa8zDcXKNswn3p25EXYvSC6S/obHCZcb4U2AUgGnND+16ecgvi/Ujmg==
X-Received: by 10.28.25.69 with SMTP id 66mr5765782wmz.39.1463183123449;
        Fri, 13 May 2016 16:45:23 -0700 (PDT)
Received: from [192.168.1.2] ([185.105.175.24])
        by smtp.googlemail.com with ESMTPSA id y1sm20777766wjy.36.2016.05.13.16.45.22
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2016 16:45:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294598>

Hi all,

Subj. ...even though it's explicitly mentioned in the subcommand's man 
page. Git version 2.7.4 here.

To elaborate:

- Call 'git config --global diff.algorithm histogram'.

- Try the example from http://stackoverflow.com/a/36551123/615245.

'git diff test.css' gives the expected output using the non-default 
algorithm.

'git diff-index -p HEAD -- test.css' uses the default one.

Best regards,
Dmitry.
