From: Stefan Beller <sbeller@google.com>
Subject: Redirect "git" subcommand to itself?
Date: Wed, 27 May 2015 17:28:34 -0700
Message-ID: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 28 02:28:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxlge-0000v2-Ro
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 02:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbbE1A2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 20:28:36 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33571 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbE1A2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 20:28:35 -0400
Received: by qcmi9 with SMTP id i9so11328030qcm.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Uoyk8O6UuX3fmJcfMUheP4pV4s1WqW5BYTvnmEk3a6E=;
        b=l+lMDwmk3YOlBAhramFaxQQ9Z3bLJKC6i7x5xibSsUBf5P+shbRNiXuSBmZbG/pLpQ
         O50mFI9J325z+whbDs3Q4iePAyH+HrRTaQag95wYC2XX2gJgTFSGvdTbTmFmZy2c85Q+
         NT0N49Hd6tbbNKq2MTGbtHn8Pm0vd9qdwDoaWIM9EeWWl+26YeiZT3ldBQgnGyYc6uKd
         yqVghfFmdC2L2s3pUVbXxeICFcqduIfbdFyfLJ3e6EhmP5oWCEAobvSSrH+U8/uqJSmp
         fYEcsrtT5vhwvOuKVsn4WWMiP06WnqXKpRSZoN71WJBsr4Ou81SJ0EAtrRWH0xEemBOT
         MYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Uoyk8O6UuX3fmJcfMUheP4pV4s1WqW5BYTvnmEk3a6E=;
        b=NM4+SVfNNZCVp9VVj+Cx1anx357lPFxixpmtdHNEb9DMkTgh+gxm4Zvb8EAZvur4wU
         Clt+WYjxInjA2QKJ2AJDQRmHvGsO7g+LxYVVB9A9wTtNk5EfeicqmGJW/S9NGKuFHIau
         lb69Vg9qPlrQrH3ga6zG9AprYL7u0Tmsk4yjZKrXxTWYIhc3sf02AqdH3TbE/kVjYGyZ
         nOjkS5RaDYJ7yU/TEB3/9qqANx0ztIRk3l8Mjbs/h8W8SYAflUePI0nSlXnvpeCwK8cK
         XcjNyIIAPfhkmIL2/3HhiL/0E9SdkBsHkk8xvxbAaYzZDdTUaCw/E6QmNTK99DvEScNV
         zvkw==
X-Gm-Message-State: ALoCoQlRdAhM0eyKAMrdtfXAsZCFa6FEArAY227yN6EJsvl7bvzJTLPO0AOOBboWt8ZuUYbkGHvz
X-Received: by 10.55.22.143 with SMTP id 15mr46283qkw.85.1432772915021; Wed,
 27 May 2015 17:28:35 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 17:28:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270121>

Hi,

so I just run into this problem again (which happens to me maybe twice a week):
I want to do a git operations, so I type "git " into my shell, and
then I look around what
exactly I want to do and usually I find it in the help text of a
previous command such as
    You are currently reverting commit 383c14b.
      (fix conflicts and run "git revert --continue")
      (use "git revert --abort" to cancel the revert operation)

then I copy the whole operation "git revert --abort" in this case and
paste it to the shell
and let go.
The result looks like
    $ git git revert --abort
    git: 'git' is not a git command. See 'git --help'.

    Did you mean this?
    init

I wonder if we want to make a "git" subcommand, which behaves exactly
the same as git itself?
Then "git git git status" would just return the same as "git status".

Thanks,
Stefan
