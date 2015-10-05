From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.6.1, v2.5.4, v2.4.10 and v2.3.10
Date: Mon, 05 Oct 2015 13:43:54 -0700
Message-ID: <xmqqmvvxxcz9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 05 22:44:10 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ZjCcC-0002zl-Rh
	for glk-linux-kernel-3@plane.gmane.org; Mon, 05 Oct 2015 22:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbbJEUn6 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 5 Oct 2015 16:43:58 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36470 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbbJEUn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Oct 2015 16:43:56 -0400
Received: by pablk4 with SMTP id lk4so185779435pab.3;
        Mon, 05 Oct 2015 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=Tl/xUf6PQ76boT5XF3n+8JauHI1hYRJBhc6tCYW4Zlc=;
        b=CDRZhUgE/mwkqjgFgN2lsySAVfinySuG/ohuKMH1j1HcpF9ecQ/WNvXgC3QYoTXOp8
         yJ8GJXQBaTcuLTvaWNzQmxtJeS96Qtsb+Mr5KO+vh202kq67edc8LHxeavlCdRWjAH7u
         to4nJF47K1nPKY7nSc9jHV9BQ28NG5o++G9q7YAq5aNuVm047qK40zuAr+SsEaheBpLS
         SAOou11lBWdVh25WPOI+E8s9j6+UqCzej94RlngeLYrLcc9rimikwIRgnprl72vpM5WQ
         PsJOPbH7xkp4PEEbHa3CkQdQmoK/k3Ftv3Gr8liuD+G8FjP2XgA7cNKBrZ7X03fvOEFh
         NX8w==
X-Received: by 10.66.124.229 with SMTP id ml5mr41889701pab.77.1444077836138;
        Mon, 05 Oct 2015 13:43:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id sl7sm29248456pbc.54.2015.10.05.13.43.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 13:43:55 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279091>

The latest maintenance release Git v2.6.1, together with releases
for older maintenance tracks, are now available at the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the
abovementioned tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Fixes contained in these releases are as follows:

 * xdiff code we use to generate diffs is not prepared to handle
   extremely large files.  It uses "int" in many places, which can
   overflow if we have a very large number of lines or even bytes in
   our input files, for example.  Cap the input size to somewhere
   around 1GB for now.

 * Some protocols (like git-remote-ext) can execute arbitrary code
   found in the URL.  The URLs that submodules use may come from
   arbitrary sources (e.g., .gitmodules files in a remote
   repository), and can hurt those who blindly enable recursive
   fetch.  Restrict the allowed protocols to well known and safe
   ones.

Kudos to Blake Burkhart and Jeff King for working on these fixes.

Thanks.
