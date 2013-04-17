From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Wed, 17 Apr 2013 20:22:59 +1000
Message-ID: <CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 12:23:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USPWZ-0007nC-8a
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 12:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965780Ab3DQKXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 06:23:31 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:59275 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757912Ab3DQKXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 06:23:30 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so1299509obc.34
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yregdKnx89zg12GRSQi8RKyMrjv78AkGXmwLnqPzBXQ=;
        b=PAFmsISkPVJdBTSy5E7OpvEY6yLOKI8ApXEBs2w3bl0konPOnT2S7AZq6cM412Z0aB
         FAkhWTbJSjM8WETdqMDv5mw7zABYyYtGvfQbJNVM8TXQjED28nTrgO5MlhlFZFS9Y8qf
         V1z4nqUSJ4v8bWWr2X9mSGFURkhESvUxrPNrAosEdjOYAinH8n1n5x2diYd07O+Ucl6F
         LQ6CjENMBpHBQA7JMOuUiJ7yJnkicQTxWTDFzEkkYwLIGoGgOTjTTu2ktA9qgb6ucgqN
         bfqjpo9GnR1gLtojavQxHPUPsVId8hkbPAe/DQ9JdKOgZhm/MCO7ywaMUI8la9DKlUii
         WuHg==
X-Received: by 10.182.111.199 with SMTP id ik7mr2218520obb.44.1366194210108;
 Wed, 17 Apr 2013 03:23:30 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 03:22:59 -0700 (PDT)
In-Reply-To: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221529>

On Sun, Apr 14, 2013 at 5:23 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> This configuration variable comes into effect when 'git clone' is
> invoked inside an existing git repository's worktree.  When set,
> instead of cloning the given repository as-is, it relocates the gitdir
> of the repository to the path specified by this variable.  This
> setting is especially useful when working with submodules.

What if I clone a repo then realize it was a mistake and remove it?
With current clone, a "rm -rf" would do. With this, I'll need to
figure out which subdir in the top .git contains the repo I want to
remove. I'm not sure how "git submodule" handles this case though
(i.e. total submodule ignorant speaking..)
--
Duy
