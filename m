Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E62F20D09
	for <e@80x24.org>; Tue,  6 Jun 2017 11:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdFFLpI (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 07:45:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35607 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdFFLpH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 07:45:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id g15so34460468wmc.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=ypAHwtos6v9c7HFfSv7+5NIYdeKrajPp7BPsaEXiL14=;
        b=gV7Aom1bH1jF6CECCimeU+ugztdI9VV69zKaRyY0TzjdNABQ46rsmCRJUse5weJ6yr
         u6JCUNH4nyKY2fbAt5EimLf/cuNgU9BjYkcQI1TW0tbIJpmuh74FrqzM0tfp4v4k9Y+A
         0dQdgTRXHJiUhB/MPWDEMcK4MEHyIa30+iMIa/bGQmboEY2Kywf0/PVYfCJxEFthfvht
         anMptTqEa27e4+6XuSfQEw7mPdU2Isr3PLIr9DycEUy6wq78TIx+EW4Hk1sxkmCCoeui
         c3eyAJGiTyRDXA7sOS9prqH1KCan8oYIs0y58xFRzrlSNvmyLwZuwXPNVDZlRKeQHXfh
         wSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=ypAHwtos6v9c7HFfSv7+5NIYdeKrajPp7BPsaEXiL14=;
        b=ZIqvgkUP7qyKgB+hr0JmHKMxbxU+vRroa8LeloVxM9KH/fgCwN9EAAN8TuNbUV7aQy
         ol5fnAJ9fmIMClm+zxqY/vz791JfXjXOB7GvC0Zrcjk2SGdi0oPj38fWsOUEhpXLEd+J
         k27DekYZ2AC/1HWTWc6noBZ4hY9rSr+sfuMNUMKDjSb2vC3T6E2+Uex9umGTkPVGXId5
         YNcMRU+vS6D1HnYNS74jpmjbyKLlqYi861FNOuF19mSb1M94dje1HuCJ0msnxhOvopPG
         AfjlEzSr77k3/r8V6EcBLE3+SMFxvAmrEXUXSRdQqX++xTuoetR8NhB7ibSBQ3ZHkC7V
         4Nhg==
X-Gm-Message-State: AODbwcBMUa2saZwtcPZJSTu59ugNJa/b7ky8oyg5LunBg1D57fZamC3R
        ujfpxh4Jibug8w==
X-Received: by 10.80.158.99 with SMTP id z90mr9174168ede.144.1496749506259;
        Tue, 06 Jun 2017 04:45:06 -0700 (PDT)
Received: from localhost.localdomain (x590d772b.dyn.telefonica.de. [89.13.119.43])
        by smtp.gmail.com with ESMTPSA id t17sm5662162edd.69.2017.06.06.04.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 04:45:05 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "David" <bouncingcats@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Samuel Lijin" <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Stefan Beller" <sbeller@google.com>,
        "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: What does this output of git supposed to mean ?
Date:   Tue,  6 Jun 2017 13:43:55 +0200
Message-Id: <20170606114355.30749-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> >> In the context of "status", it probably is more logically correct if
> >> it said "No commit yet" or something.  This is no longer "is initial
> >> harder than root?" ;-)
> >
> > Exactly. I agree with OP, in the context of running 'git status', I find
> > the string "Initial commit" confusing in the example below, because
> > at that time no commits exist. This creates confusion what git is
> > talking about. The 'git log' message is not very friendly either.
> >
> > Perhaps say something like "Repository is empty." there.
> 
> <bikeshed>
> I like that. I think that is a very appropriately descriptive statement.
> 
> An alternative ,with slightly less textual change, could be "Waiting for 
> initial commit"
> </bikeshed>

We should consider orphan/unborn branches, too:

  git (master)$ git checkout --orphan newroot
  Switched to a new branch 'newroot'
  git (newroot +)$ git reset --hard
  git (newroot #)$ git status
  On branch newroot
  
  Initial commit
  
  nothing to commit (create/copy files and use "git add" to track)

A purely textual change will not be sufficient, I'm afraid.  Saying
"Repository is empty" right after 'git init' is fine, I like it.
However, on an unborn branch with empty index it would be just wrong.

"Waiting for initial commit" is much better even in this case, but I
still don't like that "initial", though I can't say why, and don't
have any better suggestion either.  Though users experienced enough to
create an empty unborn branch would probably not be confused by that.

