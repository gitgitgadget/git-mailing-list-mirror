From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Wed, 02 Sep 2015 13:11:35 -0700
Message-ID: <xmqqk2s8mvig.fsf@gitster.mtv.corp.google.com>
References: <20150901083731.GE30659@serenity.lan>
	<cover.1441144343.git.john@keeping.me.uk>
	<20150901224431.GA9353@sigill.intra.peff.net>
	<20150902074826.GK30659@serenity.lan>
	<20150902080529.GA19248@sigill.intra.peff.net>
	<xmqq4mjcq2ac.fsf@gitster.mtv.corp.google.com>
	<20150902194946.GL30659@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 22:11:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXENx-0005L1-Ki
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 22:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbbIBULi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 16:11:38 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35307 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbbIBULh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 16:11:37 -0400
Received: by pacfv12 with SMTP id fv12so22023620pac.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=30hScGq32a7UGzyJQ7XbeHK5hAbs1eQ//6PZBZ5sYWU=;
        b=p5Ggh9kgkRvAzIblj67cbp3LNi8Q6x+Q7F07it3nkMI+kOowDoCaWb8vd7+tFBTqGQ
         z4a9UJhC8/+I7q/zfFVT7iLzGpWPClRRz1U5RrQlekMZutG6ixDePsPDsD0YYP3BYR46
         mOyhePBOMPdQV4S36za2MctFvuo1D6l0zBjaTuCPYp8jJsOlMAwyPm2vkRWES3Jx5mOu
         glHwYEhM5P1f9NnmIcyZRGW0pY2AYPSr6nPE9GdXRNIwqbu1J/H4hfxrvDwMbdJT4tQa
         1NaCz6c3fKpO8fJVpSWCmvfUGWek6QMUqiCyZuPiTzcCAmKhDs3j05E4k0LCiSnaTXCX
         LHpg==
X-Received: by 10.68.233.134 with SMTP id tw6mr60909016pbc.22.1441224697302;
        Wed, 02 Sep 2015 13:11:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id pi4sm22629137pdb.60.2015.09.02.13.11.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 13:11:36 -0700 (PDT)
In-Reply-To: <20150902194946.GL30659@serenity.lan> (John Keeping's message of
	"Wed, 2 Sep 2015 20:49:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277119>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Sep 02, 2015 at 08:16:59AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > I guess "relative dates do not depend on timezones, so -local is
>> > meaningless" would be the closest thing.
>
> The discussion about "raw-local" was in a separate subthread, I think
> we're just bikeshedding the particular error message here.

OK.

> OTOH, I don't think there's any disagreement about what "relative-local"
> and "raw-local" would output were they supported, just whether they are
> useful.  There doesn't seem to be any harm in supporting them;
> "relative-local" will be identical to "relative" and "raw-local" will
> require preparatory code movement for the raw output.

Sure.

Bikeshedding further, while Peff's message "-local is meaningless"
is a correct statement of the fact, I do not think it explains well
why we chose to error out instead of giving the most natural result
(i.e. exactly the same as 'relative').

Perhaps stating "relative-local is not supported" without saying why
would be better.  "Because it is meaningless, we refuse to support
the option." is a very strong statement that tells aspiring future
Git hackers not to attempt to add a support for it, which is
probably a wrong message to send.
