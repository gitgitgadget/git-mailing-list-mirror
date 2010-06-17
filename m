From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: moving a remote branch?
Date: Thu, 17 Jun 2010 20:13:08 +0800
Message-ID: <AANLkTikeLpvGA-RFBdMGblOnhNKJ6dUrpUZQlENMP51A@mail.gmail.com>
References: <AANLkTikA5jGl1LiU2sNTN1NP_syTfPAeLF7sS6dBozyN@mail.gmail.com>
	<AANLkTimTSU7Db7cMlC0ZxQ47IoBUr4Ee4G-GfgDoYLmK@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC74483CEEA82@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Anderson <zelnaga@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 14:13:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPDyD-0001hF-OL
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 14:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914Ab0FQMNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 08:13:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61534 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab0FQMNP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 08:13:15 -0400
Received: by yxl31 with SMTP id 31so2185067yxl.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TZzsx6HR4m/Rrfvt+HZQJTyZaWXkVR+ZdaoVmDGqZrc=;
        b=Nxk3kN6rlURZGGWx0oj3mEtdlMhdgvG6MglOrSKCQ/Krv9AEaEpwri0ZMMfhnYD4TE
         IbwpvJtdGdGKD5FQ5n3o226UlZUYMs6RytxvfugarM61BfzxwYU9Xi76XzSQx3UeRRzh
         mZxxOles21oMYwXspD1mz/dBj/kBiDVO/gbyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fp6ghJSFDEeZyRh+Q0A1+/twrlCGp0Y6jBJPy6qu7yD6eLGo7bt63FpsFMIc64Abkk
         j4AaOKJIvIh2WuO6LuUSWMykMA+vQ9xFCN/H56TMC9Mx7Qunssc+QqYStf547XHEb6eg
         rLxiQKl6CYrXamWZHQOADNeBUEv6EqDhaM8/Q=
Received: by 10.91.164.27 with SMTP id r27mr7623929ago.77.1276776788774; Thu, 
	17 Jun 2010 05:13:08 -0700 (PDT)
Received: by 10.90.29.10 with HTTP; Thu, 17 Jun 2010 05:13:08 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483CEEA82@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149302>

On Thu, Jun 17, 2010 at 4:28 PM, Peter Kjellerstedt > Renaming a
remote branch is a two step operation. First you push the
> old branch into its new name, and then you remove the old branch. It
> can be done with these commands:
>
> =A0 =A0 =A0 =A0git push origin origin/featurea:refs/heads/featureb
> =A0 =A0 =A0 =A0git push origin :featurea

I'd like to add (more confusion!:) with this clarification:

The two push operation above rename the branch on the remote side.
It does not affect any of your local branches.

If you do "git branch -a" then you'd still see the
"origin/zelnaga/featurea" branch.

Doing a "git fetch origin" will get the newly renamed branch from the
remote repo and create a local version of it on your local repo.

At this point you can do "git branch -D origin/featurea".

nazri
