From: Jakub Narebski <jnareb@gmail.com>
Subject: Translating error messages in Git (was: Re: [PATCH v3] git checkout: create unparented branch by --orphan)
Date: Mon, 22 Mar 2010 09:06:41 -0700 (PDT)
Message-ID: <m3d3ywjq8p.fsf_-_@localhost.localdomain>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
	<3F619EAA-288D-4310-B9C6-8121FE00E7B0@pobox.com>
	<55bacdd31003220714qa9fb915k9fe152019b4d88b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Johnsen <chris_johnsen@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 17:06:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntk9S-0004kw-IL
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab0CVQGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 12:06:45 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:40247 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab0CVQGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 12:06:44 -0400
Received: by fxm23 with SMTP id 23so877261fxm.21
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=093Yn2upY8YC/zl7352wqb+tdji5Fgu7fH6I15Zn4Dc=;
        b=U+8a6JpfMitZ7gTnFHFXEIKhp+qp3pGhIbj0Es+4XMm/21aYAZn3NTDwV8EYEZPnzS
         PEn9qyldqqvieME9mWiKJ1BKRUpdLHJD+YiSrWqSyTfikOUEgl9ANoyYa7YX3EiZNx8h
         E/0jpzc0WA36B//ius0VmLObP0ogfIkiIV878=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=gQp785+yrWpPJJLfh9VtdUenEjS2QOXXVmhXaLsnnOQug0jAbX1UaSwfF+/qOCuDZn
         i94z2Z+80L7L73WXJGyzHf3d0StyFB1Hn7/HRnWXvUMeQ5wCRkqnUNQDaiL81hw5XqR3
         KvJv0l6PvrLL2fZEa4P5o790JSh1GLLZEcH4Y=
Received: by 10.102.174.30 with SMTP id w30mr1413141mue.57.1269274002968;
        Mon, 22 Mar 2010 09:06:42 -0700 (PDT)
Received: from localhost.localdomain (abvg192.neoplus.adsl.tpnet.pl [83.8.204.192])
        by mx.google.com with ESMTPS id j10sm23524628muh.28.2010.03.22.09.06.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 09:06:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2MG6EmJ009254;
	Mon, 22 Mar 2010 17:06:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2MG5wGB009249;
	Mon, 22 Mar 2010 17:05:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <55bacdd31003220714qa9fb915k9fe152019b4d88b4@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142941>

Erick Mattos <erick.mattos@gmail.com> writes:

> After this wonderful English and modesty lessons, I started thinking:
> since Git is a worldwide spread software why it is not using gettext
> to have its translations?  It would not be a hard job because gettext
> separates the job of translation from normal work flow with just minor
> changes to inline message constants.

Git uses gettext, but only for gitk and git-gui.

The problem is that git is written in C (which can use gettext), Perl
(which can use Locale::Maketext / Locale::Maketext::Gettext), but has
also some commands that are written in (POSIX) shell script.  The
$"..." syntax for message localization is bash-ism, and additionally
it is deprecated

-- 
Jakub Narebski
Poland
ShadeHawk on #git
