From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to apply diff between A and B to a file?
Date: Mon, 25 Feb 2008 10:58:03 -0800 (PST)
Message-ID: <m3fxvgc18q.fsf@localhost.localdomain>
References: <20080225214326.353d0e95@wizard.volgograd.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Denis Shaposhnikov <dsh@wizard.volgograd.ru>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:58:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTiXL-0002jr-J6
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 19:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbYBYS6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 13:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbYBYS6L
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 13:58:11 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:34268 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbYBYS6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 13:58:08 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2365425fkz.5
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 10:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=hDNy2EEyZIzcHvq0KsDhjOYEaar23fWdDdVRGVgSJF4=;
        b=AFX0UGzOq3R8ie8bGgbmzf7iw5a7GbktcmD1Nzffztcq9d8CracRQrAo0D5wsY42B2OxOcKqUehYDPHpVZXwo7VdZxrD/wyZ+cEl0hiKEP0YjBoUUzgfbfseNhIp3lbOJfhgYVZPPu5vrZBRN76c4FmMIOq2MjPcmsu5e6krQ5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Xp4wFoQ++U59yovFJr/fu1NI5fD6bs9TYMPBqfo1cfCRNzUqTQ/TIBveFmPuClqLIzxSiuO4y9eoCPW3xDNsQe3pppsUh8fg3i8UoDZtietK26u2LVRXiTHDWVuYaWcUX5sVl5dTIOhsUl3Woqcz3lImpn5CGv4UNb7h9GsKcjc=
Received: by 10.82.189.6 with SMTP id m6mr6659755buf.16.1203965885422;
        Mon, 25 Feb 2008 10:58:05 -0800 (PST)
Received: from localhost.localdomain ( [83.8.199.10])
        by mx.google.com with ESMTPS id b36sm9351827ika.2.2008.02.25.10.58.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 10:58:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1PIvxJ4012521;
	Mon, 25 Feb 2008 19:57:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1PIvvu9012517;
	Mon, 25 Feb 2008 19:57:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080225214326.353d0e95@wizard.volgograd.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75045>

Denis Shaposhnikov <dsh@wizard.volgograd.ru> writes:

> Hello,
> 
> With svn I used a command "svn merge -r A:B some/file" to apply diff
> between revisions A and B to file some/file. I done it in one branch,
> in trunk for example. Is it possible to do such thing with git?

Not using "git merge", which is by design whole tree opration in
Git. It must be, to support rename detection.

You can, however, do the following:

  $ git diff A B -- some/file | git apply --index

(not tested!).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
