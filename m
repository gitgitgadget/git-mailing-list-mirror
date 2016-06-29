Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF9120FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbcF2VAe (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:00:34 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36171 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbcF2VAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:00:33 -0400
Received: by mail-wm0-f45.google.com with SMTP id f126so196808211wma.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 14:00:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E7toOIZmjkE9WzHNeAYCuhDIU6sogsP/eeAKCsbUaCY=;
        b=umHB0ZOppBvrs/oxtKx+eIglPb3rZ6RwMWZVSjvNGJVvvLE134EQH+gRFMfbIzANic
         ZRXpHmVFUIjpLe1aehPP6u6D0BiOau6q+tBRM+UAmXnMcmdKpP5w8dvkNJvJkW6tguFl
         c0Kct5TKY+/OQuW4F2UxlWDIPlfTH/wycJHgSLHII0JeCpbTgX6u/gSWel7RJ7cxBZn9
         PLkd8p2FPZbB2qPkQtstfSXNzoTzFR2qxV2QZ/phRyqLonsbBFroYi+Dl477fFrLIjNm
         hFT7iHn3k8TUrNdPZlQVzR25yBxxpSmNKBBljlGPa0smQswgL+GiYl1/Dbr3DP6u3TTd
         cwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=E7toOIZmjkE9WzHNeAYCuhDIU6sogsP/eeAKCsbUaCY=;
        b=EwPKMSWJ3Vm7Un7GPJaXPVM9muijszLGlqxSjGfFRJ/NKGkK94fQgNU/6Re9LvsXK+
         qeHNh3LDqSyn48xqcUXGZLtZab48gzorx0qKsTOQmQyygGHYQ05EvMZ/zQHxnLQZJ92t
         moltQzVoWMT2wED92zln/mBUtPvrxZt4yagJj4fWNADxppv8hE3Cy8sG6+EYQBJASID7
         EBaQu+VRybw6ozMXy17fYIQriGNLdSdiXRDV3JrQllcW33OkDfsxlE0Qmm+IcW2OlIxO
         MqPTyReEztM68A3W2US/2DJ8tJQLDfnDOuMZ/sCDEcJiIDRRDq93mLV5/5kzS+zjIxz2
         sDJw==
X-Gm-Message-State: ALyK8tJw212bm67LEGAnxsrh+dhA2cYsIxPELqkN1OqjV72zD03o+P4M4jGDzKJP90vyCQ==
X-Received: by 10.194.38.4 with SMTP id c4mr10296316wjk.20.1467234031341;
        Wed, 29 Jun 2016 14:00:31 -0700 (PDT)
Received: from [192.168.1.34] (aefh205.neoplus.adsl.tpnet.pl. [79.186.137.205])
        by smtp.googlemail.com with ESMTPSA id ag3sm5420345wjc.39.2016.06.29.14.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 14:00:30 -0700 (PDT)
Subject: Re: topological index field for commit objects
To:	Junio C Hamano <gitster@pobox.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <577436DD.8050708@gmail.com>
Date:	Wed, 29 Jun 2016 23:00:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-29 o 20:59, Junio C Hamano pisze:
> On Wed, Jun 29, 2016 at 11:31 AM, Marc Strapetz
> <marc.strapetz@syntevo.com> wrote:
>
>> This is no RFE but rather recurring thoughts whenever I'm working with
>> commit graphs: a topological index attribute for commit objects would be
>> incredible useful. By "topological index" I mean a simple integer for which
>> following condition holds true:
>> 
>>  if commit C is part of the history of commit D,
>>    then C's topological index is smaller than D's index
>> 
>> This would allow topological sorting of commits (e.g. in queues) on the fly
>> and quickly give a "no" answer on the question whether D is part of
>> C's history. 
> 
> Look for "generation numbers" in the list archive, perhaps?

If I remember correctly the discussion, the problem by adding generation number
to the commit object format was twofold (at least).

First there was a problem of backward compatibility, namely what to do with
existing repositories, where commit objects do not have generation number.
Objects in Git are immutable (and I think replacements mechanism wasn't
invented yet - anyway too many replacements would slow down operations
I guess).

Second objection was of philosophical nature: generation numbers duplicate
(cache) information that is stored in the graph of revisions. Also, what
if they get out of sync?

That is, if I remember the summary of that discussion correctly.


Also, generation numbers (graph level) only help with topological sorting;
for finding of two commits are connected (two nodes are connected) people
play with different ideas, for example FELINE index:
  http://openproceedings.org/EDBT/2014/paper_166.pdf

Nowadays there is also [compressed] bitmap index (if enabled), though I am
not sure if it is yet used to speed-up reachability queries
  http://githubengineering.com/counting-objects/
  https://www.eclipsecon.org/2013/sites/eclipsecon.org.2013/files/Scaling%20Up%20JGit%20-%20EclipseCon%202013.pdf

-- 
Jakub Narębski
