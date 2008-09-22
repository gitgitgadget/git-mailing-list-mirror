From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 3/3] git abbref-ref: new porcelain for abbreviate_ref()
Date: Mon, 22 Sep 2008 18:43:18 +0200
Message-ID: <36ca99e90809220943i696c6c7ep2da2225e8a489769@mail.gmail.com>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
	 <1222074591-26548-2-git-send-email-bert.wesarg@googlemail.com>
	 <1222074591-26548-3-git-send-email-bert.wesarg@googlemail.com>
	 <20080922153222.GD3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	szeder@ira.uka.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 22 18:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhoWT-00043g-ER
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 18:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbYIVQnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 12:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbYIVQnU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 12:43:20 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51719 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYIVQnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 12:43:20 -0400
Received: by gxk9 with SMTP id 9so3254149gxk.13
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=S08Cni2htjCdaurHT7So99ByEmqXkB0nMWtBqpYFjB8=;
        b=Umf/orQK1H8NgP0FDi3FkL6v2gUi7xcCdsFnDoGfNCd4I6FAn4amHeZAq6ZKEA5K10
         KU9PKL+Yat8nMwBK+2XrGkcvh+SCQQyW4mzrwNBO//ED87vmJO8DzLfTcUwXsFQruDvw
         pkl8KlgHnvtZdATD3Jw4UoHuGtx3ZWowIU/4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GvRCkOTPw+xgED1m1g5Dd5CGXl0N9rFtkmYLdHrYHKj/Thpo5oe64iCTkXLDgQO0Fz
         PasRElxUpgYDWm+QmJTfoPZhN5gy8zUma8QMLAEYiVH8CaZO74l26pWeRdHd4yazDdVw
         2H04IyN+Djv6Ki65kvQ0Y2FI3hXBuF9fEjPO0=
Received: by 10.150.95.15 with SMTP id s15mr7578921ybb.219.1222101798778;
        Mon, 22 Sep 2008 09:43:18 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Mon, 22 Sep 2008 09:43:18 -0700 (PDT)
In-Reply-To: <20080922153222.GD3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96495>

On Mon, Sep 22, 2008 at 17:32, Shawn O. Pearce <spearce@spearce.org> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> This gives direct access to the abbreviate_ref() function. The operation
>> mode defaults to the core.warnambiguousrefs value, like the refname:short
>> format, but can be explicitly changed with the --{,no}-strict option.
>>
>> The bash completion script utilizes this new command.
>
> And it slows down too, doesn't it?  Now we are doing a fork per
> branch during completion.  Yikes.  Didn't you just post a series
> about making completion faster?
No, correctness was and is my concern, so this patch fits well into this.

Bert
