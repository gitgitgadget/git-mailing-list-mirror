Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568861F744
	for <e@80x24.org>; Fri, 17 Jun 2016 11:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbcFQL1U (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 07:27:20 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33758 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbcFQL1S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 07:27:18 -0400
Received: by mail-pf0-f182.google.com with SMTP id i123so26388754pfg.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 04:27:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RjnSntOHbFeMlDNIBf/6LNtRGoEY+SqciLs4BuE1V+M=;
        b=Z969NnAsXZd+G0QaFXpEElMp00SzgBCdbF2ud5Q+1u6aBZQdDDV3zqNvz6EWAlAX0j
         1/fCqz2R33Fz9zyRp1Iz6Kafc7yOsp2W8e5qzwTPrEFqwJdYYQzZQ7nNqWdFYGpyn6/b
         yrGmZXKNEBDgQJemVWzafWi3OWcTY1vcJEg/SR5ijaAuCrTU3+w/wgFv0ofPr6De9HSQ
         pBepEJuTMGOAMWtpqLXZlEGjp6whYETCytN6wjJIGpy524Rz5sCgwKhvMLkaS+nbMzLH
         XZKBxGIPOvDHeRWq9nhtYjr6y+NkrnTcWTiYKmVZPP3rMfY/12Etl3ncFP2jLDSj20ym
         dPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RjnSntOHbFeMlDNIBf/6LNtRGoEY+SqciLs4BuE1V+M=;
        b=UdSNtiNLwaiS1tW5CAK0D+Hzj28RHFbbO/UxkrQulaic1qlwNdRXFu+CQ9U7PSsPre
         1rWqKgK9yHf6WlUsbpEBqPVxDICgidTq3LOGu2si7qbqu/WWEJFKFE+G43VXglSZVcAP
         i6ArKHx+ZN8VRINPZ5dmYnAfqY0luSYGJgog6geY6VCB62eawUVSzrrfZMIsqo+F5zZh
         0nmM7zyHYvlkV//zuB6u8R/epxjZF0KAzWMOaJg4Nh3TzMenpl7Vt3aeuhGtbbTBi0+R
         Ug/Q3sg3d/xtzxWb4SUnw1fMD8DJ7BbtKNxsjK8qIXa45/nBctzPE2Vsh4NUaANdZq2h
         61Qg==
X-Gm-Message-State: ALyK8tId13vh6fVUpZhN4e8eCV2YGcOb+TNApflLfOue5x/DQZr1wjUsuspAhQ09kUtgxw==
X-Received: by 10.98.24.134 with SMTP id 128mr1960219pfy.52.1466162832471;
        Fri, 17 Jun 2016 04:27:12 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id z29sm62653733pff.0.2016.06.17.04.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2016 04:27:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Jun 2016 18:27:07 +0700
Date:	Fri, 17 Jun 2016 18:27:07 +0700
From:	Duy Nguyen <pclouds@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, josef@kufner.cz
Subject: Re: [PATCH 0/2] Log pretty format alignment improvements
Message-ID: <20160617112707.GA29739@ash>
References: <20160616131838.14440-1-pclouds@gmail.com>
 <xmqqtwgt3s9z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtwgt3s9z.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 11:25:28AM -0700, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > The first patch was from a long time ago. The concern was it may be
> > breaking existing user expectation [1]. I still maintain that it's a good
> > thing to do and should not break anything. Hence the resubmission.
> 
> I do not think "it's a good feature to have" was a question from the
> beginning.  Thread [1] stopped with me saying "as long as >(N) can
> be used as Duy claims as a workaround to get the original behaviour,
> it is good to allow using >|(N) for this new output format; I didn't
> check if >(N) does behave that way, though".  What was necessary to
> resurrect the patch was "Yes, >(N) can be used that way and here is
> a test" or something like that.

Ah ok. This command with this series (using %>(n))

~/w/git/git log --format='%>(50,trunc)%s' --graph -15 origin/pu

and the system one at version 2.7.3 (using %>|(n))

/usr/bin/git log --format='%>|(50,trunc)%s' --graph -15 origin/pu

both produce the same output like this, checked with md5sum

*   Merge branch 'js/am-3-merge-recursive-direct' in..
|\  
| *          am: make a direct call to merge_recursive
| * merge_recursive_options: introduce the "gently" ..
* |            Merge branch 'tb/complete-status' into pu
|\ \  
| * |                         completion: add git status
| * |      completion: add __git_get_option_value helper
| * | completion: factor out untracked file modes into..
* | |    Merge branch 'mj/log-show-signature-conf' into pu
|\ \ \  
| * | |    log: "--no-show-signature" commmand-line option
| * | | log: add "log.showsignature" configuration varia..
* | | |              Merge branch 'nd/worktree-lock' into pu
|\ \ \ \  
| * | | |  worktree.c: find_worktree() search by path suffix
| * | | |                     worktree: add "unlock" command
| * | | |                       worktree: add "lock" command
| * | | |               worktree.c: add is_worktree_locked()

The output looks weird though, which makes me a bit hesitate to add it
in the test suite...
--
Duy
