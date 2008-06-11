From: Luke Lu <git@vicaya.com>
Subject: Help rescuing a repository
Date: Tue, 10 Jun 2008 18:19:43 -0700
Message-ID: <C061111B-1696-4545-A3F0-D0B8B961A352@vicaya.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:20:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6F1D-00040E-14
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 03:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYFKBTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 21:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYFKBTw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 21:19:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:1068 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbYFKBTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 21:19:51 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1745088wri.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 18:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer:sender;
        bh=ObfbND8KnwDuB936jWSFQtc5L8FX3xxx8y9/x84l0Hg=;
        b=HdJOdeEzHslCCHamqd8gK4Xhq5ROCGS7HDMjRGLCKDN3Al2Nn8PguzfbuElsdG6K08
         wR+yOfjkfre4AQzOODSz9nbBGLUGKhsSd5n2UsaO6Yha8zGtqkjJ3jN2wDcZ3/Uu3aN7
         UiWSSMQCRR5Hje9xkTytUyZTNuSdpBoXD3l/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer:sender;
        b=mECfmEgWNR8rddFCtQV3Qwo6zPHwS9DofbZtcem9SatExrMlfkrX/q2p4jmZBhuGMA
         VHqnOT3NWWlaJLK9TvvvED4ffEI2YXZVUwFViEpHaUtNJeLug3wCt2Iw64kQBi7WTPmD
         F+833nUuYh8Ne8nhumk8j+SZYWTDVlenUaEHM=
Received: by 10.90.104.20 with SMTP id b20mr6211641agc.32.1213147187541;
        Tue, 10 Jun 2008 18:19:47 -0700 (PDT)
Received: from ?192.168.7.9? ( [71.198.200.243])
        by mx.google.com with ESMTPS id 5sm12457726ywl.4.2008.06.10.18.19.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 18:19:46 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84571>

I was doing some git rebase -i in a topic branch (topic/ser) to squash  
and reorder some commits. There were some conflicts. I fixed the  
conflicts and typed git rebase --continue. The cycle continued a few  
times and then this happened:

  13 files changed, 68 insertions(+), 41 deletions(-)
error: Ref refs/heads/topic/ser is at  
5cfb6b694f2d5a1ff429fe86f6c5ecafed159e47 but expected  
a10a7127be3441c732cab5baa2dd8684591f91f7
fatal: Cannot lock the ref 'refs/heads/topic/ser'.

$ git status
# Not currently on any branch.
nothing to commit (working directory clean)

