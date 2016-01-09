From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] object name: introduce '^{/!-<negativepattern>}' notation
Date: Sat, 9 Jan 2016 09:18:11 +0700
Message-ID: <CACsJy8Dar9sCkTg_SQsDUOWYNQ1PHjmA0KcgrvpvmeY=yVXPMg@mail.gmail.com>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
 <1433550295-15098-3-git-send-email-wmpalmer@gmail.com> <xmqqbngqcfxd.fsf@gitster.dls.corp.google.com>
 <loom.20160108T065547-969@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 09 03:18:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHj79-0004BD-EW
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 03:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbcAICSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 21:18:43 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33696 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbcAICSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 21:18:42 -0500
Received: by mail-lf0-f66.google.com with SMTP id z62so1485682lfd.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 18:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dgmqgKRVTHfOTYDrWtWBj+TMRo1Qa0m8ArkMoUSVSrk=;
        b=K0qzZlxw219sFt9jAS806OMXajvkfgy+s0uN24iD+faccBtmviAC0M8N6SKLyyMc8K
         b+WW5JD0G2Uf60gbsjigvXrJvrLZ5DYscyrIxOphV8Hdb2ztfS4u6Ce49blBvjw5fm7C
         Eik5JSXAhppGCMTQW1ZFoBehsYEUCfv0PEPGPrpwYObyb5cR2lTK86cCiwzuqZvM1/cu
         47RzDQ6QWuTHJKwZn70Du0plRKVco5VoTasuJ7eahtWhh2J+pxv7hKb6yN3TbkbL4j4o
         UY282zwHNB80TfGnZwnQm6EsosrORvJCBVw4eDUA9K/kJILYEZ389QqNxY0emIdmVTTd
         7How==
X-Received: by 10.25.144.17 with SMTP id s17mr27701789lfd.94.1452305921157;
 Fri, 08 Jan 2016 18:18:41 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 8 Jan 2016 18:18:11 -0800 (PST)
In-Reply-To: <loom.20160108T065547-969@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283597>

On Fri, Jan 8, 2016 at 1:04 PM, Stephen Smith <ischis2@cox.net> wrote:
>> > +test_expect_success 'ref^{/!-}' '
>> > +   test_must_fail git rev-parse master^{/!-}
>> > +'

Shouldn't it be ^{!/... instead of ^{/!... ? People could have a
pattern starting with "!" and /! will change its meaning. On the other
hand, anything else after { is still reserved and can safely be used.
-- 
Duy
