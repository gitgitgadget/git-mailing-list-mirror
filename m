From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: "git pull" doesn't respect --work-tree parameter
Date: Wed, 22 Dec 2010 18:55:23 +0700
Message-ID: <AANLkTikoBaJmo97wh_zNaUAFHq3sf1j4b2HDuEmjRKnt@mail.gmail.com>
References: <AANLkTi=UtZuPQcTNnwS_fXgzRn4MHAUGS8zyTMqX9E2J@mail.gmail.com>
 <AANLkTik9s0cLc_P=NWvpO=DhytOkLNASEM7sjzoscHo3@mail.gmail.com>
 <AANLkTinGPJRQCOVz5JeqL4xnUG9V=5fkJhz6C5Mi1A3o@mail.gmail.com>
 <AANLkTimM9Ah+D6uYnOuZDjYzKfN2-YVArOAwegO9dbSD@mail.gmail.com> <AANLkTi=JrOe=z4LNZtxfsDvkG2jYCtemYESftv=61ZrJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Alexey Zakhlestin <indeyets@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 12:56:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVNIW-0003Gy-VF
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab0LVLz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 06:55:56 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64219 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab0LVLzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 06:55:55 -0500
Received: by wwi17 with SMTP id 17so4983779wwi.1
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 03:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=1xSdE32gtJqz+Y6tI0YKy1fWI9BhwvNKd2vtLAVGD8U=;
        b=mnTN8ktlGA35NeYHqSwJ+ZLBgF/amAmJgLayNgOkHfIQBQEyCnRO/TxSvrWpjka0Th
         MDxxisZvn5LCvc6ZkPAdHPo1Atb0LhwPQ0kklBnhkAK6vl8UuByZ3uFpehkni8A8FloK
         LXGLMziMIXRjIyvaLuthIt5KAQaCoJGjViPig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wLlP0hbeOJnwrS21eu08CnAN7Gl57q7xcC+OaK3FmpRQR4vYygvsZYGbEnAEZ5M2H4
         o22nXge92dJYmUe0R+KJ1u60nuMIFIr4DoC5ueGOQ7uIPbTGLUsz4NCZcS3geTARCaqW
         TCwLp10wW6zazibhLkxX5gspe4XvnH4+cYrGA=
Received: by 10.216.52.206 with SMTP id e56mr7633952wec.19.1293018954120; Wed,
 22 Dec 2010 03:55:54 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 22 Dec 2010 03:55:23 -0800 (PST)
In-Reply-To: <AANLkTi=JrOe=z4LNZtxfsDvkG2jYCtemYESftv=61ZrJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164084>

On Wed, Dec 22, 2010 at 6:50 PM, Alexey Zakhlestin <indeyets@gmail.com> wrote:
> 1) returns correct path:
> /Users/indy/Documents/Sources/_mine/midgard/mvc/_rdf/midgardmvc_core/.git
> 2) false
> 3) returns correct path, again:
> /Users/indy/Documents/Sources/_mine/midgard/mvc/_rdf/midgardmvc_core
>
> just to make myself clear: $PWD is another path, not related to repository path

OK. git-pull does not automatically move to worktree (while git-status
does) and thus won't work when $PWD is outside worktree. I remember
there's a similar report this year. I'll see if I can make a patch for
it.

Thank you for your report.
-- 
Duy
