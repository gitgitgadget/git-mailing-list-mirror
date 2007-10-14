From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: [PATCH 5/7] Bisect: factorise some logging into "bisect_write".
Date: Mon, 15 Oct 2007 00:40:22 +0200
Message-ID: <8c5c35580710141540j6f93a08j2179c5c394bfacd5@mail.gmail.com>
References: <20071014142948.9f08b8ed.chriscool@tuxfamily.org>
	 <Pine.LNX.4.64.0710141706440.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Christian Couder" <chriscool@tuxfamily.org>,
	"Junio Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 00:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhC8R-0008G7-AI
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 00:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759954AbXJNWkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 18:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759803AbXJNWkZ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 18:40:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:29210 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759626AbXJNWkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 18:40:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1740661wah
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=1CdwPaPFcAY62rrNsC+RxvcYYX0NQB/XsnDPVr0BsN4=;
        b=Hh6nZL/4aDqHwb16VYx5dg+Wj6dsEqpriH69G0nDx7nGblW4IQWP+IOm2/UWo+ANUVwcumFnansNX8hseGXL0GPhxQH97s2m+kvWWZNNnjVN1usIyoOnNlQaidEK8kNup9Ej8mYE9VZ0YF+GGWP60Cyl0HkNYeqQN6zapHAS1nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ruKehaTs20gailztJQhQss+S/GtBezboS/TiZe/uGi+t2bC0nyEN8Y1msjvQj8q/U67o8HDVyqXpdmONd0IAIsFUvU3mUgSG3j8MVNWH4ShU0djYaCOE7yhIhRkyyMGzX5ZO0bb/Hbty21n/j88h/cY/H4UjqVbIEa++6M7j+iE=
Received: by 10.114.27.20 with SMTP id a20mr6220797waa.1192401623246;
        Sun, 14 Oct 2007 15:40:23 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sun, 14 Oct 2007 15:40:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710141706440.25221@racer.site>
Content-Disposition: inline
X-Google-Sender-Auth: 2021e7bf96b03c05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60922>

On 10/14/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 14 Oct 2007, Christian Couder wrote:
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 847250c..e12125f 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -132,6 +131,7 @@ bisect_write() {
> >       esac
> >       echo "$rev" >"$GIT_DIR/refs/bisect/$tag"
> >       echo "# $state: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
> > +     test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
> >  }
>
> Isn't a nolog="$3" missing from bisect_write()?

Good catch, I've amended the commit and replaced q/cc/bisect-dunno
with this series.

--
larsh
