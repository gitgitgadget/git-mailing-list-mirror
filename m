From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: Re: [PATCH 2/3] configure.ac,trace.c: check for CLOCK_MONOTONIC
Date: Mon, 22 Dec 2014 04:36:17 -0800
Message-ID: <CAD_8n+TX-foWkRr9BrFX9PHu387WfTCD+w84m7QLjwhMwEKNjQ@mail.gmail.com>
References: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
	<1419188016-26134-2-git-send-email-reubenhwk@gmail.com>
	<20141222041232.GA170128@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Reuben Hawkins <reubenhwk@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 13:36:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y32Dr-00021N-KP
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 13:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbaLVMgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 07:36:18 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:42209 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206AbaLVMgR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 07:36:17 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so20918936obc.6
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 04:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ApCIm2sNP1+rRlTAT99VwtUzHsVg+HqOFwfyV+hV3t8=;
        b=SxaLsye6PsSgn8ITgIrUSTzYShQS36niXEakq2tgezHB/uDVgZsX5IalHF4yDImcvn
         JftiLOZWVhuSkdIysopzJKmAi13Jw4RldSwuBlaHAnCbAtaR4JepDOfDZGQ0ZK3kDliN
         YGwnSStS9xsZ9//o6yaGeFN6TZrSmNR+zEcTXVLXhHkZ4u2JFjbja/cWgoJKzgXRnXij
         pNMQpwAAVXoJTM0cI1ngwaZRQfKhrTvL/98nAHaeR9BDMfEqG3dnQGXpx/wuc2vN0BLA
         jbm+WYf0Q8kFhDhmqPH+PVXEpSj6EculnopUO+WNoXeZQzA5AkILZH1xpf25w5UnJM3E
         Qwyw==
X-Received: by 10.182.94.133 with SMTP id dc5mr12971213obb.32.1419251777197;
 Mon, 22 Dec 2014 04:36:17 -0800 (PST)
Received: by 10.202.176.85 with HTTP; Mon, 22 Dec 2014 04:36:17 -0800 (PST)
In-Reply-To: <20141222041232.GA170128@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261643>

On Sun, Dec 21, 2014 at 8:12 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Dec 21, 2014 at 10:53:35AM -0800, Reuben Hawkins wrote:
>> CLOCK_MONOTONIC isn't available on RHEL3, but there are still RHEL3
>> systems being used in production.  This change makes compiling git
>> less tedious on older platforms.
>
> While I'm not opposed to this change, I expect that you'll find there's
> lots of subtle breakage when trying to compile (and run the testsuite
> for) git on RHEL 3.  I've spoken up before to prevent breakage on
> RHEL/CentOS 5 (since $DAYJOB still supports it), but I'm not sure
> anyone's looking out for something as old as RHEL 3.  I expect you'll
> probably have some pain points with perl and curl, among others.

Yes, there are pain points with perl and curl.  Those I've disable
with other compile options when building on RHEL3, but reducing the
number of options I have to set manually and increasing the number of
automatic checks with configure is helpful.   Sometime over the next
few days I'll submit a v2 of the patches with Eric's comments taken
into account.

> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187
