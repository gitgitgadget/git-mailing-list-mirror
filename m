From: Shaun Jackman <sjackman@gmail.com>
Subject: git rebase -i without altering the committer date
Date: Wed, 20 Apr 2016 13:24:45 -0700
Message-ID: <etPan.5717e605.4004d424.12d1@sjackman03-imac.phage.bcgsc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 22:27:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asyir-0006m4-IU
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 22:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbcDTU0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 16:26:47 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33675 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbcDTU0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 16:26:45 -0400
Received: by mail-pa0-f43.google.com with SMTP id zm5so21104472pac.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding:content-disposition;
        bh=3Aj56PYt7JFNhv4I+RjCzY0ZLFAPPPy6ignazXu9r0k=;
        b=ds1GUkCaHIaVXG/IL8nIVYa3AtO2YWUZ+Ra/MXhS6awCQOYP9tagRq/c90vB6Aq+iN
         HbDkD4ne1PqwnDKwV1jB0X7LsHZ4sm8X5MVl1jVv4eOdVaYk3dfo/Ei7X2cpo9mJ4SFm
         sYp+pYna3V0VTefNQSjNJudHhItSGZ5mM2CGeWO89eXmBNPU5tMCYeScaaEn8nMeqKv/
         HdiWXiKkaia1m3p3vqQoQN1odt0urbTDuAFp8sEBhlVYsN3DYpzk560gXbjsxG732xXn
         S0sFHKz5oZC5ThNUsfBiBKXYgoe1kMK86SZWgNlznI9EMOcuawhRiGSq/1u/gxFoBXss
         4nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding:content-disposition;
        bh=3Aj56PYt7JFNhv4I+RjCzY0ZLFAPPPy6ignazXu9r0k=;
        b=G+N3aR78vlN1zDClqXO683XDWn1WLvSjNvAoHMk4LolTebJkfosli87KSEQ9GZ54aU
         A+rDXBAYCHi5LbxFWrgbbdvAbkwSk0Dc7YTiH2kgoS3tK17h/y3L0C6QRPJZV57nhI4y
         ijnHVbYBMxxy+QvxiO//jYgPGK/a18+MzKNIWoqiP/bWu3SulTN21qvzV0FzNbPWrpqc
         FqDMwEK4hcIldsf8j1IWOnul99h3wVJqyFVHoFIcs5Ckd2xIKKA7OK8ZZ/uC6HVYMYnj
         JTvvM2xD3ETXbICBTsIncn3TBdGncykmAc73PRXpuCNwdcfSUGkWipS11IZK+hlcwssT
         NFmQ==
X-Gm-Message-State: AOPr4FXWsDhduNpbY0Y/KaBS70AFGDJNdPxQFQoaugu1ZITnemv4QHVgUgHgZ1lo3JWwRQ==
X-Received: by 10.66.166.78 with SMTP id ze14mr14893047pab.149.1461184004310;
        Wed, 20 Apr 2016 13:26:44 -0700 (PDT)
Received: from sjackman03-imac.phage.bcgsc.ca (outbound.bcgsc.ca. [134.87.4.251])
        by smtp.gmail.com with ESMTPSA id f66sm100306469pff.8.2016.04.20.13.26.43
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 13:26:43 -0700 (PDT)
X-Mailer: Airmail (351)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292071>

I'd like to insert a commit between two commits without changing the committer date or author date of that commit or the subsequent commits. I'd planned on using `git rebase -i` to insert the commit. I believe it retains the author date, but changes the committer date to the current time. I've seen the options `--committer-date-is-author-date` and `--ignore-date`, but I don't believe either of those options does what I want. If no such option currently exists to leave the committer and author date unchanged, is there any chance that this functionality could please be implemented?

For a relevant SO question, see 
How to make a git rebase and keep the commit timestamp?
http://stackoverflow.com/questions/30790645/how-to-make-a-git-rebase-and-keep-the-commit-timestamp

Thanks, 
Shaun

-- 
http://sjackman.ca
