From: Marco Nelissen <marcone@xs4all.nl>
Subject: Re: running git as root
Date: Sat, 13 Jun 2009 18:42:44 -0700
Message-ID: <3a3d9e520906131842j6754bda1yaf6ecb2b24320260@mail.gmail.com>
References: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
	 <4A33C8D2.5080808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 03:43:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFekc-0005VB-OQ
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 03:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbZFNBmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 21:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbZFNBmn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 21:42:43 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:10535 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbZFNBmn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 21:42:43 -0400
Received: by an-out-0708.google.com with SMTP id d40so6548308and.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=tdtsIEzWn7U4J/1SGKw0wE02/CEjf9YrUwfBzexJU9M=;
        b=kOpeTBGdRGMz89XAkreovH11LyLqLFy7q/s7vd/1iPXrzhTZ0K42jVCtTwx2rFzI5g
         2UZmOZsQI71qqWfaJOUfyfq+U0/bhWFDwGIHZ7sasne68JL+u7ySjCrl5lOGi0VpbvTO
         sAoSXLCsnhRHp+ufMIt7xctwDt9Wujr7eMmuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Rn51D16cLIQ35s7fqtn08L3fJLtXQvmLFEF0j/LAipyl0+kPAt9KJu1FRleH3qiOBG
         pu7YQH9MbhHBifWx3X9JZETwvKx2yKLGkNZK0+kheVRoyYZf2wj8RtA9HP5V4ihTAT3g
         LRmL4d8Ky+MBTQa680XqRlqOkiJFHFNUxsEFU=
Received: by 10.100.4.8 with SMTP id 8mr6955483and.180.1244943764925; Sat, 13 
	Jun 2009 18:42:44 -0700 (PDT)
In-Reply-To: <4A33C8D2.5080808@drmicha.warpmail.net>
X-Google-Sender-Auth: c788c086ce031142
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121532>

On Sat, Jun 13, 2009 at 8:42 AM, Michael J
Gruber<git@drmicha.warpmail.net> wrote:
> Marco Nelissen venit, vidit, dixit 13.06.2009 17:25:
>> When running as root, git fails a number of test cases that expect it
>> to fail on read-only repositories (for example 't0004-unwritable.sh').
>> I was thinking of either changing the code so that it checks
>> permissions itself when opening files as root, or add a prerequisite
>> to those test cases so that they are skipped when running as root.
>> What would be the preferred way?
>
> The preferred ways is to build git as non-root user. This is true even
> more so for running the test suite.

This is not possible on BeOS, where there is only one user, and it is
the super user.
