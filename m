From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: git submodule vs GIT_WORK_TREE
Date: Tue, 26 Jun 2012 14:28:55 +0200
Message-ID: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 14:29:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjUtV-0006nu-QW
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 14:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455Ab2FZM3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 08:29:17 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:41548 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab2FZM3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 08:29:16 -0400
Received: by yhnn12 with SMTP id n12so4382730yhn.10
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=LRKJ1WBAA2ROKJ6HWTWL+U6UeuEofIMkUddXkKxQvok=;
        b=lZcG4ME9gfiLsDFHt96X9yWGBSw6Nz/hJcytMTqow/I/vu+2Fdh1l5XsGERZgzUNFh
         ia7mKKV6AyhNx2MTiIOc3a1IoL06+0qQZgljohM/wWEvOm+pj7IePBSTJlDYnedPufxv
         JM0xme7skf3aRUuhh0UvZNu3y+DD3ElMppZOspQNH1yuQ4YOC38LCqMYGQzA0DFqymn8
         D0mfqyQGDg0bV2iE6tecmoEg4dEBzh0eGr81zi+gSB1aL3Qbcd70G1I66eNeOTyOWDXd
         w3sn8hQ4acZ5vLigijabaTxa+jSqgYyJsqtYmlBXkWJ5giFqB3UToswRu1kpjgFdWt4c
         OJJQ==
Received: by 10.42.62.195 with SMTP id z3mr8054659ich.9.1340713756037; Tue, 26
 Jun 2012 05:29:16 -0700 (PDT)
Received: by 10.50.135.97 with HTTP; Tue, 26 Jun 2012 05:28:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200640>

Hi all,

vcsh [1] has had an open bug[2] filed against it for some time now. I
came to the conclusion that I can not properly work around this within
the scope of vcsh so I am hoping for help on this list.

As you are most likely aware, `git submodule` allows you to access a
separate git repository in a sub-directory, e.g. $submodule, while
$GIT_WORK_TREE forces git to operate in a specific directory. Combine
the two and the result is less than ideal. git is forced to operate in
$GIT_WORK_TREE while it should operate on $GIT_WORK_TREE/$submodule,
instead.

I think there are two options, here:

* Make git append $submodule to $GIT_WORK_TREE, i.e. operate on
$GIT_WORK_TREE/$submodule
* Introduce $GIT_WORK_TREE_RELATIVE which allows submodule and
potentially other commands to append to it


Did I miss another option? Would anyone be willing to fix/implement this?


Thanks,
Richard

[1] https://github.com/RichiH/vcsh
[2] https://github.com/RichiH/vcsh/issues/27
