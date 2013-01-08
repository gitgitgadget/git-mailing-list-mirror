From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 08 Jan 2013 15:32:05 +0100
Message-ID: <50EC2DE5.2050704@googlemail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com> <20130108062811.GA3131@elie.Belkin> <7vip78go6b.fsf@alter.siamese.dyndns.org> <7vd2xggm8a.fsf@alter.siamese.dyndns.org> <CACsJy8BJ3eBv-wjq=eTzR4SeEXW2MF5k1w5SFRt7fWRU4vKb_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 15:38:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsaKF-00035K-8D
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 15:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756477Ab3AHOi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 09:38:27 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:37740 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756437Ab3AHOi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 09:38:26 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2013 09:38:26 EST
Received: by mail-lb0-f181.google.com with SMTP id ge1so422667lbb.40
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 06:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=T/sI/gyfrO0tcZAxoMHv/q4vWo6xuLQxT/UVjv6XXes=;
        b=cvvCz2HL8qCXkNtZY/f66ya4V7QCmcrgMq2p9hEvdyfgQfpjHQyH/mtPIVPoLpvfkR
         reClIoUJBYhqjSZBgZT/kJtL3+qXFX66fBZ+NtgOtEnu8jXo7aHOs2PcbWbt33Hz6bOj
         PbryTZnhOlrEi5INMU2JkG0TaOl+rqMc2bsodOPMQxfXlh/DVSrBGgFOUFIFDs6kRMTA
         h+Z1Ky5mFkUM3W8E7lGDsFy5dMnzKhCQC5rf+uRbnhJWVdxEwwgelsUeK9bQ3pjpSqBB
         Jo7YHdY9sCLIt8tYuMaeVsrfAjtSZPOFiM93GKtXLEYBysbUdjFkB3mWWuVyAVGlZC+E
         jhKw==
X-Received: by 10.152.124.15 with SMTP id me15mr62470809lab.5.1357655528972;
        Tue, 08 Jan 2013 06:32:08 -0800 (PST)
Received: from [131.234.77.242] ([131.234.77.242])
        by mx.google.com with ESMTPS id f8sm15709566lbg.2.2013.01.08.06.32.06
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 06:32:08 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CACsJy8BJ3eBv-wjq=eTzR4SeEXW2MF5k1w5SFRt7fWRU4vKb_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212967>

On 01/08/2013 03:28 PM, Duy Nguyen wrote:
> On Tue, Jan 8, 2013 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Speaking of --depth, I think in Git 2.0 we should fix the semantics
>> of "deepening" done with "git fetch".
> 
> Speaking of 2.0, we should support depth per ref. Well we don't have
> to wait until 2.0 because we could just add shallow2 extension to the
> pack protocol. We should also apply depth to new refs when fetching
> them the first time.
> 

Would this mean I could do something along?
$ git clone --since v1.8.0 git://github.com/gitster/git.git

So tags would be allowed as anchors?
