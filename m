From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [regression?] "git status -a" reports modified for empty submodule directory
Date: Tue, 29 Apr 2008 23:31:59 +0800
Message-ID: <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 17:33:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqrpD-0000pw-41
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 17:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759664AbYD2PcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 11:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761128AbYD2PcF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 11:32:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:19959 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758727AbYD2PcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 11:32:03 -0400
Received: by wx-out-0506.google.com with SMTP id h31so54888wxd.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=22+TuhbsppoltJzCvy1egPtWsUZD2GOJSzts2Ctj/xg=;
        b=BgIM76wCQo+1q5goioglG7FQFpuVhY5NEpJoBP8dKPR9l7LiH4k/OjHBbJEubg3xrtOp/q93F/3MqNF9o6ul312bcgodiHvzjon4J/+jLFNKHiJzV8Osb2V+sfMcO57DuynNCdBiWnkBMcZhMqKwFc+2Ep+R5E7su31Vlki811M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=se5bMuRVOoWlvFd4YofTpkPVK95mWQfItBVbz8klYAC63RNIHnWFCPYgDSueCHz+apLoIdw2pbhkdnkUkUgtpbJIQrs9hcIOeIqIMMolK/gHZTsUE0Ds6QVRfDqzJFJfTUp5XOwjxdHzCQ1SVi7G416WiHH/EaUc4CV+TnKukcQ=
Received: by 10.100.133.1 with SMTP id g1mr1736246and.88.1209483119877;
        Tue, 29 Apr 2008 08:31:59 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 29 Apr 2008 08:31:59 -0700 (PDT)
In-Reply-To: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80690>

On Tue, Apr 22, 2008 at 7:01 PM, Ping Yin <pkufranky@gmail.com> wrote:
> # create a super project super
>  $ mkdir super && cd super && git init
>  $ touch foo && git add foo && git commit -m "add foo"
>
>  # create a sub project sub
>  $ mkdir sub && cd sub && git init
>  $ touch bar && git add bar && git commit -m "add bar"
>
>  # add sub project to super project
>  $ cd ..
>  $ git add sub && git commit -m 'add sub'
>
>  # remote contents of subproject
>  $ rm -rf sub/* sub/.git
>
>  # git status -a regression
>  $ git status
>  # On branch master
>  nothing to commit (working directory clean)
>  $ git status -a
>  # On branch master
>  # Changes to be committed:
>  #   (use "git reset HEAD <file>..." to unstage)
>  #
>  #       deleted:    sub
>  #
>

Another regression following

In the super project super with empty submodule directory sub
$ git diff
diff --git a/sub b/sub
deleted file mode 160000
index f2c0d45..0000000
--- a/sub
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit f2c0d4509a3178c...


-- 
Ping Yin
