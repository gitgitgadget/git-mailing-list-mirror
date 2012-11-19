From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Should --pretty=format:%b respect i18n.logoutputencoding just like
 normal "git log"?
Date: Mon, 19 Nov 2012 20:08:31 +0700
Message-ID: <CACsJy8Ag7wZCKeTM-fW7MUjWs=7xq7ciwhfx4kroJupwvs0dXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 14:09:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaR6E-0006Re-E7
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 14:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab2KSNJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 08:09:03 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46257 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab2KSNJC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 08:09:02 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so4772813obb.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 05:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qenyAOdI+IZZYU0AO7F+iQSiCSLOWI5IJVyNQYRpRAY=;
        b=ZzBeXzh1oNuM+efL1u0IMv1QRp1/mRbUmmsV4nvYI4QZTqG9hiaAVwknyFgbpehoda
         NWSh0oLGJHRM/IXQi6kHgDy1P5szjq7ivxiYvAsCw9WCO/eEnTbB47cUE6MclKDNN6Vn
         8ouirlzirn1jowUbexsJr3FQF4yRsYDYE7pLz3PAH8hR1bl1dNcRLRJNNqqOBzbs/2Nr
         xv/CBrgVT9aNk2BJKbx/0Ns5JZzbqoCTwNG9FePP+icceacaXXX0k89b+M8C2kURI+is
         Bdq8/9z2cXMCubSfyAYSHBtPZ/kA/Vm33Qs9Hfl7WjgVXuLrdM7Sqo3Yjhx5ZgnJI3v1
         rW5g==
Received: by 10.60.24.7 with SMTP id q7mr10116143oef.108.1353330541215; Mon,
 19 Nov 2012 05:09:01 -0800 (PST)
Received: by 10.182.14.201 with HTTP; Mon, 19 Nov 2012 05:08:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210043>

Changes around this code in history is a bit unclear. User format
learns to get log encoding from a field in 177b29d (pretty.c: teach
format_commit_message() to reencode the output - 2010-11-02), but this
field is only set for --fixup and --squash (in a few commits later).
This makes "git log --pretty=format:%b" always ignore the output
encoding config key. I don't think %b output should be different from
normal log output, which does respect output encoding. Pat, any
reasons not to do it?
-- 
Duy
