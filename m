From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [BUG?] git-merge appends extra string to user's message?
Date: Wed, 02 Dec 2009 19:20:30 +0900
Message-ID: <20091202192030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:21:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFmKS-0001tG-Fu
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbZLBKUl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 05:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbZLBKUl
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:20:41 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60312 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275AbZLBKUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 05:20:41 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id E49C911B7F0;
	Wed,  2 Dec 2009 04:20:47 -0600 (CST)
Received: from 2268.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id DX84U9N51MY0; Wed, 02 Dec 2009 04:20:47 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Xs1surqB5UMjTHvV+8maZ1B2tpIUqaI0VoYJuqiKekKjqVU8SbZ15JFwTIc9JZf9GKCyoLUK4WfnP3Cv9tlzwPgDQgPjQR6Mdj6UMQ9ZwopBgXNUeqhmBr6cARYFKnGipA0M6YVq/N3HDPeBaBlit21/uRNMjeNU53QN3Jy8RFU=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134325>

When "git merge" is run with a message, it appends an extra message=20
that it would add if it were run without one. For example, when I=20
tried to merge an early part of a side branch.

% git merge -m "Merge early part of side branch" `git rev-parse side~2`
% git show -s=20
commit 37217141e7519629353738d5e4e677a15096206f
Merge: e68e646 a1d2374
Author: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=81=93=
 <nanako3@lavabit.com>
Date:   Wed Dec 2 14:33:20 2009 +0900

    Merge early part of side branch

    Merge commit 'a1d2374f8f52f4e8a53171601a920b538a6cec23'

I gave my own message because I didn't want git to add the=20
standard message (if I wanted to, I wouldn't have given one,=20
or I would have prepared it using git-fmt-merge-msg command).

Is it possible to tell git-merge not to do this, or will it=20
break compatibility and is a bad idea to change it?

I noticed that this was proposed before:

 http://thread.gmane.org/gmane.comp.version-control.git/77965/focus=3D8=
0059

you were in favor of changing this behavior, and there was=20
no objection from the list.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
