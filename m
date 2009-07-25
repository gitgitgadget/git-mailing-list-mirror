From: Dan Savilonis <djs@n-cube.org>
Subject: Re: git format-patch from date never set
Date: Sat, 25 Jul 2009 18:49:34 -0400
Message-ID: <325c62f60907251549o27ebc8f2gcd1d728adb662ffd@mail.gmail.com>
References: <325c62f60907251439n6f3f661dhf0e76a74ce1eaec8@mail.gmail.com>
	 <81b0412b0907251531u7566813fr10bdd70187e9aca6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUq40-0001pd-U3
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 00:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbZGYWtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbZGYWtf
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 18:49:35 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:46923 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZGYWte (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 18:49:34 -0400
Received: by gxk9 with SMTP id 9so4570657gxk.13
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=SoUttsIV4cx+VfwJ4DK+SSzFB0vQEIEoV7g2hmPun5Y=;
        b=pXdOG3K1bZADBgmrqskdO4J7Di73CCfmNT8McMw/SqUL56dlxiN95OnveHZEvNdYoy
         sdM+zb8DcZMpBE1/hzBkT3NEyHONGqbly05kcnKpSD/+8cebB5Q7LVyU6hnPgAUkFo+/
         pvbRyTcsggwASZcwQu2pqaLRK8z5dmVNQNBhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=sn4ZYffamDOAuQvex8zH+9OlSHVzGVM4Hh9nDIAV0b9WOclwcXa1cHnZn937UAP15L
         h4LrUAyNivwuLLeRN9migMe2NwiH2+5K0FUMIJRgbs5TMgR72hjMsE6/2rTCkM3CFqIE
         tKLxwmdNYLb1GkqopFx+iXzp6oKiQ/iXTxwnM=
Received: by 10.231.19.7 with SMTP id y7mr1680330iba.9.1248562174557; Sat, 25 
	Jul 2009 15:49:34 -0700 (PDT)
In-Reply-To: <81b0412b0907251531u7566813fr10bdd70187e9aca6@mail.gmail.com>
X-Google-Sender-Auth: fa8d270928e3af16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124084>

On Sat, Jul 25, 2009 at 6:31 PM, Alex Riesen<raa.lkml@gmail.com> wrote:
> Neither. This is not a date, but a part of "loosely defined" mbox format.
>

In the examples of mbox format I have found, the date in the From:
line is generally the same as in the Date: line, albeit in a more
ambiguous format. Further, the the git code treats it as a date and
attempts to set it. It remains at the default date only because
git_committer_info() is called without GIT_COMMITTER_DATE set.

So is the code misleading? Was it designed to just meet the minimal
requirement of having a date-like string to comform to the mbox
format? What's the disadvantage to using the real commit date?

--
Dan
