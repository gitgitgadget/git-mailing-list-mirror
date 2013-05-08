From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Avoiding broken Gitweb links and deleted objects
Date: Wed, 8 May 2013 12:16:14 -0400
Message-ID: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 08 18:16:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua72V-0007S3-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 18:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337Ab3EHQQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 12:16:17 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:35869 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309Ab3EHQQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 12:16:15 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so1329448pbc.17
        for <git@vger.kernel.org>; Wed, 08 May 2013 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=2NyJzr1DeTHa5NdGfG+JBt1EFjz5qRtWnFIfRd5lGjE=;
        b=bAkYKGr6DH5J8WeuNMzmIe14/kBqVfH3Wl9fdBnjb2Hs4euF4pTEyIEuvXOmqnpqEd
         Q7MEDktsVkbDwGj8/YN1sPB+/SI+EAGTsv83fId9zy6ub7qfQuoYSi8iO82dEIUrNEpC
         dgRKmihlZe1RDySrVNWW9V2ZI3IxnH80v7/xqDnDGwIuHp3lLcVVXQo8CfvPDG+Jyacz
         jQf6u78UMUkHMQY9rRUItRYX4hm228V+hm+HyqXL7/CYidyyLZWr8Fd+FYlg5KeZDLt3
         BrFBmziNdesss7yaQYYku49qU/Ewd5U+D56xbKIXrOOLl5ePKajJn75XVntg0GBoheaR
         b3DQ==
X-Received: by 10.68.234.100 with SMTP id ud4mr8456315pbc.9.1368029774881;
 Wed, 08 May 2013 09:16:14 -0700 (PDT)
Received: by 10.68.43.37 with HTTP; Wed, 8 May 2013 09:16:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223676>

On Wed, May 8, 2013 at 12:05 PM, Matt McClure <matthewlmcclure@gmail.com> wrote:
> On Wed, May 8, 2013 at 10:41 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> git gc moves unreachable objects that were packed before to the loose
>> object store, from where they can be pruned.
>
> Thanks. That was the piece I was missing. I assumed `git gc` did the opposite.

That begs a follow-up question. It sounds as though Git will typically
delete unreachable objects. My team often shares links like
https://git.example.com/foo.git/log/d59051721bb0a3758f7c6ea0452bac122a377645?hp=0055e0959cd13780494fe33832bae9bcf91e4a90
. If I later rebase the branch containing those commits and d590517
becomes unreachable, do I risk that link breaking when Git deletes
d590517?

What's a good strategy for avoiding breaking those links?

-- 
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
