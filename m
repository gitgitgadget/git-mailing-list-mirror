From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sun, 14 Mar 2010 18:58:07 -0300
Message-ID: <55bacdd31003141458y3dfa3734i664b61e69dd50436@mail.gmail.com>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org> <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com> 
	<7v8w9whd3g.fsf@alter.siamese.dyndns.org> <55bacdd31003141346t408c276ak507b7c289cf17679@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 22:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqvpS-00024t-FZ
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 22:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934219Ab0CNV6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 17:58:30 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:60614 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934132Ab0CNV63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 17:58:29 -0400
Received: by gxk27 with SMTP id 27so102971gxk.1
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=IsJCFMWm1/46qIKqDhok4rxwu6GzVbDmSuvkSpcuHuk=;
        b=AgJbK8Xk+bYGrL3sVU62gr/WuVm2D1xdkQye3hMUnGvRXhjtpEDuYS0y8ZLmRmeK6+
         FLr0Kr9iTRLJuCL10YMdlMY4+cQ/+GJIENxp+d1tjR8voTSdphpcHeU9kjnkTEk3mD8B
         EJPv8qo9njc73/7dwGqre/LezFkNrE45xEq6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xDvpkZlnLqS+8mUDl4dbLkYKTjSAAZZERE5DV69hLg3Iinb5oPmbokttdMcbHe/4RJ
         o2NPDNx2ApUzrMU0jcJsenglWjjIVoCQUfQsJTM6IztBa6haQW0FZQnvoL/ydfMUQLMW
         RPpSm3TyVigseyh7/LBiycJypYKsqmMpxbe6Q=
Received: by 10.101.155.38 with SMTP id h38mr2976058ano.131.1268603907338; 
	Sun, 14 Mar 2010 14:58:27 -0700 (PDT)
In-Reply-To: <55bacdd31003141346t408c276ak507b7c289cf17679@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142159>

Resending orphan branch 'cheat sheet' again.  Gmail screwed it in
previous email.  See this using a fixed font:

Branch_A
|
You realize that you need a new empty branch.
|
Is the work tree clean?
|               |
Yes             No
|               |
git clean -ob Branch_B -------Undo?-------Was the work tree clean before?
|                                                 |      |
|                                                 Yes    No
|                                                 |      |
|                                                 |      git add .
|                                                 |      git commit -m temp
|                                                 |      |
|                                                 +------+ git
checkout Branch_A -f
|                                                        |
|                                                        git merge
--squash Branch_B
Do you want to use anything from the work tree?          |
|               |                                        git reset
Yes             No                                       git branch -D Branch_B
|               |
|               git clean -df
|               |
Change the work tree the way you want it to be.
|
git add .
git commit
|
That is it!
