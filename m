From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A few "linked checkout" niggles
Date: Thu, 16 Jul 2015 13:39:27 -0700
Message-ID: <xmqqd1zr4z28.fsf@gitster.dls.corp.google.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:39:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFpwO-00074i-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 22:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbbGPUjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 16:39:31 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35586 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbbGPUja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 16:39:30 -0400
Received: by pabjr20 with SMTP id jr20so5261587pab.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7hD5DREht0HRMKaJkUGO+c2SG7kPO4jdeuhDXf+Ar/Y=;
        b=FDT+KFkJEpSv8ss1K2ENEAVU0F280+aGryE1IjbsqawwcrrzHBVFneZwEvR98wyZhz
         Ha2pts8HLu5hgGUODWcn64wsYLJlYxKPjd2lHWdMgXqWddP2doNLDnm4yFHWB1bvM7p+
         yI7uLkJTDqmYclkAC4cHkf+4v7tdMja/W6tqTq7vzEV2Osl9Tn+SMuF2y5KOUJK7xCil
         S4qWWXndXWmt8lRLyl7GbXhqCu8CCSHDpoPfFRpNk6Efi39M+Q4yFvxliZm7Xj4XoF3w
         uDHpg7J7GMbXrNNWtguciDnDNR+isIy08jLc0Sdus4RV1SqLoigbJVPL9oWnlNPqu7w/
         9TeQ==
X-Received: by 10.68.178.229 with SMTP id db5mr22533488pbc.17.1437079169760;
        Thu, 16 Jul 2015 13:39:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id v8sm8841427pdm.89.2015.07.16.13.39.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 13:39:29 -0700 (PDT)
In-Reply-To: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Jul 2015 16:13:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274043>

Also in a linked checkout of git.git itself, t5601.21 seems to fail
with:

fatal: Not a git repository: /home/gitster/w/src/.git/worktrees/rerere
not ok 21 - clone respects global branch.autosetuprebase
#
#               (
#                       test_config="$HOME/.gitconfig" &&
#                       git config -f "$test_config" branch.autosetuprebase remote &&
#                       rm -fr dst &&
#                       git clone src dst &&
#                       cd dst &&
#                       actual="z$(git config branch.master.rebase)" &&
#                       test ztrue = $actual
#               )
#

This test is running in /home/gitster/w/rerere, whose .git points at
that directory the fatail: message complains about.
