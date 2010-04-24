From: Jakub Narebski <jnareb@gmail.com>
Subject: 'commit -a' safety (was: Re: Please default to 'commit -a' when no changes were added)
Date: Sat, 24 Apr 2010 02:40:39 -0700 (PDT)
Message-ID: <m3633hdw9u.fsf_-_@localhost.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 11:41:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5brB-0001UF-77
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 11:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab0DXJko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 05:40:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45138 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab0DXJkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 05:40:42 -0400
Received: by wyg36 with SMTP id 36so332091wyg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=6GGyHQOaXMAJZgpQpDuAjDecSmy6frE/LVUKtjYa/pY=;
        b=rCbWy1EGzTPoX45eM+sQLi6lHGX46zXIYCltbn5KKHO9YUYyCNSfhfy78wNjs7Zmnk
         Cw84m6MGDfxK2mCjuc/g7lvcByDhlg0Sb+bmCK/9/ymVE61szbz7RSDSV9+6b7wle5Sa
         arKxQaFmKSfq3o9ACkR00fZtYp0n4wYa9xqn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=tlV/XT6uA/wdoLsb46wWlHQ4hV5cEiOwUHmhvwWSwoLqw2lqEDPCicb/rl92mUtDbK
         GQax43nTSS/Ig0cVJKdw2EfLjjvqnev3Gsskg9zulG4XgAMfNtQhlveeO9mw7XTE0aUb
         oCHtf+G+1N4RWNCIqjPBw7ibZdk9itS5lgYJ8=
Received: by 10.216.178.207 with SMTP id f57mr1583788wem.88.1272102040647;
        Sat, 24 Apr 2010 02:40:40 -0700 (PDT)
Received: from localhost.localdomain (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id x1sm2866523wbx.1.2010.04.24.02.40.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 02:40:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3O9dwUh026581;
	Sat, 24 Apr 2010 11:40:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3O9dgot026576;
	Sat, 24 Apr 2010 11:39:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100422155806.GC4801@progeny.tock>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145662>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Starting out, I can see how it would be comforting to people if
> =A1git commit=A2 would default to -a behavior if they ignore the inde=
x.
> That is logically a different operation, though, so it would also sen=
d
> a wrong message and make it harder in the long run to get used to the
> interface.

I agree that making 'git commit' do 'git commit -a' if there are no
staged changes would be a bad change.

> Instead, I think it would be better to focus on making the error
> message more helpful.  Right now there is a screen full of status
> before the advice, which might make it easy to get scared before
> reading it.
>
> Here=A2s a very rough patch to suppress that screenful.  What do you
> think?

It's a pity that people didn't concentrate on this part: improving
error message...


On a bit unrelated note what I'd like to have is 'git commit -a'
(optional) safety against accidentally getting rid of staged changes.

I'd like for 'git commit -a' to *fail* if there are staged changes for
tracked files, excluding added, removed and renamed files.  If you
have some staged changes you would get an error message:

  $ git add tracked-file
  $ git commit -a
  fatal: There are staged changes to tracked files
  hint: To commit staged changes, use 'git commit'
  hint: To commit all changes, use 'git commit -f -a'=20

Perhaps this behavior would be turned on only if some config option,
like commit.preserveIndex or something like that is set to true...
--=20
Jakub Narebski
Poland
ShadeHawk on #git
