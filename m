From: Alexandru Guduleasa <alexandru.guduleasa@gmail.com>
Subject: Re: [PATCH v2] Rewrite strbuf.c:strbuf_cmp() replace memcmp() with starts_with()
Date: Sat, 22 Mar 2014 23:58:02 +0200
Message-ID: <CA+ph3SoiNtX+ghTZsWetgAJ23SYYsAzyq+RSwHhtaxQhq-Pk7g@mail.gmail.com>
References: <1395523516-10181-1-git-send-email-mustafaorkunacar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 22:58:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRTvd-0001WW-Uq
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 22:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbaCVV6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 17:58:05 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:39240 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaCVV6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 17:58:04 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so1431600wib.8
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RbhlArLPRqbKTDE3EiJUZ6rKGjkRkNmpTEzwa5qJ+5c=;
        b=u5kkZRroTMMyFC2vKx10jzu6z4kYEgwF1KFe8JUAJgp6xq2Eu6gTFnhtMolrOQcUIJ
         hSwm75qpQnWcekNzdW4yauYybpsyFiXW1Aq9upsc30+o4eiKLSlw1V2s+qgCZ9izieAy
         lurs8C3pb7QzN6a+m/cq2qNl9wnYJ1U6COYnnU1HzUTnkrfpb+n+hCfPz9MQLyFCyUHi
         qH6LtVr+O/3P0+D7/61mNo80OEiv3h2RWVJbs21U1xAzKqX97K3aD5D9D+eBz07E/GQn
         ymfuwCycV1YJuUoj6JOffSojL45+A9BpvFQuSxn9Ir/sSlwfEhBUVgLEDuXMj9m5QVQw
         1dBQ==
X-Received: by 10.180.164.106 with SMTP id yp10mr5903528wib.48.1395525482329;
 Sat, 22 Mar 2014 14:58:02 -0700 (PDT)
Received: by 10.227.175.200 with HTTP; Sat, 22 Mar 2014 14:58:02 -0700 (PDT)
In-Reply-To: <1395523516-10181-1-git-send-email-mustafaorkunacar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244784>

Hi,

This does not seam correct to me.
The memcmp function could have returned 3 relevant values (zero,
positive and negative) and a non-zero result would have been returned
by the if statement.
With you modification, you replace a negative value from memcmp with a
positive one.

Best regards,
Alex Guduleasa
