From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Sat, 14 Mar 2015 17:38:28 +0700
Message-ID: <CACsJy8C1nHCv0XTDYu+R8QFbG9LqjiUU7kTM1RqnzomtcoVCfw@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com> <xmqqlhj0xhsl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dongcan Jiang <dongcan.jiang@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 11:39:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWjTL-0005dT-4x
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 11:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbbCNKjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 06:39:00 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35885 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbCNKjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 06:39:00 -0400
Received: by igbue6 with SMTP id ue6so5825878igb.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MjBhzKarSmtI7+s+WoutG7IlIRnhIY0xsjnHUZ7gZ0k=;
        b=tcmQzizj/dIRy7PmtVuNsXWfELTQmKqE9CjX8PGiMMy9TZFeN7RKRoO4oJ3p0Bcrx0
         iOb2ypjHPAhZi30UOtRj9Z4S34t6q7+ueWlEucqPWK3Ms79VKpPKQiL/N+/gO8NBJIS2
         +fygmfhfuS0nCH1o6qqkQwzEe+IrDXYuhN5TYj1Ggdo+U3tZG81s3Nqq96ZhVUT7t2Zi
         iNMYsnPBLYTcC9Z4eGgU6nad2YjLo55tTmeFkkVf2OOjkxjXNPjqQ9yl+AtWQbjc4YnW
         tgeeVprzanWdBQKnN4X1BIlhxNNd4ZwQfZW39fbpCNiDXkHlC7RKx9t0y0EEsy04Y3LX
         j82w==
X-Received: by 10.107.8.215 with SMTP id h84mr66153803ioi.89.1426329539198;
 Sat, 14 Mar 2015 03:38:59 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sat, 14 Mar 2015 03:38:28 -0700 (PDT)
In-Reply-To: <xmqqlhj0xhsl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265442>

On Sat, Mar 14, 2015 at 12:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dongcan Jiang <dongcan.jiang@gmail.com> writes:
>> What does (you) exactly mean in [1]? The local branch or the local
>> remote ref?
>
> As this operation is not about moving _any_ refs, whether local
> branches or remote-tracking branches, any ref that used to point at
> commit B before you executed "fetch --deepen" would point at the
> same commit after the command finishes.

That would make it harder to implement "fetch --deepen" than the
version that moves refs if they are updated. And I think what Dongcan
implemented moves refs. From the user point of view, I think it's ok
with either version, so the one that's easier to implement wins.

> The "you" does not explicitly depict any ref, because the picture is
> meant to illustrate _everything_ the repository at the receiving end
> of "fetch" has.  It used to have two commits, A and B (and the tree
> and blob objects necessary to complete these two commits).  After
> deepening the history by one commit, it then will have commit A^ and
> its trees and blobs.
>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/212950
-- 
Duy
