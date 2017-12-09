Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81D71F404
	for <e@80x24.org>; Sat,  9 Dec 2017 02:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbdLICSl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 21:18:41 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46285 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbdLICSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 21:18:40 -0500
Received: by mail-lf0-f68.google.com with SMTP id r143so13654752lfe.13
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 18:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BE24nlfQAunqV0d44L3O/6w9EHzKLlAxw3ObmM0/AVY=;
        b=prloTcsKJYloLf5XR2YSgUgXsk4HznKUp0Zf8QOqmkss/S8BsBYHyvMdqV9vp/DZSt
         gogvFy5S8F1/jCpU8XQE1+Qgnl6w3jxOT2z5eVEV1Eylp+1LNVbQekh6xCDRCb4CP6dH
         ogM8074dgxMRHEcYK2fz/5rwMLaYNnPsdk6RRjE7A49xM4XNU836MYMJ5hYvqpokuZrN
         iQjJWAXrxsXQkEwnIcg4W27vd/9tLtGJde2rDbJE3ilQjMRx8ngHORTH0aA0coLQ4T1n
         n7y7cIUkuIRMDdd7uP1scKyzhEGEO3FCikRrwaUeyVuBBU9QHcLklEOMPcx+67eHkpyx
         EVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BE24nlfQAunqV0d44L3O/6w9EHzKLlAxw3ObmM0/AVY=;
        b=Rt2msIGWvBYqSBebWS82vXkfmFUVvM5EujTctfwPq+R32L8S/Ub/u4RndVGCw7ELj7
         V+6+VHA5DRr1swBf+vr+xpo5UYHFs4qMe/HGY2RpAfjizj7vq7jSLZDP07cTLg4DU/5G
         PREuZ+GK92t8DOi3znuQuSsIXJ0BmPUW4GsRkcJ3FEcO5BssVE+VMJeQAEdEbl/nZKx4
         ZeLHKuPfksHEnIr3q4SbsZ/vRnEWzZoxiGdcnSTAYObi6PjsIGOX2Otb2OrF3aIOQ8dw
         IqECPX1lemE65Z2rCr/xygSTj/LAZV20dEddUvbGZFZADiGc9QxNlzB55sbeltqMqN0f
         Spdg==
X-Gm-Message-State: AJaThX5W14zJp6H36rjeRN/EzbRqKqg2065opZ0xDja3+K0wgfIDaimQ
        hWL9FE/iCy5l5WuyICdu5xg=
X-Google-Smtp-Source: AGs4zMaf7vs+SWssQiAwcIwMpNPo9aNrcLN/4WNW1KG9iinqWy7gJ1eof50IoWKnM1f2c39COFcQSg==
X-Received: by 10.25.41.143 with SMTP id p137mr16582912lfp.56.1512785918458;
        Fri, 08 Dec 2017 18:18:38 -0800 (PST)
Received: from [192.168.0.102] ([31.42.117.162])
        by smtp.gmail.com with ESMTPSA id g15sm1651043lfj.21.2017.12.08.18.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 18:18:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
In-Reply-To: <a3510c14-23e9-d1d9-0847-b60451f8e15d@gmail.com>
Date:   Sat, 9 Dec 2017 04:18:35 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D842B04A-9331-4F26-8F19-B61F6F13FC79@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
 <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
 <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
 <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
 <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com>
 <xmqqo9n99ohc.fsf@gitster.mtv.corp.google.com>
 <a3510c14-23e9-d1d9-0847-b60451f8e15d@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 9, 2017, at 01:54, Igor Djordjevic wrote:
> On 08/12/2017 17:24, Junio C Hamano wrote:
>> I'd rather do a quick fix-up on top (which ensures that at least the
>> fix-up works in the context of the tip), and then "rebase -i" to
>> move it a more appropriate place in the history (during which I have
>> a chance to ensure that the fix-up works in the context it is
>> intended to apply to).
> 
> Chris reported in this very topic[1] that sometimes, due to conflicts 
> with later commits, "checkout > commit > [checkout >] rebase --onto" 
> is "much easier to do", where "commit --fixup > rebase -i" "breaks" 
> (does not apply cleanly).

It was more of a rant about conflict resolution by rebase rather than
a concern about modification time of files. While I'd prefer git to
not touch the source tree unnecessarily, it's not really a big deal
for me if it does and some parts of the project need to be rebuilt.

The situations which tend to cause conflicts for me usually look
like this.

  ---A---B

Say, a file has this line added somewhere in commit A:

  +int some_function(); 

Then commit B adds another line:

   int some_function(); 
  +int another_function();

Then I realize that I would like to have commit A to introduce some
other_function() as well, so I add a fixup:

  ---A---B---f!A

with the following diff:

   int some_function(); 
  +int other_function();
   int another_function();

And then I often find that "rebase -i --autosquash" fails to apply
the commit B because it expects slightly different context around
the changed lines.

However, sometimes I see that if I do this:

  ---A---B
      \
       f!A

then "rebase --onto f!A A B" succeeds, nicely resolving the conflict
without bothering me. No idea why. I kinda hoped that you may know
this magic and incorporate it into "commit --onto" which will allow
to immediately get to the result of the rebase:

  ---A---f!A---B'

without spelling it all manually.

(And yeah, I'm actually Alexei, not Chris. That was my MUA being dumb
and using an old pseudonym than Google insists I'm called by.)
