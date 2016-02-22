From: David <bouncingcats@gmail.com>
Subject: Re: interactive rebase results across shared histories
Date: Mon, 22 Feb 2016 18:41:35 +1100
Message-ID: <CAMPXz=r23aor3P4XQ3bb1iNsmO9idAUWhGrLhKpMdGa4P_Or8w@mail.gmail.com>
References: <87io1j6laz.fsf@gmail.com>
	<56C91D21.90306@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seb <spluque@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:41:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXl7l-0006fN-CG
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 08:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbcBVHli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 02:41:38 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34702 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbcBVHlh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 02:41:37 -0500
Received: by mail-wm0-f48.google.com with SMTP id b205so143190256wmb.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vkVaj7L2T9eUlYKBVJ7g77p3D/JbY/f/0bV5cPeO8bc=;
        b=zHAKPsV4H7u2UbikuAjRpDk3F12gn5+X9BQTShMRr0mYJ8LNCAMjWO4ddbs9qfn8B6
         pm54EgrCygl8JjR70MBBD93YrFCiTmbU/2oDM/rlsxv1LOmmVfuTUTD6/AQk2ZAKmeFq
         fiOt4KqMFHxfQ2DpcFEgiQ9RL9CR4sdDughYPxIsX7WYRDLCLjFBJawBS8RNHYc2fHn0
         5/GiCiobjJzlK2Hkw/AVyM4hYuGRGhidLm5NyPSjtOcpUGyZw7k4rk6SFlUevclYOjKU
         KWsFYPgD1pc9BPYmpiULOScADhyA+BTKy/Ryyzpr1a9WkSyHt3vYKr8pN41tD+RuJgTU
         RSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vkVaj7L2T9eUlYKBVJ7g77p3D/JbY/f/0bV5cPeO8bc=;
        b=CFv+MpbcJRRI6qC49YhQqsFfdyHNjBmlYtxle9CrpbQWNFW+aIRRIeG9liLYteZnKo
         Td4EZuw4hnTABuRlxp7dr2Cv+gjeBpd87qrnDEwbDVb0rjQlYLRptsm8hsp52+zW/L88
         g1yntg71AlVJaWZZhUvLU1YXbkaDDjCIEVAkTjzUvxJJR9aNPs010R6edhyE+V7P0iwk
         M0SWybGmraI5r2IWhhKOmJnjBOHMNGaWEX6H4B4J2zlar9yD+qw+SgTpVwWBfEPBywhr
         r9r7CstIvJ4lcGa85EXfDA/lVcwgsI0VXW3STojCevEd5P71p4vVnbR0waXWV4SSAuo8
         Etjg==
X-Gm-Message-State: AG10YOQFRTP4SAY0cCjLz8baqN0NvAoE6hIEZljKCZFs1TQNPsfVOerfBsYtTgI+qG/QbThrVJFQgFZR8aOKBw==
X-Received: by 10.28.184.78 with SMTP id i75mr11069154wmf.22.1456126895854;
 Sun, 21 Feb 2016 23:41:35 -0800 (PST)
Received: by 10.194.30.136 with HTTP; Sun, 21 Feb 2016 23:41:35 -0800 (PST)
In-Reply-To: <56C91D21.90306@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286890>

On 21 February 2016 at 13:12, Moritz Neeb <lists@moritzneeb.de> wrote:
>
> On 02/20/2016 11:58 PM, Seb wrote:
>>
>> I've recently learnt how to consolidate and clean up the master branch's
>> commit history.  I've squashed/fixuped many commits thinking these would
>> propagate to the children branches with whom it shares the earlier parts
>> of the its history.  However, this is not the case; switching to the
>> child branch still shows the non-rebased (dirty) commit history from
>> master.  Am I misunderstanding something with this?
>
> [snip]
>
> Maybe, to get a better understanding, you could use visualization tool
> like "tig" or "gitk" to observe what happens to your commits (hashes)
> and branches (labels) and just play around with some of these operations.

 Seb,

If you have a gui environment, the command
  gitk --all
will show you diagrams that will complement the explanations
others have given you here. You must specify --all to see more
than one branch.

And if you give a branch two names before rebasing one of those
names, then you will easily be able to compare before and after.
