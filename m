From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: git submodules.
Date: Mon, 28 Apr 2008 16:50:20 -0300
Message-ID: <1209412220.29267.22.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 21:52:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZOe-0001hy-DF
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999AbYD1Tvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932884AbYD1Tvc
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:51:32 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:44449 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120AbYD1Tvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:51:31 -0400
Received: from spunkymail-a12.g.dreamhost.com (sd-green-bigip-202.dreamhost.com [208.97.132.202])
	by hapkido.dreamhost.com (Postfix) with ESMTP id AD0D5179C83
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 12:51:29 -0700 (PDT)
Received: from [127.0.0.1] (unknown [139.82.86.2])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 327B37F9E
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 12:50:29 -0700 (PDT)
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80599>

Is there any documentation about how those work?

What I need is this, I have a already existing git repository, that have
a subdir that could be seen as submodule (by this I mean that he is
related, but could have a different commit tree). The git repository
already exists and has many commits that apply to either the submodule
or the main module (I would say that there is no commit that touch
both). So is it possible to separate them easily? Would it keep my older
commits? 

bellow is a shell script that samples my setup: 

=========================== cut here =================================
#!/bin/bash

gitdir=git_submodules_dir

if [[ -d $gitdir ]]; then 
	rm -rf $gitdir;
fi

mkdir $gitdir

cd $gitdir

git init

echo "testing 1 2 3" > file_a.txt
git add file_a.txt
git commit -m "initial setup"

mkdir submodule

echo "submodule file" > submodule/file_b.txt
git add submodule/file_b.txt
git commit -m "submodule file"

echo "updated main file" >> file_a.txt
git commit -a -m "updated file in main module"

echo "updated sumodule file" >> submodule/file_b.txt
git commit -a -m "updated file in the submodule"
=========================== cut here =================================
