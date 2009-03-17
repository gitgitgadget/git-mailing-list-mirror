From: Tom Preston-Werner <tom@github.com>
Subject: Local clone checks out wrong branch based on remote HEAD
Date: Tue, 17 Mar 2009 12:19:35 -0700
Message-ID: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 20:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljeqb-000210-OL
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 20:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbZCQTTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 15:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbZCQTTj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 15:19:39 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:2731 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbZCQTTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 15:19:38 -0400
Received: by yx-out-2324.google.com with SMTP id 31so123189yxl.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 12:19:35 -0700 (PDT)
Received: by 10.142.162.9 with SMTP id k9mr131934wfe.164.1237317575278; Tue, 
	17 Mar 2009 12:19:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113519>

I'm having some unexpected behavior when cloning a remote repo that
has several branches at the same commit. On the remote side, the HEAD
is 'trunk':

git@remote ~/repositories/akincisor/site.git $ cat HEAD
ref: refs/heads/trunk

After cloning this with a standard `git clone`, the refs are:

[11:48][tom@solid:~/dev/sandbox/site(release)]$ git branch -r -v
  origin/HEAD    a52528a Fixed some routing problems
  origin/release a52528a Fixed some routing problems
  origin/trunk   a52528a Fixed some routing problems

And the checked out branch is 'release' instead of 'trunk' as I would expect:

[11:48][tom@solid:~/dev/sandbox/site(release)]$ git branch
* release

I'm guessing that the first branch that matches the remote HEAD
revision is being checked out instead of the actual remote branch. I
would expect the correct branch to be chosen regardless of where the
branches are pointing.

Tom

--
Tom Preston-Werner
github.com/mojombo
