From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/3] git-p4: Search for parent commit on branch creation
Date: Tue, 17 Jan 2012 00:10:17 +0000
Message-ID: <CAOpHH-XUj7tF4O_kXfxq2e9Y4VmybNLCqGku_-9H1X+c7v=xwQ@mail.gmail.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
 <1326674360-2771-3-git-send-email-vitor.hda@gmail.com> <20120116185738.GA21996@padd.com>
 <CAOpHH-UkyK-c_AHUOPbQQmW9cQQypDvirMR0Jb7vTGSQF7RZpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 01:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmwdb-0006Li-Qr
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 01:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab2AQAKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 19:10:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41749 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751067Ab2AQAKu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 19:10:50 -0500
Received: by lahc1 with SMTP id c1so1215818lah.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 16:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oGfThIZZOqT7qJHhvopefapjwo6FIuv0EQ6vpFQ4y7Q=;
        b=mqdCwPUzu4rZbwYpwooh0PMEQrV4VUHkx78AQVlZpPUJ+sCnKkGMeHYECiT7l8qcEL
         e0m8okuKxh4sVmDXUy2CUYDRRXlaIoX79E+7FSyYaq4dti3aBuuvkFStK65g7WR3NVge
         dvCjXxcsXvcPRW57gqkJyE09chOl2Hkpx35HU=
Received: by 10.152.147.137 with SMTP id tk9mr360647lab.8.1326759049262; Mon,
 16 Jan 2012 16:10:49 -0800 (PST)
Received: by 10.152.6.197 with HTTP; Mon, 16 Jan 2012 16:10:17 -0800 (PST)
In-Reply-To: <CAOpHH-UkyK-c_AHUOPbQQmW9cQQypDvirMR0Jb7vTGSQF7RZpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188677>

On Mon, Jan 16, 2012 at 11:41 PM, Vitor Antunes <vitor.hda@gmail.com> w=
rote:
> On Mon, Jan 16, 2012 at 6:57 PM, Pete Wyckoff <pw@padd.com> wrote:
>> 1. =A0Move the tempBranch commit outside of the "for blob" loop.
>> =A0 =A0It can have no parent, and the diff-tree will still tell you
>> =A0 =A0if you found the same contents. =A0Instead of a ref for
>> =A0 =A0each blob inspected for each change, you'll just have one ref
>> =A0 =A0per change. =A0Only one checkpoint() after the tempBranch
>> =A0 =A0commit should be needed.
>
> You're right. Completely oversaw that. Will improve the code
> accordingly.

Apparently I did not oversee it. Assume you have added a new file to
HEAD of parent branch, but you branched from a previous commit. When th=
e
new branch is committed over HEAD the new file will, incorrectly, be
part of it and diff-tree will not work as expected.

I should avoid taking 6 months to submit a patch to avoid forgetting wh=
y
I did what I did :)

Vitor
