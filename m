From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: git-p4: t9819 failing
Date: Wed, 23 Sep 2015 14:28:40 +0200
Message-ID: <F37BA8D8-6845-4C47-BBE2-3313685FD16F@gmail.com>
References: <CAE5ih79t+62XUKsj9cnkJCCv4WPhUgQZQ6hF39Nx0ky+WFi-sw@mail.gmail.com> <954B65C2-1CF8-4F63-B2DE-F15200553046@gmail.com> <CAE5ih78x+jnW3+4d5q5dJidt4LXWV=hMgJTEfsC2dUBLout1Aw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 14:28:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZejAI-0002pg-ET
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 14:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbbIWM2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 08:28:46 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35364 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbbIWM2p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 08:28:45 -0400
Received: by wicge5 with SMTP id ge5so205143605wic.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VV5qotCz95si/mgvzEFKUke8SRtuEL78O2wsi7hrXYw=;
        b=XOfHl+NtLNY16OgFql0HUumrNtenZojaxw7leD69YAxoWvZPIcCeSwHIRe9A0DoifH
         O3xEfIx6N3Us8reMVPVuWiiKByLuGPJHXl8Pn+3K1cvZPpAqG1meWAj/oohs+bJNVmCQ
         Q84UihUqGYBVWXHmojYMrOolfM3t/ZQBgD0vHwLWK/lNg82y6eVNBIszCvVVat6Fkdpb
         gHPOtkwuw3FncwCtop1mwD620rIppLdQ7O77z35hoWTOwXoLowODaKUaPu7F4mGdQ4UQ
         /5sonim28cW7yyIjFiEq+pxLjJfqdCc+yhGTpJvkLM5tz2bhB/AOOTUKlu1BpyLWnzpF
         qkSw==
X-Received: by 10.194.7.106 with SMTP id i10mr35752169wja.86.1443011324724;
        Wed, 23 Sep 2015 05:28:44 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id x9sm4591078wjf.44.2015.09.23.05.28.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 05:28:42 -0700 (PDT)
In-Reply-To: <CAE5ih78x+jnW3+4d5q5dJidt4LXWV=hMgJTEfsC2dUBLout1Aw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278485>


On 23 Sep 2015, at 13:11, Luke Diamand <luke@diamand.org> wrote:

> On 23 September 2015 at 11:27, Lars Schneider <larsxschneider@gmail.com> wrote:
>> 
>> On 23 Sep 2015, at 11:27, Luke Diamand <luke@diamand.org> wrote:
>> 
>>> Lars,
>>> 
>>> I just noticed that your change "git-p4: honor core.ignorecase when
>>> using P4 client specs" seems to break t9819.
>>> 
>>> I suspect that the problem is just that t9819 needs to be updated to
>>> reflect your change - do you have any thoughts on that?
>>> 
>>> Thanks!
>>> Luke
>> 
>> What OS and what commit do you use for testing? Here is what I got on my machine:
>> 
>> Ubuntu, next (c07a1e8) -> OK
>> Ubuntu, maint (ee6ad5f) -> OK
>> 
>> OS X, next (c07a1e8) -> broken
>> OS X, maint (ee6ad5f) -> broken
> 
> The next branch is good:
> c07a1e8 Merge branch 'bb/remote-get-url' into next
> 
> The pu branch isn't:
> f44e3df Merge branch 'jk/notes-dwim-doc' into pu
> 
> This is on Debian.
> 
> Actually I think the problem may be in calcDiskFree().
> 
> Here's the last bit of the crash dump from git-p4 I get:
> 
>  File "/home/ldiamand/git/git/git-p4", line 2580, in streamP4FilesCbSelf
>    self.streamP4FilesCb(entry)
>  File "/home/ldiamand/git/git/git-p4", line 2497, in streamP4FilesCb
>    required_bytes = int((4 * int(self.stream_file["fileSize"])) -
> calcDiskFree(self.cloneDestination))
>  File "/home/ldiamand/git/git/git-p4", line 116, in calcDiskFree
>    st = os.statvfs(dirname)
> OSError: [Errno 2] No such file or directory: 'lc'
> 
> Luke
Confirmed. What do you think about this fix?

Thank you,
Lars

---
 git-p4.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-p4.py b/git-p4.py
index 1d1bb87..66c0a4e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3478,6 +3478,7 @@ class P4Clone(P4Sync):
 
         print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination)
 
+        self.cloneDestination = os.path.abspath(self.cloneDestination)
         if not os.path.exists(self.cloneDestination):
             os.makedirs(self.cloneDestination)
         chdir(self.cloneDestination)
-- 