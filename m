From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] rebase -i: don't error out if $state_dir already exists
Date: Tue, 23 Apr 2013 22:08:01 +0530
Message-ID: <CALkWK0mDMV7Bh_1BfsOFwX37KRUhNw-96xcsmvk0pRqUinppeQ@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
 <1366725724-1016-3-git-send-email-artagnon@gmail.com> <7vd2tljjcx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:38:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgEy-0005W6-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab3DWQin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:38:43 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53490 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329Ab3DWQil (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:38:41 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so901845ieb.17
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9n6BBSez01IsERJA278nTuA2S4mSyFu5ki7RoBUNJwc=;
        b=pSXdi/EAN2DVPSre74bWvyrJNqBtFt8li09+lf1C/evT39L1AXnehlLvdWWkMIEfGM
         vz0b8aJyZQTid0nGfdzF+BYVt/Mwn1klFlGz2iLZBbOt2fyCBe3QQJOI/qTZkxtXiATd
         r+4imjpvWuYbmXYVoCXaiw54CCPcC6+wso0HLUgsFWgBGQYBwNg8+lyUSljIAIb0i8X5
         VDr+7XwVSVLmvm+Sh24V0EtBK/u/Q0M6V+9Mav/AtT/9Y7Ur0uA052QSlp9yzrqzuS+y
         /fYIPad2Y0cnRK+uLSext0c9ThRKPsW5jvajlmYyJj1rH6DxFyrHgfmkqzL2/Per+MIH
         etkQ==
X-Received: by 10.50.108.235 with SMTP id hn11mr18257047igb.107.1366735121298;
 Tue, 23 Apr 2013 09:38:41 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Tue, 23 Apr 2013 09:38:01 -0700 (PDT)
In-Reply-To: <7vd2tljjcx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222190>

Junio C Hamano wrote:
> So I do not see why this change could be an improvement.  I would
> understand it if some future changes may have already created the
> state dir from a separate codepath (which may be an indication of a
> poor design of integrating that separate codepath, but that is a
> different matter) and mkdir needs to be turned into "mkdir -p" here,
> but I do not think removal of "|| die" is warranted even in such a
> case.

Yeah, it's [7/7] creating a $state_dir/autostash before anything else
can happen.  Okay, if I put the "|| die" back in, does it require any
more justification?
