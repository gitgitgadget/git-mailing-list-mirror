From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched branch
Date: Tue, 18 Sep 2012 08:04:10 +0700
Message-ID: <CACsJy8CUuPPvTMNmtX9P5ZHkvUHCVZkKmPj7Ghubxt_daPaKZg@mail.gmail.com>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org> <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
 <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
 <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com> <7vd31kv2ba.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 03:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDmF7-00013C-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 03:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab2IRBEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 21:04:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60943 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab2IRBEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 21:04:41 -0400
Received: by ieak13 with SMTP id k13so1443725iea.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 18:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5wJfm9tRsodqluSEtYNXL4bbT5+TIH2uAMF56ysT4pk=;
        b=EbC6roig2NJEv4U5kwOfPTeQ+WsrEhSB3u1A67QBEmbxVAmwZya35RbMPGPQFq4+MY
         1QsQOtYsD4maHnM8SwhTCwyai1KlYRqd35/tB/b4S3DyjybPRB3lqYTV7VXT3GUs+zMM
         In9GqjFAICLqAsd38fMyip36Dm1ZtJ7v+yzIExbCWnsrLovNKdeJXhd6qfLO9OBwqTpP
         +7fx44CF0/67W/2hhGS/zbswxkswlFwx+sDSrbGqm/Pn2vD4Q62e+g+fQc8sq7G4/ScV
         ZW/W01YNC31EuQeTWcfNNXnL+fLuVQLATYYeN36fMDzUjjJsGd85nLf0mUQOHzbfJUov
         SjmA==
Received: by 10.42.109.194 with SMTP id m2mr10316515icp.48.1347930280829; Mon,
 17 Sep 2012 18:04:40 -0700 (PDT)
Received: by 10.64.167.139 with HTTP; Mon, 17 Sep 2012 18:04:10 -0700 (PDT)
In-Reply-To: <7vd31kv2ba.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205777>

On Tue, Sep 18, 2012 at 3:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Mon, Sep 17, 2012 at 7:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>> --mirror --single-branch combination does not look right. The "heads/"
>>> part is missing..
>>
>> It also does not look right for cloning a tag:
>>
>> $ LANG=C ./git clone --single-branch --branch=v1.7.0 .git abc
>
> What does it even _mean_ to clone a single branch and give a tag,
> not a branch, to the --branch option?  Again, shouldn't it be
> diagnosed as an error in the first place?

That could be misleading. The original purpose is to clone just one
ref, be it a branch or a tag. You might want to work on top of a
specific version and may not want to clone everything. For cloning a
tag, we're put in detached head state immediately.
-- 
Duy
