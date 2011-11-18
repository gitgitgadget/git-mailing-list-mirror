From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Fri, 18 Nov 2011 15:19:37 +0100
Message-ID: <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Nov 18 15:20:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRPIm-0000dS-7b
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 15:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409Ab1KROUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 09:20:19 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56240 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933Ab1KROUT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 09:20:19 -0500
Received: by ywt32 with SMTP id 32so2487670ywt.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 06:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CfVNpCl/Ru0qa22S2jyO0CPXjoKJHSsQucExxy3KfiA=;
        b=Vy0tKHFBd+9UdtHqPyER8SEY1b3LUsHkDG1Si0RvQAcobSAqD6wWPNHTKW5vPF1Ulm
         CSAoJUqIHhjv+uQq5UQqiUhZBZrlirAOwydrHvTHReqZq5JiW5b6xBv/RPprQ34Zp9Uh
         0gxKJgMEo7vohlDEzg4pFvLLfUxHsGtIMFmq0=
Received: by 10.68.39.98 with SMTP id o2mr9995106pbk.119.1321626018161; Fri,
 18 Nov 2011 06:20:18 -0800 (PST)
Received: by 10.68.71.135 with HTTP; Fri, 18 Nov 2011 06:19:37 -0800 (PST)
In-Reply-To: <4EC65DE4.90005@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185663>

On Fri, Nov 18, 2011 at 2:30 PM, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:
> Am 18.11.2011 12:36 schrieb Erik Faye-Lund:
>> On Thu, Nov 17, 2011 at 4:15 PM, Sven Strickroth
>> <sven.strickroth@tu-clausthal.de> wrote:
>>> From 8e576705ca949c32ff22d3216006073ee70652eb Mon Sep 17 00:00:00 2001
>>> From: Sven Strickroth <email@cs-ware.de>
>>> Date: Thu, 17 Nov 2011 15:43:25 +0100
>>> Subject: [PATCH 1/2] honour GIT_ASKPASS for querying username
>>>
>>> git-svn reads usernames from an interactive terminal.
>>> This behavior cause GUIs to hang waiting for git-svn to
>>> complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).
>>>
>>> Also see commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795.
>>>
>>> Signed-off-by: Sven Strickroth <email@cs-ware.de>
>>
>> IIUC, GIT_ASKPASS is intended for passwords and not usernames. Won't
>> this cause console-users to not see their username prompted anymore?
>
> git also asks for username using the GIT_ASKPASS tool (if GIT_ASKPASS is
> set).
>

You are right, it does. Documentation/config.txt documents it as being
for passwords without mentioning that it also affects usernames,
that's why I wondered. I've also verified what happens here on my
config, and git-svn doesn't prompt my username here without the patch
either. So consider my comment withdrawn ;)
