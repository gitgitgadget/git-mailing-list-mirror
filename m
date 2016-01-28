From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 4/6] worktree: new config file hierarchy
Date: Thu, 28 Jan 2016 19:03:38 +0700
Message-ID: <CACsJy8C3wXL-nE1TfS7V8BFNwaQTjMtkQibCswycpX_teaATpQ@mail.gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com> <1453808685-21235-5-git-send-email-pclouds@gmail.com>
 <xmqq7fiu7je7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	"Max A.K." <max@max630.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 13:04:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlJ9-00042Q-Le
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 13:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbcA1MEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 07:04:12 -0500
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36824 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671AbcA1MEK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 07:04:10 -0500
Received: by mail-lb0-f193.google.com with SMTP id ad5so1722883lbc.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z6SnVe99Uio3K+iD9SlOS85JVtK9AJ1fXpHrqCC/S2k=;
        b=lS5w/OqJFXSNQVIrRAekpX8pVrODQ2YtAQDGVbDA6ZSbVvsdRTULPyoAwapdIQUlQS
         GNbzY5aVuXyEJdtZUTRdC8GglZw7eAvYTclxZEOcoXIFn/yeWYXk3s6zE1Ti90ICfehf
         esMWT9fN/drE/TdoGUg2kclyemOTK1YB0Gm1lGoPdj531MzppIKEsoMI/4AterY+1x3P
         WlXF0sncJ45ECqAQMvcwACHPEEIgZUrE6kmpWrwm7Qo8B5iOCQFIbjiY2ooUaIWBDS/r
         pB8KT1zJyF3vdA2ZpzNKa12DD3l4iCKt+jAKEBgpaQmKg/MfjiorfbyQx+auNXcIt3P1
         +Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=z6SnVe99Uio3K+iD9SlOS85JVtK9AJ1fXpHrqCC/S2k=;
        b=bxdMCvem2WUVI/2PH3e/4VGMRUAc8pYkS8AQHAKRvjvXU9lbYTw0p0b0kshZVGd1YT
         WD6vAkMp6MwAs5237DeZsHTGkx2EkqKM/9ZO6GDXJvUTklj0Wolt1+nM3HC5Ve/5afIl
         cfoiNVA4Jx/JtQXalKe5QP1Xq/oruZUvnQMAC5BaHu2bw2VQbgnBR1TZX4Gqmzg1DAY0
         weaaBAyVCm7kQfRR3SaD1IvucRnd1DoktvxxWXrpgP8BUrQT77GgeFv7YZuEx6zWm2sI
         RnwGVvhltSkdqisKmT2U/lZnSq0V0sr3uMRtOcQvXmwarTgL4xiEsX//NWPgoikHMbAK
         JPZA==
X-Gm-Message-State: AG10YOS6znZEehB04IxZ1A/dyXiaObn3NLHvRLsHWFJHcuV4FHHK29tOYJEZrwSWLobiTOl2/EWyHQJSGD3MNw==
X-Received: by 10.112.209.99 with SMTP id ml3mr1002187lbc.26.1453982648227;
 Thu, 28 Jan 2016 04:04:08 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 28 Jan 2016 04:03:38 -0800 (PST)
In-Reply-To: <xmqq7fiu7je7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285018>

On Thu, Jan 28, 2016 at 5:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> With this patch, since worktree v1, the repo config file (or worktree
>> config file in multi worktree context) is no longer shared. Main
>> worktree reads $C/config.  Linked worktrees read $C/worktrees/xxx/config
>> and a new file, $C/worktrees/config. Sharing is done via this new
>> file. The read hierarchy for a worktree becomes
>>
>> 1) system config
>> 2) XDG config
>> 3) user config
>> 4) $C/common/config
>> 5) $C/worktrees/xxx/config (or $C/config for main worktree)
>>
>> Compare to an alternative scheme where $C/config contains both shared
>> variables and main-worktree-only ones, this is a cleaner design.
>>
>> * We do not have to check every single variable name to see if it's
>>   shared or per-worktree when reading config files.
>>
>> * We do not enforce any particular variable split. If a variable
>>   is in $C/worktrees/config, it is shared. Putting core.worktree in
>>   $C/worktrees/config is punished the same way the variable is put in
>>   $HOME/.gitconfig, for example.
>>
>> * We will provide a new "git config --repo" to access this new config
>>   file. In single-worktree context, or worktree v0, --repo is an alias
>>   of --local.
>>
>> There is one problem though. We store worktree version in config file
>> and expect that all worktrees must share the same version (i.e. read
>> the same config file). But the share-ness of per-repo config files is
>> changed based on worktree version. Where do we put extensions.worktree
>> then?
>
> I cannot see why it cannot live in $C/common/config, which would be
> read as the fourth alternative in your earlier enumeration.  What I
> am missing?

I wasn't clear. The last paragraph is about already released git
binaries, which does not care about $C/common/config. Suppose you add
a new worktree with new git binary, which will move common stuff out
of .git/config to common/config, on a shared repo. If the old binary
reads that repo, it does not see common config, but it does not know
where common config is either.
-- 
Duy
