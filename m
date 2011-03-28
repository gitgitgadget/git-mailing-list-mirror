From: Chandra Sukiman <tmcchandra@gmail.com>
Subject: Reduce number of changes to pack file.
Date: Mon, 28 Mar 2011 11:33:20 +0800
Message-ID: <AANLkTimFKGrSCgBShtERaGfd=9y+=q-aHsN3u5Lvf52v@mail.gmail.com>
References: <AANLkTikqaD7QPCCw86OgGvCHLz1ySu5CzQXoY2rAojxB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 05:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q43Co-0004NI-GW
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 05:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab1C1DdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 23:33:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62083 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab1C1DdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 23:33:21 -0400
Received: by iyb14 with SMTP id 14so2663232iyb.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 20:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=i59Y1P/3wimbj6CIlZ1lWqwFRnjlzTMnz5TBa1gulWA=;
        b=YcolbCzihkcX0gsE9aOIUdoNpxd0tnJKaj0Rmo2MRjUj/6EZuCUltelT9bjGIRRQ+H
         0DHA//iqhqMLYWc94BUSbr7FbgJrr6QD8KqURoyqh8yfP0CxP0yRdQQWuZ8iq0JRB7yy
         Wbh7Qvj0C3gKYJeJzqOcRcRkiBjK9rYnHICTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=n5LnojnhO7nq66zExqitCVgHZTMUbuZSVN5zbVKIaOSHd6WjU1uPhKaRo+VX8+/+AC
         wPvpDo8Z+LXSEFCK80Iv6eGFWbDPF3UzZDUAGCSiJyBvtdJ/u979NyIQ4EdREEK4svf2
         fKqwiHPrG7jA1pGnEl8pU50l+66cTvd09dhhg=
Received: by 10.42.147.8 with SMTP id l8mr5888851icv.517.1301283201019; Sun,
 27 Mar 2011 20:33:21 -0700 (PDT)
Received: by 10.231.40.9 with HTTP; Sun, 27 Mar 2011 20:33:20 -0700 (PDT)
In-Reply-To: <AANLkTikqaD7QPCCw86OgGvCHLz1ySu5CzQXoY2rAojxB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170099>

Hi,

I am using git with Dropbox (see
http://stackoverflow.com/questions/1960799/using-gitdropbox-together-effectively).
Basically I created a bare repository at dropbox and everyone uses
that for central repository.
As the repository size is getting bigger, sometime during the git gc,
it will create a huge .pack file (300 mb) which need to be uploaded
and downloaded by everyone.
I tried to limit the size of the pack to 10m (pack.packSizeLimit =
10m), but when doing gc, what happens now is that most of the pack
files will get re-arranged and modified. This will cause the same
upload/download issue that I want to solve.

Is there any way for git gc to reduce the number of file changed?

Thank you

Chandra
