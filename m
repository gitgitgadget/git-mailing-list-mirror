From: "Miles Bader" <miles@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 5 Aug 2007 13:00:13 +0900
Message-ID: <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
References: <873ayymzc1.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 06:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXHv-0005NQ-Oe
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXHEEAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbXHEEAQ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:00:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:45703 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbXHEEAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:00:14 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1090274fkz
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 21:00:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kmQ7qPV6E/E/FxGcbivd5RhFl9Lkx+ooDvI5KPY07+7mkdjc7b38qgkVoe/N/27O4miEAQFUaafv4mMnscQkQJKWhR3lqcgjI7lPe3Xw9udWv7RGNhE9Azxq0f8UBJGC3Dn5VnNmAMhO5dPFyNUYUat6MVnFcYtgazGxnqQFpo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=r2sk3BMrzuWDtZZIsvtcfk/sy6dXSh7JrDrD8XvxoXG03QyAZCs/r2DqPlGSkcE5EbYGxS0+btapEnavE501nIaRj4kV0kPPUGOEFzD/Nd00UACvIHkel+1S+gMnQFwMby09mZn7LpZfQJ/7oHJK2ma9d9/HesXYIJdr8C+45aU=
Received: by 10.86.57.9 with SMTP id f9mr3394819fga.1186286413055;
        Sat, 04 Aug 2007 21:00:13 -0700 (PDT)
Received: by 10.86.1.5 with HTTP; Sat, 4 Aug 2007 21:00:13 -0700 (PDT)
In-Reply-To: <873ayymzc1.fsf@catnip.gol.com>
Content-Disposition: inline
X-Google-Sender-Auth: 8cc6311342235d0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54932>

I previously wrote
> One thing I often want to do is git-add all untracked files, and also
> automatically git-rm all "disappeared" files
...
> One way to do this seems to be just "git add ."

Oh, also, "git add ." doesn't seem to do the right thing with
"dissapeared" files:  If I do:

    mv foo.cc bar.cc
    git add .

then git-status will show a new  file "bar.cc", but will list "foo.cc"
as "deleted " in the "Changed but not updated" section.  Perhaps the
right thing will happen if I do "git-commit -a" (though I don't know,
I don't really want to try it), this still results in incorrect
"git-diff --cached" output (it shows bar.cc as a new file, not as a
rename of foo.cc).

Am I doing something wrong, or is this just missing functionality?

Thanks,

-Miles
-- 
Do not taunt Happy Fun Ball.
