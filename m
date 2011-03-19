From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: About Summer of code idea -- better big-file support
Date: Sat, 19 Mar 2011 21:15:40 +0800
Message-ID: <AANLkTi=Z_4cGBSPQW2YVuj=dd8mcO4YQ0G2owknt7vfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 14:15:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0w0a-0000Rg-Mt
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 14:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab1CSNPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 09:15:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55845 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab1CSNPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 09:15:40 -0400
Received: by iyb26 with SMTP id 26so4914830iyb.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 06:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=lEEtz0MzWuAoeJi56SIFpN/VdjRoB5WPGs4QjUbmff8=;
        b=pB0uN64z5KJYNkeJv2vHxG0APZ2hDRPdFcs2fsY6tIoahZyImI09v94u12t3Rxp4hN
         aEwnGMsIvs/LpAj4XeSmlj1mIDBgAxlC9vusq5pn3YUkwPEXiKTUVo3HHxoT/F1YOrqu
         jjDmgmbMxA12yAvJhBeFrYnuQTGz8qNLjMKPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=S7msO/tsurNzt1x/b4C+zJI2ZKd6p4pIy9K3fh9GPwvt4AeVbkQk8cX39ZnsE8u+Iu
         3F87Ld2Wez1lmNy5hENlkkIDibOnAIuNGwL19XtiWN1/tehfHOOnZ2118IDQbW9wWi6N
         os+DwbGk+S/4GT+xhzcllv64y/VKeHqyLvcQo=
Received: by 10.43.60.211 with SMTP id wt19mr3486303icb.139.1300540540047;
 Sat, 19 Mar 2011 06:15:40 -0700 (PDT)
Received: by 10.42.174.201 with HTTP; Sat, 19 Mar 2011 06:15:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169430>

Hi, there

I am wondering start implementing the idea about better big-file support
during summer of code.
Here are my idea: often gigantic files is media file, such as rmvb, swf,
pdf, dll, etc. And those file themselves are already being compressed, as we
all know, git uses zlib to compress all the object in repository, and it is
the common sense that if we use zlib to compress those file, the compress
ratio will be unbelievable low, from my test if we compress 521MiB mkv file
it will be 520MiB after compressed, how ridiculous it is!
Also I test that if we use "git hash-object" to calculate SHA-1, and copy
all content to repository, it will costs 1 minutes, once we use "git
hash-object -w" it will costs 2 minutes. So we sacrificed a lot, but gained
a little.
So, how do you guys think about that we can test the file type, and then
decide to use zlib or not?
Cheer
Di
