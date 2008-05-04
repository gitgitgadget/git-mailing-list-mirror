From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: git push won't push to a local branch
Date: Sun, 4 May 2008 13:00:08 -0700
Message-ID: <7f9d599f0805041300h4c541082h7d78625707dbf124@mail.gmail.com>
References: <7f9d599f0805041149w1955138crf269853196391e51@mail.gmail.com>
	 <20080504191936.GA3119@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 04 22:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JskOL-0003Cs-Iw
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 22:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbYEDUAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756150AbYEDUAK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 16:00:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:10972 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbYEDUAJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 16:00:09 -0400
Received: by rv-out-0506.google.com with SMTP id l9so824447rvb.1
        for <git@vger.kernel.org>; Sun, 04 May 2008 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=j5Yh4U4YZMHjvbZrgA3HWBFtbOZhvySoMd3AJqR7CFs=;
        b=T+xQEEOWd1J+JhTw9UlE6i00p0cl9ag3tvXYWcFXp33D/EtC7jxcScYPcFsQCNnYwrsihw4+SDXMOVS+JCslMgKmROVdLiiumiY4/YgPY3gMYORWKbm5INsKbW4NSdTKDJTEhkiEzWMkAdU+vD3+TrVZsVj79cdgUWsWVHPtAAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XnQDzZfUcBYcgt5v0cPJD0v+L1i936qTGEa4OykBJ5GiR19eX1LzCL/Z6oirI8C/ZyKNWr++DXnVqgawidgdR7tebb/UORbphXTz62Hxv6kOWLJUFqGlVYrRjSmBUAYOg9xpmKHfoOAPE5BNign8Q71JAQ9fKstj1oLGlahFPyc=
Received: by 10.141.4.3 with SMTP id g3mr2439248rvi.116.1209931208454;
        Sun, 04 May 2008 13:00:08 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Sun, 4 May 2008 13:00:08 -0700 (PDT)
In-Reply-To: <20080504191936.GA3119@atjola.homenet>
Content-Disposition: inline
X-Google-Sender-Auth: ce3eda04dffb2748
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81196>

On Sun, May 4, 2008 at 12:19 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.d=
e> wrote:
> On 2008.05.04 11:49:38 -0700, Geoffrey Irving wrote:
>  > Hello,
>  >
>  > There's an asymmetry between push and pull that seems unnecessary:
>  > pull can pull from local branches, but push can't push to them.  I=
s
>  > there a reason for this asymmetry?
>  >
>  > In more detail, if I have a working copy with two branches, local =
and
>  > master, I can use git pull to pull changes from master to local:
>  >
>  > % git checkout local
>  > % git pull . master
>  > ... pulls changes from master to local branch
>  >
>  > If I make a change in local and try to do the reverse with git pus=
h,
>  > it gives a confusing non-error message and doesn't do anything:
>  >
>  > % git checkout local
>  > % git rm scratch/pcomm.h
>  > % git commit
>  > % git push . master
>  > Everything up-to-date
>
>  You're pushing master to master ;-) Try "git push . local:master".
>
>  Bj=F6rn

Yep, that works.  I'll remember to use -v next time I don't know
what's going on.

Is there a reason for the syntax asymmetry?  If git pull defaults to
pulling into my current branch, why does git push default to uselessly
pushing and pulling to the same branch?

Also, can I make a bare "git push" default to "git push . local:master"=
?

Geoffrey
