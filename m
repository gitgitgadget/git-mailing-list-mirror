From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 2 Jun 2016 20:58:27 +0700
Message-ID: <CACsJy8B1PXhSNSu-p5vdk7crHsy7cKisxJ0rtZXsknrZorx+Ug@mail.gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com> <20160522112019.26516-2-pclouds@gmail.com>
 <20160526051820.GE6756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 15:59:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8T9U-00066N-8q
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 15:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbcFBN66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 09:58:58 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32783 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbcFBN66 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 09:58:58 -0400
Received: by mail-it0-f65.google.com with SMTP id v125so2901961itc.0
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lamC6ZZFBI2rznIWOFCF4iVjWw1225s1FU8ZfHmxtJc=;
        b=UDWp0A/ePfTs+KerOVhpSlqTbBELmMD6oZQlZ66XlokYH3R8hXsvHBpzURFRVS6/UZ
         MgFa58VXTf5kSXGJzcK+65bRAgtVx5z+1yFDBMvfeeQLE5slFzncMZ+aoqZkXGoaT7Yz
         86fOKdn4YUAd6/3HSAA5via6wWusn3SsVfM0k8YaQ1/CSqf5obEfqwER9A1i5pzQN83X
         QPG+delo6ID/u9xsWX0gPz4q7IajzMhgC7aDS0TRZbUYhuTD0FKdb8fkc0dR0vQJusc3
         vEr89PXskc6rlGoVZk3cj7naCFJi1wxquQlsxLDvRFxNGz2DWi3rZ6rjVizp25Br0AH4
         u0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lamC6ZZFBI2rznIWOFCF4iVjWw1225s1FU8ZfHmxtJc=;
        b=dZpyiCzL2LM3FrbswkFv5FJLRqApyJwRZjInxl/wKczNFaNN+HVMoP6iCzW78NYH65
         g64YsC7zOTFKye0cBum9f9m9XJ1uwDlErEL6DmJxnfDQZTKufXEq9FB4SZVum2DMGqxD
         Ipvtozdl22XmFIF3OwLKZ0MLaBCxU736HuKrriezhmsTMc4WP/bEPiC0l5TG7LVttGh1
         kF8CbvpB6DGf7JoJLKB4TwKWs76OCIAgmpXOhf/7P8RK/eG9OA/hjBVz72ptkA7jBqlN
         /4CWxyZoegn5ggyr0IIK+7P2eJQYav2Xw5YoUCxOtW1s52L7F3PGulNPiSPSiMBp8VK1
         /snQ==
X-Gm-Message-State: ALyK8tKtCgFVPbxT6qLvO8NzI4zyZXEIZwjQuJ6+OK1/frJt0Y7AMofqcFVwQt7T2ShVE3iS5RAfyhIn7u7dOg==
X-Received: by 10.36.115.76 with SMTP id y73mr3700681itb.63.1464875937178;
 Thu, 02 Jun 2016 06:58:57 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Thu, 2 Jun 2016 06:58:27 -0700 (PDT)
In-Reply-To: <20160526051820.GE6756@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296198>

On Mon, May 23, 2016 at 7:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> That is, I wonder if the above can become something like:
>
>> From github.com:pclouds/git
>>  * [new branch]      { -> pclouds/}2nd-index
>>  * [new branch]      { -> pclouds/}3nd-index
>>  * [new branch]      { -> pclouds/}file-watcher
>>  ...

for context of the following quote...

On Thu, May 26, 2016 at 12:18 PM, Jeff King <peff@peff.net> wrote:
> I do agree with Junio that we could probably improve the output quite a
> bit by not showing each refname twice in the common case. I don't quite
> find the "{ -> origin/}whatever" particularly pretty, but something like
> that which keeps the variable bits at the end would make this problem
> just go away.

I tried it out. It's a bit hard to read at the "/}" boundary. Color
highlight might help. But it occurs to me, could we extend refspec a
bit to allow "foo/bar:base/..." be be equivalent of
"foo/bar:base/foo/bar". Then fetch output could become

>>  * [new branch]      2nd-index:pclouds/...
>>  * [new branch]      3nd-index:pclouds/...
>>  * [new branch]      file-watcher:pclouds/...

It might be a tiny bit better, and a forced update could be displayed
with a prefix '+'. Hmm?
-- 
Duy
