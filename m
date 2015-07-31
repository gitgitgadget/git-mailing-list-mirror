From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] notes: handle multiple worktrees
Date: Fri, 31 Jul 2015 15:00:48 -0700
Message-ID: <xmqqmvyc3s33.fsf@gitster.dls.corp.google.com>
References: <1438364697-6647-1-git-send-email-dturner@twopensource.com>
	<xmqq8u9w5fnd.fsf@gitster.dls.corp.google.com>
	<1438379086.4735.25.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 00:01:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLIMQ-00021t-9c
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 00:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbbGaWAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 18:00:53 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33559 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbbGaWAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 18:00:51 -0400
Received: by pdbnt7 with SMTP id nt7so48812330pdb.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=evWN8y6AzsMPIWx1WC2qb6gjvOkZ3HfRQ/ibAd8LSw8=;
        b=TnVPEo97r5xhWDa4ND1VCetFj/F2rIXh5fbgywPlTFhTTzTOp817oDR2HAWvULXRtN
         KNO86CQyv6zbFcMcL2mxZd32hH/BWiB2g0s9upB3D6yn+no/tn+9EHJITull9Cu/thkX
         /dPMYwcd4kbPD2piUpOhEPODXEvAEqml789PYx0ncE4tt1Xzuq50whIQCwtE7G7Gcgmo
         2XS9yrOmsbIOJX997ccAGxRKQo6IyaQp2MxEEGHEvmgTfw2pnfk5+ROIUIb1z16M/Rzm
         gS2BErNLiUalx732AjYilumHg4HrlQnP213cv5Mi2+01sIX1FeNeeM2n9Ja7bJakmsdK
         CWfg==
X-Received: by 10.70.129.133 with SMTP id nw5mr11420591pdb.52.1438380050804;
        Fri, 31 Jul 2015 15:00:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id fn1sm9491085pab.8.2015.07.31.15.00.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 15:00:49 -0700 (PDT)
In-Reply-To: <1438379086.4735.25.camel@twopensource.com> (David Turner's
	message of "Fri, 31 Jul 2015 17:44:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275083>

David Turner <dturner@twopensource.com> writes:

> I further propose to add some patches (to go on top of the pseudorefs
> series):
>
> (a) include worktree-refs/ in per_worktree_refs and include
> worktree-refs/ in per_worktree_refs in common_list, and

Do you mean .git/worktree-refs/, just next to .git/refs?  Then I
think it makes sense.

> (b) include changes to bisect which switches it over to use
> worktree_refs/*.  To make this change compatible with bisections started
> with old git versions,...

I personally am not sure if it is worth the effort to cater to those
who start bisection, stop and then upgrade their git version and
expect to continue.
