From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Fri, 27 Feb 2015 16:33:00 -0800
Message-ID: <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
 <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
 <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
 <CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
 <CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
 <xmqqsidtoojh.fsf@gitster.dls.corp.google.com> <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com> <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 01:33:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVLR-0004Ku-Ub
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 01:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbbB1AdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 19:33:21 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33747 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbB1AdV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 19:33:21 -0500
Received: by mail-oi0-f43.google.com with SMTP id z81so18552371oif.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 16:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/wlGtVDE34qYd7aNGnR6WR7l1ruIxZkZNpgbudPWnmA=;
        b=rJIMNB4hLQXiUCHyP9FhD7CBUoAm1a2QD1SEAwMOGlLypmsIHocXlXqEjamRvbRwMl
         b1wllOUjxsvxOBgTversaniHVOb4U+2FL4rwKgI/zhWccp24/l56fFq6UHpdd6HfA5Pa
         uRyMZKEnEZ8ioX548Ht3Hkpkds6vrV+LDtUpLYJz1SkR3RWBR/hu1W+6lrhvXiIx28tf
         Ou1q03/gwa3qqOz3DOnPCInEbZcCS5scR5XKgImZ8Dd+BwLG81QylWv2v/wNy7jBar4N
         yUmLug6qGFX5dbMTFMRbZHe/sqq3jxRzYLZjLpD3YrNog+lomS4j0JFWYKgjq9Yo9L4E
         ej8Q==
X-Received: by 10.202.219.215 with SMTP id s206mr11142871oig.114.1425083600667;
 Fri, 27 Feb 2015 16:33:20 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 27 Feb 2015 16:33:00 -0800 (PST)
In-Reply-To: <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
X-Google-Sender-Auth: 3O8vS5bXY_yUNMw8DVmVpt8W3Rw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264516>

On Fri, Feb 27, 2015 at 3:44 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Feb 27, 2015 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I am _not_ proposing that we should go this route, at least not yet.
>> I am merely pointing out that an in-place sidegrade from v1 to a
>> protocol that avoids the megabyte-advertisement-at-the-beginning
>> seems to be possible, as a food for thought.
>
> This is a fun thing indeed, though I'd personally feel uneasy with
> such a probe as
> a serious proposal. (Remember somebody 10 years from now wants to enjoy
> reading the source code).

That cannot be a serious objection, once you realize that NUL + capability
was exactly the same kind of "yes, we have a hole to allow up customize
the protocol". The code to do so may not be pretty, but the code to implement
ended up being reasonably clean with parse_feature_request() and friends.
After all we live in a real world ;-)
