From: Simon Strandgaard <neoneye@gmail.com>
Subject: Re: git gc - out of memory
Date: Sun, 15 Nov 2009 19:33:27 +0100
Message-ID: <df1390cc0911151033h2825053fxafe5bb2bb788fbb2@mail.gmail.com>
References: <df1390cc0911141126w1a0c5691p83885053a73f829@mail.gmail.com>
	 <hdp44d$4ml$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 19:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9jup-0006SN-Uj
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 19:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbZKOSdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbZKOSdY
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 13:33:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:35287 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbZKOSdX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 13:33:23 -0500
Received: by fg-out-1718.google.com with SMTP id d23so924937fga.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=AOjCwe4jOe6uGkItvuVhRYcXjyKzAQ6haiAE2eW2cho=;
        b=G0eIKdacS78+szKoBfj2e2qTOAL6z1/zhPSJa6aReiXyeoXjeaN3nYGavgtJOEczLc
         tnuxieE/h3Oc2yhzQs2yfIkbGUmXTL5nrMqD6xCbkkYFIQ2rZbBCieQ524gcc94WZ482
         nQ9P8TnIGlXKQYVLAsNJTzC3P9FkObM+ST9Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=WObLll1gmqrF6YJj3czO+LVp2HC+i4IYNDFtwPNfO+5B+dPOq/cYYtQwqza84Cg2dT
         ikBP6+TDPQJOLhu19or1ZE6Db4JXJ4o7EsKX0U/ErHoOQzBpicp7gnl2+9Iz2PH0w8uk
         sG/yfuU9eVSIz/OJhpQ7T2tLHyX3xk0pXG6zM=
Received: by 10.216.88.68 with SMTP id z46mr422772wee.27.1258310007745; Sun, 
	15 Nov 2009 10:33:27 -0800 (PST)
In-Reply-To: <hdp44d$4ml$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132950>

On Sun, Nov 15, 2009 at 3:44 PM, Alejandro Riveira <ariveira@gmail.com>=
 wrote:
> El Sat, 14 Nov 2009 20:26:00 +0100, Simon Strandgaard escribi=C3=B3:
[snip]
>> What can I do?
>
> run =C2=AB git repack -adf --window=3Dmemory =C2=BB on the repo where=
 memory is
> escaled apropiately for your machine ?

Thank you Alejandro, it now works!

I think the default is 10, so I tried with window=3D5 and
it completed a full repack.

$ git repack -adf --window=3D5
Counting objects: 5934, done.
Compressing objects: 100% (5711/5711), done.
Writing objects: 100% (5934/5934), done.
Total 5934 (delta 3733), reused 0 (delta 0)
Removing duplicate objects: 100% (256/256), done.
$ git gc
Counting objects: 5934, done.
Compressing objects: 100% (1978/1978), done.
Writing objects: 100% (5934/5934), done.
Total 5934 (delta 3733), reused 5934 (delta 3733)
$


Now that it works..
Should I report the original issue as a bug somewhere?
e.g. malloc failed sounds like a bug.



Kind regards
Simon Strandgaard - http://gdtoolbox.com/
