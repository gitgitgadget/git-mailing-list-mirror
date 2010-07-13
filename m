From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git branch
Date: Tue, 13 Jul 2010 18:04:18 -0500
Message-ID: <20100713230418.GA1818@burratino>
References: <1279061452603-5290193.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:05:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYoXI-0007r2-JO
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab0GMXFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:05:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44741 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab0GMXFF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:05:05 -0400
Received: by iwn7 with SMTP id 7so6325051iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tkXbF6736tRhTz19jFIaSssrKw5q7gOeIKFdmjAEuRc=;
        b=Wtz01mgottA8KL7CfaWWRAce9wd4gSrkovP09fzynkYFRgCs0w3GxnCBjjmOJQrPE8
         lNm3/0HA37bGW1ZOPCBsuyWZsmT6OFo+Zfu+ypZctLgDlSS2usWrPig09vNsmr8I70Hl
         aPwkIye4a2D54pJLXultishvH8zf0nIgDn4Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z/VQVsy4sdTl56Coi0Go7OBDkm5o9VTwezAfdOY3HvMzLm+XE/BbquNxdkjG1xxFlG
         7zewmAMCtmDuB0s9KlLz1GbZv2+aRUm2/O0TF1+R1kvoHl9KlaoN9RPm/uMZG4/mEAJe
         2p7bRvT664hrzT+e6ShDduDimMHBO0CNuJMFg=
Received: by 10.231.31.200 with SMTP id z8mr17222008ibc.90.1279062304484;
        Tue, 13 Jul 2010 16:05:04 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm27128102ibh.10.2010.07.13.16.05.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:05:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279061452603-5290193.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150938>

Hi,

jhapk wrote:

> I manually enter the following lines in
> the .git/config files of A1 and A2
> [branch "branchA"]
>     remote = origin
>     merge = refs/heads/branchA
> 
> Then I create a branch in the bare repository B called branchA. Once this is
> done, all the push and pull works smoothly between the two repositories. 
> 
> Just wondering, is there a better way to do this? :)

Maybe something like the following would work.

>From A1:

  git checkout -b branchA
  ... hack hack hack ...
  git push --set-upstream origin branchA
  ssh A2

>From A2:

  git checkout -t origin/branchA
