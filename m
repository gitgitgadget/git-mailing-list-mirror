From: Jason Karns <karns.17@gmail.com>
Subject: bug in bash completion for git-branch --set-upstream-to on OSX
Date: Fri, 20 Mar 2015 11:15:09 -0400
Message-ID: <CAKNmmv3wu-5s9UB_RFO5Wptdo+a71Lmzn2Zs4kb=MwnFoTctCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 16:15:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYydp-0003zX-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 16:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbbCTPPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 11:15:13 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:32938 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbbCTPPK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 11:15:10 -0400
Received: by wixw10 with SMTP id w10so28318964wix.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=AEOvDGxufqzmE/FiRiTHPOkNIJXlN3vQLbMzk/+kGaE=;
        b=rr9uCdJ7lrUPnt8JcLKQ/mGghJSI2mfyYrkXQtSIvcH9EKoUOLSBNyhKKgQ2znAhTc
         0i93q/luQthM2kw0ZGLqSNRWFM7fOjURvm5e7Wdjzhtx7/wK97LHiGLP4zlWkGjlZG8Z
         Rp1r8iYbTRRxiXuCLIImCtVLmicre8y2pS6+JPiWTJ18u6OqUOCIoTf/nFzWLLFTalnX
         ZWaZL1MmOk+ZHmp1qzkLCZB3+QdJHJejLParNkUYwE0uV2NCwOR5rh5MbYyE/k8sqOFB
         MT2tcDyzk8GICuMWskdMtRY8iZ6mipSN/Y9Ekeq+ZaNJBYFEajxxGrJKkJvvQPI9MLjo
         CYhw==
X-Received: by 10.180.100.170 with SMTP id ez10mr6103726wib.81.1426864509669;
 Fri, 20 Mar 2015 08:15:09 -0700 (PDT)
Received: by 10.27.48.131 with HTTP; Fri, 20 Mar 2015 08:15:09 -0700 (PDT)
X-Google-Sender-Auth: jMpRpNHzR7hB6veBQ7DkOmMTOs8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265909>

There appears to be a bug in the bash completion for git-branch when
attempting to complete the remote ref argument for --set-upstream-to=

When:

$ git branch --set-upstream-to=origin/mast<TAB>

I would expect it to complete to:

$ git branch --set-upstream-to=origin/master

However, the completion for --set-upstream-to= completes the ref
correctly, but completely wipes the --set-upstream option; resulting
in:

$ git branch origin/master


I'm running on OS X 10.9.5 with git from homebrew:
$ bash --version
GNU bash, version 4.3.33(1)-release (x86_64-apple-darwin13.4.0)
$ git --version
git version 2.3.3

The same behavior does *not* manifest (it works as expected) on CentOS
6.5, bash 4.1.2.1 (GNU bash, version 4.1.2(1)-release
(x86_64-redhat-linux-gnu)). I'm running git 2.0.3 on CentOs but
sourcing the shell completion script from latest source: 9ab698f

I also cloned down latest git source on OS X and the bug still
manifests when sourcing the completion script at 9ab698f.

~ Jason
