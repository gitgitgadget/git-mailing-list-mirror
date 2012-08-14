From: David Aguilar <davvid@gmail.com>
Subject: What should mergetool do with --no-prompt?
Date: Tue, 14 Aug 2012 00:07:26 -0700
Message-ID: <CAJDDKr5TK910n603jcmoq6WoaLL9DX9hgwF3Y+MmjngMpAXPQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Bailey <charles@hashpling.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 09:07:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1BDw-0001My-L5
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 09:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab2HNHH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 03:07:28 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33069 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab2HNHH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 03:07:27 -0400
Received: by vbbff1 with SMTP id ff1so50424vbb.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=+hrLwBIQO7MB/nQaMxa4IK4gnHAU/gzubsUTx+kExao=;
        b=XQZU4KoZZ6U7dTX6sxz72Ss8mkiAPTT8Anottmh9C91D011ooWwqHXUqNRFT8UbPcf
         qbNjNhNqYSrJmnDgQhzUbPtJF3lIhuSDjG1nTepTqHtzIPPu8MYWbRXDAXIowXzggN+q
         xfPieMPK7mMqHbm6wP4bJh017cRp2jX+s0IipsDAfFAQLOE55Yx5PAGBHPm9+P+LgiR5
         V/oJ4TX4keZc+odYEEvlYLeo0P7R62YKYSS3QHPH4qwsIYG05RpbaPNdH3pqfqx/oZo5
         mNLkFnqQcwXRpuJrKA8vp6grcaJOqqHDwUeb1hFht6WytUS0cbgmdDLw3eVV+QOF7ZXb
         llHA==
Received: by 10.52.36.36 with SMTP id n4mr3056011vdj.80.1344928046593; Tue, 14
 Aug 2012 00:07:26 -0700 (PDT)
Received: by 10.58.173.104 with HTTP; Tue, 14 Aug 2012 00:07:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203387>

Right now there are two code paths, resolving deletion conflicts
and resolving symlink conflicts, in git-mergetool that do not
honor --no-prompt.  They force user-interaction with the shell
even though the caller (such as a program) said that they do
not want to be prompted.

This was an oversight from when this option was first added.

I think a simple and sensible thing to do would be for mergetool
to skip over these entries when --no-prompt is supplied.

Does this sound like a good idea?
-- 
David
