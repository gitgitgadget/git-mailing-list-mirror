From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: locate commit by file
Date: Tue, 04 Nov 2008 01:57:39 -0800 (PST)
Message-ID: <m34p2ng6eq.fsf@localhost.localdomain>
References: <491003BC.7040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 10:59:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxIgi-00039I-8L
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 10:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbYKDJ5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 04:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYKDJ5n
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 04:57:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:59393 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbYKDJ5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 04:57:42 -0500
Received: by ug-out-1314.google.com with SMTP id 39so136298ugf.37
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 01:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=cvgEcyUUZWuOBkvybEqTu+R4E5KGtB1hlYVB0O0Ovfs=;
        b=WzsMNYz4Cu/rf59+91MLVxwpeN1yvfZaLUl81pCZg3n7Y9y5nUk80x2ydSbNPhs+wM
         /5Z+HvgfdM2hEKlqIXetyzZvqP3i6/pa81/gP8do39QaFLD2fgMWjkrAE+cudiD0zGAh
         pzdYmTv26VK4/aaBwS9wZMk0IMcn/pUnJ/3sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=pFJAnqb4Q0oBnTgFTIVf9zmBSgNxHaO3qRU7yR83jgEkRLgQtjcw+QC+0evVM7e94/
         fw+9tYTVDa/7pYEoG/X9PirhgBQmlEINHqRPKs7ASlSt/HeV1pqGccLVNwIiSArfotLA
         FsNsN7X6sTV8nuT8/9HhE0ow9/NyztfCNvC5A=
Received: by 10.67.106.13 with SMTP id i13mr2752572ugm.37.1225792660757;
        Tue, 04 Nov 2008 01:57:40 -0800 (PST)
Received: from localhost.localdomain (abvp158.neoplus.adsl.tpnet.pl [83.8.213.158])
        by mx.google.com with ESMTPS id u7sm745791uge.15.2008.11.04.01.57.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Nov 2008 01:57:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA49vZQA026638;
	Tue, 4 Nov 2008 10:57:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA49vYcT026635;
	Tue, 4 Nov 2008 10:57:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <491003BC.7040206@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100065>

Ittay Dror <ittay.dror@gmail.com> writes:

> Given a file, is there an easy way (e.g., not bisecting) to find the
> latest commit where the file content is the same?
> 
> Meaning: I have a file /tmp/A and I want to file the latest commit
> where a/b/A is identical (content wise) to /tmp/A.

Do you mean: find the commit which changed file to current version?
I think that

  $ git rev-parse -1 -- file

Would work (but better check "git log -- file").

If you want to find which version corresponds to given contents, you
would have to find sha-1 of /tmp/A (using "git hash-object"), and
find it in difftree searching for sha ("git log --raw -- file", or
just "git log --raw" if you are not sure about name).

I think you can fins such script in mailing list archives...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
