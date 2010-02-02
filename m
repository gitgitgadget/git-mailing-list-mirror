From: Eugene Sajine <euguess@gmail.com>
Subject: [BUG] - "git commit --amend" commits, when exiting the editor with no 
	changes written
Date: Tue, 2 Feb 2010 15:07:17 -0500
Message-ID: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 21:07:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcP1y-0001ey-LC
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 21:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab0BBUHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 15:07:20 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:55009 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab0BBUHS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 15:07:18 -0500
Received: by iwn39 with SMTP id 39so568899iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 12:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=1GKQrpyjnndonedEgf8mCB+ES7bwhLlTeM0aCLlEfNk=;
        b=MDL3dQ7jrYgpWLb5Wc0LPPjUnU3MlPvxJVuu4XoFCl0fsV/FJDiEC4yXzL0MmBSqCd
         EwHFnoqpgH1xdKeyZJo/3+SHtaK/eH62vrUJW8ZQsLX8wN07Aw8oNTucLxAfGlsWdCcM
         sOFF+B6Cay56lYiyw/3l1Vb1p+s0ewuUcgJXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tlzfjBGVOz1LcmOVTdcnRaX6X4UFmd6OsIMQ/geAigtqiM4C68E25V7IdE30ViczaT
         O+8x1i9Mh7P/wjtAoXzQlA0fUjhAkwaRinxR+mIn94U8z3IEmFHzvmSnauZpIN4IuBkr
         7L9qWMGIiLyU3Z6aDLdq9/iLDxcEoq/Yxpjsg=
Received: by 10.231.167.135 with SMTP id q7mr4805406iby.84.1265141237477; Tue, 
	02 Feb 2010 12:07:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138747>

Hi,

It seems to me it is a bug:

When git commit --amend is executed it fires up vi so i can change the
commit message. If I have something staged, then when I'm exiting vi
using :q (without doing/writing any changes), it still commits
everything staged with old message.

I believe it should actually abort amending and return to the state
before the "git commit --amend" was issued.

Thanks,
Eugene
