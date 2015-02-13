From: Zheng Zhang <simsicon@gitcafe.com>
Subject: Bad object pointed under refs/head/
Date: Fri, 13 Feb 2015 18:06:58 +0800
Message-ID: <CAN6kTyfiw6QPk469xV6gyL-+YB5Ca3vNHhEX7daiyn7j536SXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GitCafe-dev-team <dev@gitcafe.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 11:07:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMD9Q-0001ME-1K
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 11:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbBMKHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 05:07:01 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48926 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbbBMKHA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 05:07:00 -0500
Received: by mail-lb0-f181.google.com with SMTP id b6so14549912lbj.12
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 02:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=rw/UTFzSSVKysOsH10Im8gcNpqxw/UWXAtmjxEEDupw=;
        b=lUeCUdCQ9jDklgDZqn9Ay1+zx7khd/5TPGb0ZeZEMzIXa7eV2w2BzW5SC3INw59/+E
         0RxeL87gj7fEAXxbgjzGCym19U0Ph7vXcZbBacA9zkIEkz/46oQ1J9LL78kkx85oMShc
         m91ScK1g3JggdH2TGBQBcYpUFQN1DwQLSAoAHObiUoI+OlSBe9gEjIQWbfwfOTgbkSIY
         VZzVPuOTmr+BxipnzqPKNce/Gwr7cLoVNOrqmFc1+UkehaJRsdVSmMXF/8giqAVjGf+r
         oibrntMpPd+G0qq4CwTM/eDFdod2ZhxgN/NCsBYtxl8y7u9BuKTDu44QyHxPXnQe2tIS
         zPrA==
X-Gm-Message-State: ALoCoQmtBCgn3OB3WthBYXcINT9o6g29MPRGH07TKLku5Y4rI4keCEdNNFb7sjM7HLrEk9Qo2tkL
X-Received: by 10.152.25.165 with SMTP id d5mr7182909lag.43.1423822018904;
 Fri, 13 Feb 2015 02:06:58 -0800 (PST)
Received: by 10.114.81.100 with HTTP; Fri, 13 Feb 2015 02:06:58 -0800 (PST)
X-Originating-IP: [192.241.225.190]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263804>

Hi,

I was running some test with Git 1.8.4.5, then I accidentally met a
problem that leaded to the following error,

> > error: refs/heads/develop does not point to a valid object!

Turns out that the sha in refs/heads/develop is a bad object id, this
happened after merging a branch X to branch develop, but packed-refs
is updated to a corrected sha. No other merges at that point.

The fix is easy, just removed refs/heads/develop.

So there were two sha created, one is updated to refs/heads/develop,
and the other one which is corrected, updated to packed-refs,  Weird.

I am wondering if there is a way to prevent this happening? Is this an
ancient bug?

Many thanks

-- 
GitCafe.com
Share a cup of open source

Zhang Zheng
@simsicon
