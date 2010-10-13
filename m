From: Matt Stump <mstump@goatyak.com>
Subject: Re: Speeding up the initial git-svn fetch
Date: Wed, 13 Oct 2010 10:47:46 -0700
Message-ID: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
References: <AANLkTinOQd4xo6VsDXQxShhrRFM28cJfKHjnVPpRuY-q@mail.gmail.com>
	<4305143.485826.1286985726762.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 19:48:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65Qh-00085a-5H
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab0JMRrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 13:47:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43425 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0JMRrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 13:47:48 -0400
Received: by iwn9 with SMTP id 9so65194iwn.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=h65ip/POnvX3ssdAibz5/gOhvDMr3tiGpVtq07N0vaw=;
        b=L5v9fGFMsTZRIjxWVN59c+vwQ6HJ3hr6FZKGDleYa937wDDvuKX2wLKZOoYLEOfq5A
         fEcGphLjDZu71yJBV4ZoViqlpYy4G1kuL4C9KOBHgbJ2Xoh9vCXKmvs2VCcT/2/b5lzV
         4ldsIxU79tTsbnDFUG2dU0zvSApOeD+gMrZWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=h/Ve+cozL09ilw/2yJCslsOdZZHXzQk82ZvIkyaFvEx6B0GcoTi0rXgpiV0pUDD9y5
         R7bET0eyPNtLnWS/a2WFIPWbxDIWdtA6dcw29wPXV4CHnQ9BD21aqgEJ2kxhlLQ28FbL
         BXsIQVInD4ZGzU7A/7oStqOYfXMKaXp7d/fCQ=
Received: by 10.231.161.73 with SMTP id q9mr7257391ibx.70.1286992066872; Wed,
 13 Oct 2010 10:47:46 -0700 (PDT)
Received: by 10.231.197.169 with HTTP; Wed, 13 Oct 2010 10:47:46 -0700 (PDT)
In-Reply-To: <4305143.485826.1286985726762.JavaMail.root@mail.hq.genarts.com>
X-Google-Sender-Auth: LGIAZ6i3O_0bF-Z4tOp_Ypz_600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158951>

I hate making more work for people but I would love a copy of your
notes.  Getting a full clone of our SVN repository is probably the
biggest hurdle to having a git insurgency take root.  Also, which GSoC
project were you referring to?


On Wed, Oct 13, 2010 at 9:02 AM, Stephen Bash <bash@genarts.com> wrote:
>> What have other people done in similar circumstances?
>
> Based on suggestions from this list, I sidestepped git-svn and used s=
vn-fe [1] and git-fast-import. =C2=A0It imports the entire Subversion t=
ree in a single git branch, but using git's tools that's workable. =C2=A0=
At an extremely high level I used git-filter-branch to split up into br=
anches and git grafts to stitch the various branches together to repres=
ent the SVN history.
>
> The real devil is in extrating the SVN history, but there are a few g=
otchas in the filtering/recombining. =C2=A0I haven't written up a compl=
ete summary for the list because I thought the GSoC project would super=
sede my process rather quickly... =C2=A0If there's interest I can trans=
pose my internal documentation for public use.
>
> As a benchmark, our SVN repository was about 20k commits, ~400 tags, =
~100 branches, HEAD contained ~7k files. =C2=A0git-svn took several wee=
ks (and never finished), svn-fe and git-fast-import took ~20 minutes (m=
y entire process takes about 4 hours).
>
> [1] http://github.com/barrbrain/svn-dump-fast-export
>
> HTH,
> Stephen
>