$ git fsck
dangling blob 8861482c7e1731be2436f75ae6276d0f9c4833e0
dangling blob 94c1b94b5146b58cda4ee50854241b192f701bea
dangling blob 01a2371e749ab7e14707cfb4d3846035fcaee728
dangling blob 4ca2b920849a1517a46279c4b56896fd79625a6c
dangling blob 56e32abf19627dcf79ee123bae9ddb08423bc5ba
dangling blob 73832cd404915d7bc5e0aac1e87fa3bb64293531
dangling tree 73c34a56d1da91d4ea606055d558ef290949fb70
dangling blob b5c3dfefd345e8296e56518b7e537d9e20814288
dangling blob c743999c4762380d3d318ae7b80bba32d4bc4f53
dangling tree 1184c889e044163dd857f3858c09970080720993
dangling blob eca57f10d1dc19dc4bb3dba2c08e393c1e31832b
dangling blob f5a5b7e5e922412ebeabdbc52ecc3354298e3690
dangling blob 47064db7a58b95d02885e5c3004b7920a0dc534f
dangling blob 4966a6f65c912418b33b13fe6f10fb368c2545cf
dangling commit 75c6f9bb9d093390d260819f80cd94fc20849d30
dangling blob bd4752468dbb11274285184cb0c602a2cd259eb5
dangling blob c8074b20ded0a36ff07df5595116442af5515498
dangling tree 0848c028fc28008de1a845c9524e3ab12df9832b
dangling blob 7ec9928b3c0db7ec737fa70b4bb9615b068ee990
dangling blob b44967adc33ec1ddcba49f75cd55127facbb7a00
dangling blob 23ca6b90505dae2607af6415e3ccc038daf0109d
dangling blob b58aac43a313abf6ac21754ec258caeb388a16f6
dangling blob eeebecd8db7d263f77e132b2e82ac4864775b61c
dangling blob 3e0c62d3e778bef1a0f17379ba2a3731da629fce
dangling blob 20cd6eab485de1b0d412cf16e41e88b92ab7e977
dangling blob 8b6d1ba9efb6de596a77aa4be6a36db3d2c6687c
dangling blob b58de59a60c002f99c6ef2463f1678106f07da7d
dangling blob 2fae8d768ac0ae872f513566334d9b4134cf1e28
dangling blob 33ee2202ded44151efb066bc567845b259ce7217
dangling blob afae3fef0b92b14acf7fb1c3e511561111986de5
dangling blob 3f6fd047ac02f1ec7694fd906c762320ed148532
dangling blob 85afb26ca1d651e1745537c60fda5a1807048cb4
dangling blob a30f3e844d6eba2f23ed91470962f12ffebaf0cf
dangling blob bdafe70378182035702a41a7f8854e9f3eaef7dd
dangling blob e96fd7d00b6c05a48477f64ce0085f1fa40207a1
dangling blob 2390ce4ff58008ac1fd3b54dae31116ff4dbbbae
dangling blob 4ab0f1a55f987f1c2e06406199b96ce2e7388bcb
dangling blob 75b0f4cc59aa4a3ae9ac1fa01fbb6383d6584aac
dangling blob 9b7035d40c61259563470a2ea42c2943aec443d0
dangling blob 1752370b44a133f1519ffef5452f772cef99c93f
dangling blob 10b316e7f25212e66e1213dc1303b03339bf6648
dangling blob 883397ee9b21724e03547e7ca71c60e87cd7bbfa
dangling tree 8f135a32c77825713ec70b7367d1134b9dc15006
dangling tree 91f394d3e2566f703434ba3a6b3021496d1167ef
dangling blob 2374b17b997a232835ad817c1173a5bd1e34d30b
dangling blob 8894bb0e8dad66c3cf57350e36252a2f1746a6fb
dangling blob 20b522551d824bfd83685f391d490308dae7c3e1
dangling blob 8cb6086ec13a97a88b9530983f4b4dd77905615f
dangling blob a997eaf05db866b0108e9c754129418237384aed
dangling tree 6118e30cbefd3fe26c51fce8595674a55ff24279
dangling blob 88d9b06bc81abd155604c8ef6b595042bc955d45
dangling blob dfd925e457eb9295587029dca7ce1060f7cc030c
dangling blob c3fbac839f7e35c208110cfab9c0d95eae3f488b
dangling blob 34bce1a591d9bf67bab966a9a9cfeff5e3723d11
dangling blob 9f5c4d0b8bd5e169d1c36658dfd8b1d508641093
dangling blob 1fdda77640dd0d0bf48fe4ee88ab823cb004d8fa
dangling blob 495d6c267d62f82a5a4f0d6c75d111cebcdb3f29
dangling blob c87df955d86c2c13ca45b90ac9a598ba901ba06e
dangling blob 20dee3523801fa85182d2159d4f6ad2fe5c56bad
dangling blob 3f1ea7888bf98019df10c4e5aa6b22cd65daf8d1
dangling blob 8d5ef43998cb64575c4902ac7855d394b5f9d326
dangling blob 121f865528655c03cfbb10d0c29dda678666eb8e
dangling blob badfc40fabb32650ccbb33456766e9d58588f8ed
dangling commit d2bf234e4b0735695a59836f04b4f1558ebacfdc
dangling blob f3df2aebbbd0b00dc8210b6c51806d7f4fd409ef

I've used git rebase -i before without any problem. The only  
difference this time is that there are more commits (50+) and more  
files (hundreds) and changes (thousands) involved due to some global  
find & replace. I *might* have committed something in the same branch,  
while the git rebase -i editor window is open (there are a lot of  
commits to reorder and squash, so I used another window to look at the  
commits I'm not sure about. I might have done a quick fix (likely  
whitespace errors :) and committed)

$ git --version
git version 1.5.5.1

I have the gut feeling that it might be fixable by some magical  
incantation to connect the refs to my branch. But I don't know git  
internal very well. I need your help. My work obviously depend upon it.

Thanks in advance!
