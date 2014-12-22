From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Misbehaving git bisect bad HEAD
Date: Mon, 22 Dec 2014 16:56:29 +0100
Message-ID: <CAP8UFD0aBioiHZLB=YHjN09OfPfem1=V14VnfUJAZ0a70=w5gA@mail.gmail.com>
References: <87y4pzbx2e.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 16:56:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y35LX-0007E4-MV
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 16:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbaLVP4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 10:56:31 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61626 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114AbaLVP4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 10:56:30 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so4504973iec.36
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 07:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nl5o7QiWgzAWBwyAFG22FfowxEtQ7erBCOYlR+QxYHI=;
        b=LOU6OOCy9seiGyOW1dCtkGZ4KDNs+PsLxH4bTutb9oBjUGJBsI1u0N8C9vdDNLdp4a
         mhN7BokBXaC/x6tM77urytMuviiYD9KoQ85V0L/06lvDzAS5qLsXKsGztdSW1IpKLhGE
         +ASaadMlwHxtXhr1y05Pf47QiU3lHIw5grK3ypUu1mxljyGs0eDZ5T+kMrrDZsoKKruH
         9TpZFmvMJq6sUskMSTppgJioPVk1EH/3nuoKQSio+omeACdWxpgJCb7fxivUcdv4T3ck
         DcQ5i0w8qmVUkilxt9MmADttPoHm8AwvENAbV4EOIQ6U/BRzwTPjaGcbxGSWZAC7GdRZ
         Nxuw==
X-Received: by 10.50.176.129 with SMTP id ci1mr15416917igc.40.1419263789746;
 Mon, 22 Dec 2014 07:56:29 -0800 (PST)
Received: by 10.50.3.39 with HTTP; Mon, 22 Dec 2014 07:56:29 -0800 (PST)
In-Reply-To: <87y4pzbx2e.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261646>

On Mon, Dec 22, 2014 at 3:04 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Running "git bisect bad" should be the same as "git bisect bad HEAD",
> shouldn't it?

Yeah, it should.

> When replaying this bisect log on the Linux kernel tree:
>
> git bisect start
> # bad: [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1
> git bisect bad 97bf6af1f928216fd6c5a66e8a57bfa95a659672
> # good: [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18
> git bisect good b2776bf7149bddd1f4161f14f79520f17fc1d71d
> # good: [70e71ca0af244f48a5dcf56dc435243792e3a495] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> git bisect good 70e71ca0af244f48a5dcf56dc435243792e3a495
> # good: [988adfdffdd43cfd841df734664727993076d7cb] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
> git bisect good 988adfdffdd43cfd841df734664727993076d7cb
> # good: [b024793188002b9eed452b5f6a04d45003ed5772] staging: rtl8723au: phy_SsPwrSwitch92CU() was never called with bRegSSPwrLvl != 1
> git bisect good b024793188002b9eed452b5f6a04d45003ed5772
> # good: [66dcff86ba40eebb5133cccf450878f2bba102ef] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect good 66dcff86ba40eebb5133cccf450878f2bba102ef
> # bad: [88a57667f2990f00b019d46c8426441c9e516d51] Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 88a57667f2990f00b019d46c8426441c9e516d51
> # good: [0ec28c37c21a2b4393692e832e11a7573ac545e2] Merge tag 'media/v3.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> git bisect good 0ec28c37c21a2b4393692e832e11a7573ac545e2
> # good: [c0f486fde3f353232c1cc2fd4d62783ac782a467] Merge tag 'pm+acpi-3.19-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good c0f486fde3f353232c1cc2fd4d62783ac782a467
> # bad: [34b85e3574424beb30e4cd163e6da2e2282d2683] Merge tag 'powerpc-3.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux
> git bisect bad 34b85e3574424beb30e4cd163e6da2e2282d2683
> # good: [64ec45bff6b3dade2643ed4c0f688a15ecf46ea2] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> git bisect good 64ec45bff6b3dade2643ed4c0f688a15ecf46ea2
>
> Running "git bisect bad" gives this:
>
> $ git bisect bad
> Bisecting: 6 revisions left to test after this (roughly 3 steps)
> [ec2aef5a8d3c14272f7a2d29b34f1f8e71f2be5b] power/perf/hv-24x7: Use kmem_cache_free() instead of kfree
>
> Running "git bisect bad HEAD" instead gives this:
>
> $ git bisect bad HEAD
> Bisecting: a merge base must be tested
> [56548fc0e86cb9156af7a7e1f15ba78f251dafaf] powerpc/powernv: Return to cpu offline loop when finished in KVM guest
>
> This is git 2.2.1.

I think it is a very old bug.

The following patch should fix it:

diff --git a/git-bisect.sh b/git-bisect.sh
index 6cda2b5..26a336a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -200,7 +200,8 @@ is_expected_rev() {

 check_expected_revs() {
        for _rev in "$@"; do
-               if ! is_expected_rev "$_rev"
+               _parsed=$(git rev-parse --verify "$_rev")
+               if ! is_expected_rev "$_parsed"
                then
                        rm -f "$GIT_DIR/BISECT_ANCESTORS_OK"
                        rm -f "$GIT_DIR/BISECT_EXPECTED_REV"

I will send a proper patch later.

Thanks,
Christian.
