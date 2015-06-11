From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Thu, 11 Jun 2015 07:47:22 -0700
Message-ID: <xmqqegligv45.fsf@gitster.dls.corp.google.com>
References: <5575F948.4060400@web.de>
	<xmqqioavob7n.fsf@gitster.dls.corp.google.com> <55788190.80106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, eda@waniasset.com,
	Duy Nguyen <pclouds@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 11 16:47:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z33lS-0006R6-04
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 16:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbbFKOrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2015 10:47:25 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:36493 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbFKOrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 10:47:24 -0400
Received: by ierx19 with SMTP id x19so2285987ier.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=OB6td3SP877a91U4nxOrKq2Ku9WGuy2pP7ZMRVMxATI=;
        b=GymirATd7NiQZtJS2LO7CvfMqyvPdJ1hKFbblBUNOy0N5vTJtYFIUOv3PtHw9wMQ+N
         H7NHWNoKk6RiInzWe4wgcnT2TywghVO9D71+22LfnY8uHXl0E0ecWXX2sCwRs102qpkW
         6R7JKD/zFOya0F/X+8tQZd/lIuHq0If76dOEqBgJS/WTjwnT16hycqR+LIHaFyW0ES+u
         MJUDdYsbLGrF4IFmCuBMjWMaY73ZN/UghEY5AtilOXMFrOU0FJuWfjdzVFR0UKudWeei
         8vwmxPdM3Y+bylWhfriEip5XCQw3a8zZcHPIAPh5v95FPFpDTIX8SfwRWcwCMPs+ZSH2
         jbaw==
X-Received: by 10.107.168.82 with SMTP id r79mr11785141ioe.4.1434034044401;
        Thu, 11 Jun 2015 07:47:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id f126sm492519ioe.21.2015.06.11.07.47.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 07:47:23 -0700 (PDT)
In-Reply-To: <55788190.80106@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Wed, 10 Jun 2015 20:27:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271411>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2015-06-10 17.05, Junio C Hamano wrote:
>
>>> -git-checkout - Checkout a branch or paths to the working tree
>>> +git-checkout - Switch branches or reverts changes in the working t=
ree
>>=20
>> Two verbs in different moods; either "switch branches or restore
>> changes" or "switches branches or restores changes" would fix that,
>> and judging from "git help" output, I think we want to go with the
>> former, i.e. "switch branches or restore changes".

Gaah, no we do not "restore" changes.  We "restore" working tree files
to their pristine state.

And "... or restore working tree files to their pristine state" is
way too long.

Unfortunately "overwrite changes in the working tree" is even worse.
As it does not say overwrite _with what_, we invite the original
confusion that triggered this whole thread if the reader thought an
equally useful but different "overwrites with result of merging your
local changes to the pristine" (similar to what "checkout -m" does)
would happen.

At least, "restore working tree files" without saying "restoring
them to what state?" is much less likely to cause such a confusion.

So...

    git-checkout - Switch branches or restore working tree files

perhaps?
