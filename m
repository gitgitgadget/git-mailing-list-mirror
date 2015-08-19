From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] am --skip/--abort: merge HEAD/ORIG_HEAD tree into index
Date: Wed, 19 Aug 2015 10:55:20 -0700
Message-ID: <xmqqy4h79n93.fsf@gitster.dls.corp.google.com>
References: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
	<CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
	<03631611149f05dbcd862b4c1e8e9d6b@www.dscho.org>
	<20150817094819.GA10375@yoshi.chippynet.com>
	<xmqqsi7hd817.fsf@gitster.dls.corp.google.com>
	<20150819082222.GA27685@potato.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 19:55:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS7aB-0002GU-QI
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 19:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbbHSRzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 13:55:23 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33229 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbHSRzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 13:55:22 -0400
Received: by padfo6 with SMTP id fo6so1788653pad.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zpE0JL5eMsnKvWVCierbIkRjED+ICWjAEHOO/XGnKFI=;
        b=BZm0Q6OFcgmNyZd1deDXQMgDgTYOwuGx0YnLZMKMq9nHrSLbsoIfnDQemGjN7lEZc+
         F/9Gz8MpxiF2tvgQ1ZuTchyqewqUJbr1tZq4YOyU9XtrKaHYkXYXDZLjExjoktKXGOCP
         +QYXhm+MSjgeOgcqrFWLQwDBWvgPXCf9scbsz20i5C6GaYLaoNss5qZtuAxiywN5LbJE
         U0d0Mu3881I1Fj42vzovFdyjbpGJisJJXFKi4cRv0ajjYLUvVPKVQjm0Hqxpm6LXHKsJ
         HYMzU7cyITFzt43a5OL0ste3UTM4fYdsi+xWaOe2lNbKH5Dghz4eHyHNkoZCd9M22Z/m
         JFvw==
X-Received: by 10.68.116.142 with SMTP id jw14mr27417650pbb.147.1440006921968;
        Wed, 19 Aug 2015 10:55:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id mi6sm1617456pdb.1.2015.08.19.10.55.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 10:55:21 -0700 (PDT)
In-Reply-To: <20150819082222.GA27685@potato.chippynet.com> (Paul Tan's message
	of "Wed, 19 Aug 2015 16:22:22 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276206>

Paul Tan <pyokagan@gmail.com> writes:

> (In addition, I fixed a small mistake with the "struct tree_desc" array
> size.)

Yeah, one thing I forgot to mention was that I suspect this kind of
"oneway merge" already in other places in the code, and a future
mini-project might be to inspect them all and try to see if their
commonalities can be taken advantage of.  If we had a small helper
function to do the "do the equivalent of 'git reset $TREE'", this
miscounting wouldn't have happened.

The change looks sensible.  Thanks.
