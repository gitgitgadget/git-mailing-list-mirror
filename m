From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 22:23:59 -0500
Message-ID: <CAMP44s20njF9u9tRKM6J92-oqeLHoLqd30R-A7opTG7bdrTJzA@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 05:24:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfM8T-0007S0-3N
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 05:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804Ab3EWDYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 23:24:04 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:48416 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740Ab3EWDYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 23:24:01 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so2733262lab.27
        for <git@vger.kernel.org>; Wed, 22 May 2013 20:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KIjNodJ8MOqgb4WYghUwgDH90DDL884wbgq7kQ/kfBA=;
        b=PRGSOdZpptoiY3mCa9XnrycBdvmzA87iVb3d5NauOIM53iMwnROJBa+iiqLBQqU1rT
         7LS0XNv448/JEH44OyQonIoa8xqsWt5vzKQZ502kkIPdXFUxi/UlVdrImkIfydlLUV68
         kzKdQzLCDU3xeIVIhV1qnt8omjIzqwzMJiRhtNBeR1iYqzRe/6NZW6SLjvY9fY6Z6322
         2TrTBK3nq7K2YOMpDkdfejC+KBZo4VlHLiFGA/VI2oN+rrHvwBrfcEdzp7KnkVIUTnpp
         45TRf0jy+YpteNtG5d/kwCUrBTcGWIPl778UDatChUzFyBiRaHJscY/EC5ug8QebUlTp
         GcNg==
X-Received: by 10.152.19.225 with SMTP id i1mr5320753lae.10.1369279440103;
 Wed, 22 May 2013 20:24:00 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 20:23:59 -0700 (PDT)
In-Reply-To: <7vzjvmh98r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225209>

This doesn't make any sense:

---
cd /tmp
rm -rf blame

git init blame
cd blame

cp ~/dev/git/COPYING COPYING
git add COPYING
git commit -m initial

sed -ne 120,140p COPYING >EXTRACTING
git add EXTRACTING
git commit -m second

git log --oneline
git blame -C EXTRACTING

echo >>COPYING
git commit --amend -a --no-edit

git log --oneline
git blame -C EXTRACTING
---

Why would the first instance find the blame in commit #2, and the
second one at commit #1? If anything, the second instance should have
more trouble finding the original commit.

-- 
Felipe Contreras
