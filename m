From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Fix expected values of setup tests on Windows
Date: Fri, 31 Dec 2010 20:00:32 +0700
Message-ID: <AANLkTi=uCCfBFBpC=+V9RpaXRXiiPYp-tZXBxAVNB7+e@mail.gmail.com>
References: <201012302205.13728.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 31 14:01:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYebY-0002qQ-DB
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 14:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab0LaNBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 08:01:06 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48870 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab0LaNBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 08:01:04 -0500
Received: by wyb28 with SMTP id 28so11735579wyb.19
        for <git@vger.kernel.org>; Fri, 31 Dec 2010 05:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=v2oW+fApBYgxhbXC2mThtHD9xFWrCpjWjP5Oyuh7nAk=;
        b=Tss1Xyj3jDf9crorXdJQRQIQX6+ztQW3IbbGy6rXXv6X0pFKnHQHphCTh9Ei+kKW0M
         3E79Rq4Q7n/RKrtwiA4rt/ypQVtv+jZGh+DG6HeHhwAaBlauHgqFKaJhy5JRomhDLHuB
         GBamMN18beyuAzn+ciUECZmGYdY9GI5QlneUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lv+7S/nFQX6jHHBjjxcTxyggYZQ4hw2gFEeu38hIEukFMEJTwj87rbivwy5cynvF46
         V5Bigj1Zjn/pgS/Chx5yB6ydS0YJjYs2CJVKhOJOhpqjwWdmZWdtWLyplPTklKO48HWV
         1mv338wdLgpXNTS3+jXj0cZbkuYGSbcUw9laU=
Received: by 10.216.52.206 with SMTP id e56mr18334313wec.19.1293800462935;
 Fri, 31 Dec 2010 05:01:02 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Fri, 31 Dec 2010 05:00:32 -0800 (PST)
In-Reply-To: <201012302205.13728.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164381>

2010/12/31 Johannes Sixt <j6t@kdbg.org>:
> On Windows, bash stores absolute path names in shell variables in POSIX
> format that begins with a slash, rather than in drive-letter format; such
> a value is converted to the latter format when it is passed to a non-MSYS
> program such as git.

Hmm.. from test-lib.sh:

TEST_DIRECTORY=$(pwd)
test="trash directory.$(basename "$0" .sh)"
TRASH_DIRECTORY="$TEST_DIRECTORY/$test"

I'm just curious how these lines make $TRASH_DIRECTORY in POSIX format, while

here=$(pwd)

in your patch does not. Does bash auto convert value in
TRASH_DIRECTORY="$TE..." line?
-- 
Duy
