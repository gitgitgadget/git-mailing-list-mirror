From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How can I tell if a tag has been pushed, or not?
Date: Fri, 10 Jul 2009 21:28:10 +0200
Message-ID: <81b0412b0907101228t2cc55aa6g21d2a11ec9caa1c1@mail.gmail.com>
References: <14563.1247247807@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 21:28:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPLlf-00087k-NO
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 21:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbZGJT2P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 15:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbZGJT2O
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 15:28:14 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:54162 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbZGJT2N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 15:28:13 -0400
Received: by bwz25 with SMTP id 25so1089605bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e2Evi7myA5ULYjZ/ofTGSKW9dQ5r4H7iw0RSlcEZWm0=;
        b=TjGmqngkPtNfOPksRGtFw8vyO9oik/D+dAHkZwKKh/qH+ni8fsTsljsIjfdVf5b//r
         jyjpRlU8cpTmTn8aQfRGZNgbDu0PYNntk3tCZ6cykSltShpb+BnI+9m2wwQeZQbOPk7r
         6VFWa3FUIL0C8w9c/oKlv3v5CzgrHEzzet1Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wFDdF41pRSC9rD8BEI5KDlvpygy8+zbROEegticQ9BRuWV7NMxs/W67mTzEQiBXqPk
         ajY8J4xKeX2rpfJVDcpjiF08Mrj4WG3s4fn6TVhBvmNqAy5bdMpaTocQuIpKJ2dmUESP
         GWCZC+dADjTRRyV63N5Df9pcvfk3X4587qUhQ=
Received: by 10.204.112.205 with SMTP id x13mr2203019bkp.213.1247254090991; 
	Fri, 10 Jul 2009 12:28:10 -0700 (PDT)
In-Reply-To: <14563.1247247807@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123077>

On Fri, Jul 10, 2009 at 19:43, layer<layer@known.net> wrote:
> Here's the problem:
>
> I expect that users, in their own private repos, will from time to
> time create tags that should not be pushed. =C2=A0Sometimes, tags tha=
t
> should be pushed will be created.
>
> I could require that the "public" tags follow a specific convention
> (start with "release", or something). =C2=A0Then, the scripts all my
> developers use could use that and push only certain tags. =C2=A0Howev=
er,
> over time there could be a large number of them. =C2=A0It seems undes=
irable
> to push each tag each time a push is done. =C2=A0So, how can I tell i=
f a
> tag has already been pushed? =C2=A0Is there a way?

git push does not push any tags by default. You either have to
specify them explicitly or add --tags (all tags). Maybe that is enough?

Otherwise, there is always git ls-remote 'tags/*'...
