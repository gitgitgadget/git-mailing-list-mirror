From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/RFC v3] add a commit.verbose config variable
Date: Fri, 11 Mar 2016 01:16:45 +0530
Message-ID: <CAFZEwPNYFBXrUUt9sgHtOYvUVZwQYV-VbyNLWzMz5MFFqH+CkA@mail.gmail.com>
References: <0102015361e5441b-bbc448b5-7307-451d-a951-f016f7ae4b1d-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 20:46:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae6Xq-00049E-RN
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 20:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbcCJTqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 14:46:47 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35573 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbcCJTqq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 14:46:46 -0500
Received: by mail-yw0-f175.google.com with SMTP id g127so76483726ywf.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 11:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=M60vix/VwaBSoghR0zaketuoUqqQgZNcC8P8o+lsO3I=;
        b=DWxA6dDx5RsbrjKffKD9m8UJnN3olvzX7ID8UM1STz7PkAE1K+IdFA0S1RKuTywQWy
         2KDFHj/cqqxforLoSSxnqMNinmQShqnO2cPGq/GxcfCI/HdA3tUZSqvi021nhTBDDR06
         9vwnAUiuHO5+WGHuD3HCzrNobehAiEGBXVNslzLdMGHZ8B+OHx4wmBW0p058NY/tgODw
         or5PrzjJVsWNHeHdiLGR0GmX+zkXotwRq775eKlsA6bjWE+dC929gb3ZBxhxjQp/rGgV
         Emn1ya1xOuKF2QP2LxkgteqRy+8GESz/stnuH4oT48FacjUoHrG2BL+ny6n7Vn2pZ1eN
         rtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=M60vix/VwaBSoghR0zaketuoUqqQgZNcC8P8o+lsO3I=;
        b=VUV6WAPDyjUU4HO8RLJF92xiYF3jzGGo11gS83jSJmY+rhXzoWhNmmEyVbcsHivLct
         vS2HwigmjYWnbujJVM54f7kZ3pawaKjkeDZ641t0Wt6tfuN1yNgyaSuv7AoRjo/kKBHi
         JBSFxMow08sNV+tfyX2UXaoF1aIJrq2hQmtIPRUCf1wwWsc8fYocHvWBFUUmMXW4j+P9
         AW2Bn1On94iKU9S7QcjXJInqBSYzr0Pua4Qt9TKx2rbg4osloc3TtQWk+WvSerf8sG2v
         TP6Gzt9iuTE8W604SILB2LqN3gq0Xrnfz8TRBjmH+0Lu53p6xzf9v/GOC7Khaw12HxfA
         5KBA==
X-Gm-Message-State: AD7BkJJOvy1s1YxGLbJJdSx9DlVQ33YzQHg4GO4/quCoE3HEqu9W7eXpz2kxy3C4o85Fn9bbFqk3EwuYoaChdw==
X-Received: by 10.129.9.214 with SMTP id 205mr2859087ywj.53.1457639205139;
 Thu, 10 Mar 2016 11:46:45 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Thu, 10 Mar 2016 11:46:45 -0800 (PST)
In-Reply-To: <0102015361e5441b-bbc448b5-7307-451d-a951-f016f7ae4b1d-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288635>

Older versions of this patch can be found at :-
[v2] : http://thread.gmane.org/gmane.comp.version-control.git/288569
[v1] : http://thread.gmane.org/gmane.comp.version-control.git/287540

The changes are :
 - Remove the concept of override-verbose
 - Add the git_config_bool to the method git_status_config instead of cmd_commit

I have to yet figure out how to write the tests for this. I will see
the examples that Matthieu Moy mentioned for their implementation.

Regards,
Pranit Bauva,
IIT Kharagpur
