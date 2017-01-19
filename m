Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1029820A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbdASSix (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:38:53 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:46813 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbdASSiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:38:51 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 113B424E16AE;
        Thu, 19 Jan 2017 09:55:36 -0800 (PST)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 986D54D3;
        Thu, 19 Jan 2017 09:55:36 -0800 (PST)
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 55FF44CB;
        Thu, 19 Jan 2017 09:55:35 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 19 Jan 2017 09:55:35 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 19 Jan 2017 18:55:35 +0100
Received: from [10.107.19.116] (10.107.19.116) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 19 Jan 2017 18:55:34 +0100
Subject: Re: Git: new feature suggestion
To:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
CC:     <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
From:   Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <d43abe2b-cd6a-9b08-272f-9dddbb8eccea@synopsys.com>
Date:   Thu, 19 Jan 2017 17:55:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.116]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

Às 6:33 AM de 1/19/2017, Konstantin Khomoutov escreveu:
> On Wed, 18 Jan 2017 10:40:52 +0000
> Joao Pinto <Joao.Pinto@synopsys.com> wrote:
> 
> [...]
>> I have seen a lot of Linux developers avoid this re-organization
>> operations because they would lose the renamed file history, because
>> a new log is created for the new file, even if it is a renamed
>> version of itself. I am sending you this e-mail to suggest the
>> creation of a new feature in Git: when renamed, a file or folder
>> should inherit his parent’s log and a “rename: …” would be
>> automatically created or have some kind of pointer to its “old” form
>> to make history analysis easier.
> 
> Git does not record renames because of its stance that what matters is
> code _of the whole project_ as opposed to its location in a particular
> file.
> 
> Hence with regard to renames Git "works backwards" by detecting them
> dynamically while traversing the history (such as with `git log`
> etc).  This detection uses certain heuristics which can be controlled
> with knobs pointed to by Stefan Beller.
> 
> Still, I welcome you to read the sort-of "reference" post by Linus
> Torvalds [1] in which he explains the reasoning behind this approach
> implemented in Git.  IMO, understanding the reasoning behind the idea
> is much better than just mechanically learning how to use it.
> 
> The whole thread (esp. Torvalds' replies) is worth reading, but that
> particular mail summarizes the whole thing very well.
> 
> (The reference link to it used to be [2], but Gmane is not fully
> recovered to be able to display it.)
> 
> 1. https://urldefense.proofpoint.com/v2/url?u=http-3A__public-2Dinbox.org_git_Pine.LNX.4.58.0504150753440.7211-40ppc970.osdl.org_&d=DwIDaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=X0bQCOGTuZF-uq6smPwJDw4Q47qHgjWaewgTHCbhMnM&s=97U97toe9A6XOAJxbhxvWeYpzl-wPw9QvlhQfAEUTdI&e= 
> 2. https://urldefense.proofpoint.com/v2/url?u=http-3A__thread.gmane.org_gmane.comp.version-2Dcontrol.git_27_focus-3D217&d=DwIDaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=X0bQCOGTuZF-uq6smPwJDw4Q47qHgjWaewgTHCbhMnM&s=agYFOBCbLeaKAB6frWWzcwHkZyrMZLW4ExgDxzQyVlI&e= 
> 

Thank you very much for the info!

Joao
