From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Rebase regression in v1.7.9?
Date: Wed, 1 Feb 2012 00:56:29 +0200
Message-ID: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 23:56:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsMcu-00009s-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 23:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab2AaW4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 17:56:32 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:54487 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753326Ab2AaW4b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 17:56:31 -0500
Received: by lbom4 with SMTP id m4so79541lbo.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=92DGtHmmn12iZJmruBjZIS2nFYwp/Ih5F2EqC6gq4A8=;
        b=ruwvxjbGgwYIIaCPTW3g/wm2/KAH/AypmNIbSAJeaaBofw1zgZ2V30qqsMDOw2ib/y
         ultJLuziiZCsKcD0yemRw1gHt0GGpTHyrifrJXn5Boj4PHgHZyCuOJTqPa2YZqhuslVo
         8m5d8MCT1oekvg0I9nDuJP3lTRHNHxG04FNH4=
Received: by 10.112.48.65 with SMTP id j1mr6029577lbn.76.1328050589765; Tue,
 31 Jan 2012 14:56:29 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Tue, 31 Jan 2012 14:56:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189481>

Hi,

Try the following steps:

% git checkout -b tmp v1.7.9
% git cherry-pick 6e1c9bb^2^
% git rebase -i --onto 6e1c9bb HEAD^
% git rebase --continue

The rebase will finish, but there will be a .git/CHERRY_PICK_HEAD file.

This doesn't happen if you run rebase without -i, or do rebase --skip instead.

IIRC correctly rebase --continue used to work fine.

Cheers.

-- 
Felipe Contreras
