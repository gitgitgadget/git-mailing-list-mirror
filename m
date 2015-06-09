From: Stefan Beller <sbeller@google.com>
Subject: Re: On undoing a forced push
Date: Tue, 9 Jun 2015 09:55:58 -0700
Message-ID: <CAGZ79kYLGV0mp2JzT8p4ZK2_zsbMiYD_yjp4boTMx=bygAYrMw@mail.gmail.com>
References: <20150609121221.GA14126@lanh>
	<5576F2DC.7040603@gmail.com>
	<012a980b0b9f1aa394e2b3701e4e6f97@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 18:56:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Mon-0000OS-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbbFIQ4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 12:56:01 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36185 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbFIQz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 12:55:59 -0400
X-Greylist: delayed 87134 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2015 12:55:59 EDT
Received: by yked142 with SMTP id d142so11096758yke.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=l2SJlqOkXlvlzl/kxI/N6Mj0B3zKguXb5/LTgB+2+70=;
        b=Ren/6ad/ZugvXS+5BBgMAcZIr3RBSYxZOWAJbRYUQRevZXlKAjY+hKCXkopzFFYbgq
         vzrT5BwBn24x3ONzM243eaPFqSKI1iXjq+FV5GiQ7+Q3HrqbBY0jf48BdD99x7zOqwUz
         stEB6jOPxP/4gv/2Og/NF8bJbcxOMZSdR+ZDbpsEtkDwT3fQZpN+DHsr97SlOt8YHs7K
         HNd1RvU88AiFP4IdJ4rb/gKPwNPhMLyX4a4NLHa2qt/aOrw1mSynnhPZwqJP3efEbKXK
         OZerIQ2yo2WW+TB+cwhylFTkb/8CSS/a/NKtUwwEHeTUTvX6QKN5Ed9d2w1KrHTjshuh
         KEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l2SJlqOkXlvlzl/kxI/N6Mj0B3zKguXb5/LTgB+2+70=;
        b=J2MhbrKGfF0riNyMLNlU8zmqfzJs1NruebNr5vs0wf30N/yYui8pgO0Fu1ze5Hs6MK
         om5L1sCtezCCgA7gSZPQZLKUkXsJOyEYdDvdcZlDWYVcRlPmG9BqUGHnQmYcLMFb/ttc
         PkM9ZkfdTuBPiLfTnaTpVr0dS1owymFPCn/nSazXBTyoEmNLzwOHKEuGxK9oTPQSk/D+
         mceG8zkXchI8YRMF3K4MMKHHAcDqoM2F9ZGiMbH6KB27ExlDDHRxZaZtuHXrEPP/vYpx
         jSWEIMpSdqx7BvpePwAC12ijKz8snMP+5o6UrI36ILpBN3XjS7XsOMVDPBWWufTWiMKM
         PG7Q==
X-Gm-Message-State: ALoCoQncGTDEeKzf4mfiA8IaU3YxqBt8shjFvzlH/xFS3UIHT960JyGPnvid8zSRbm4Xm3VIwHxT
X-Received: by 10.170.43.16 with SMTP id 16mr26478583ykl.119.1433868958485;
 Tue, 09 Jun 2015 09:55:58 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Tue, 9 Jun 2015 09:55:58 -0700 (PDT)
In-Reply-To: <012a980b0b9f1aa394e2b3701e4e6f97@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271202>

On Tue, Jun 9, 2015 at 9:29 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi,
>
> On 2015-06-09 16:06, Sitaram Chamarty wrote:
>> On 06/09/2015 05:42 PM, Duy Nguyen wrote:
>>> From a thread on Hacker News. It seems that if a user does not have
>>> access to the remote's reflog and accidentally forces a push to a ref,
>>> how does he recover it? In order to force push again to revert it
>>> back, he would need to know the remote's old SHA-1. Local reflog does
>>> not help because remote refs are not updated during a push.
>>>
>>> This patch prints the latest SHA-1 before the forced push in full. He
>>> then can do
>>>
>>>     git push <remote> +<old-sha1>:<ref>
>>>
>>> He does not even need to have the objects that <old-sha1> refers
>>> to. We could simply push an empty pack and the the remote will happily
>>> accept the force, assuming garbage collection has not happened. But
>>> that's another and a little more complex patch.
>>
>> If I am not mistaken, we actively prevent people from downloading an
>> unreferenced SHA (such as would happen if you overwrote refs that
>> contained sensitive information like passwords).
>>
>> Wouldn't allowing the kind of push you just described, require negating
>> that protection?
>
> I believe that to be the case.
>
> Sorry to chime in so late in the discussion, but I think that the `--force-with-lease` option is what you are looking for. It allows you to force-push *but only* if the forced push would overwrite the ref we expect, i.e. (simplified, but you get the idea) `git push --force-with-lease <remote> <ref>` will *only* succeed if the remote's <ref> agrees with the local `refs/remotes/<remote>/<ref>`.

Yeah that was my first thought as well. It's unfortunate that
--force-with-lease is not as well known though (it wasn't there first,
so many people picked it up and "it's good enough" to not pickup other
--force-with-foo options).

Maybe we should add the option receive.denyNonFastForwards =
onlyWithLease instead?

Thanks,
Stefan

>
> If you use `--force-with-lease`, you simply cannot force-forget anything on the remote side that you cannot undo (because you have everything locally you need to undo it).
>
> Ciao,
> Johannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
