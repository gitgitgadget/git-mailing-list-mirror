From: Manuel Doninger <manuel.doninger@googlemail.com>
Subject: Re: Git Architecture Question
Date: Tue, 28 Dec 2010 18:23:00 +0100
Message-ID: <AANLkTi=Rah9tTUE-vrAqosxqQbPhW8RpOgfEsB_dZJut@mail.gmail.com>
References: <20FFFEFA-5808-4673-B876-C5F76B52D12E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Anuj Gakhar <anuj.gakhar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 18:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXdGi-00013Q-Ia
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 18:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab0L1RXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 12:23:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42798 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0L1RXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 12:23:22 -0500
Received: by iyi12 with SMTP id 12so8264672iyi.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:dkim-signature
         :domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=GtvBEPiZqTXGzHdnHcdpKtwUjxsLCyZPr5FlKQIwPIE=;
        b=No+VwplFcOitH9+Uayy+5y06hDET7X1gDiv9Aw8BuGEigkIA8i6TN8SfAjuI+Pn1lI
         EMzCMEmETEysA8RZEunOCA+g2W29dqWbx1ym+fA9SBjlArc+YHKPM6nTAEVQBcpxYEYj
         nZAyLKpXMsm7aVcKaEN+exacjelaBxWc7YnUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        b=WIVURjRLpCKdoOuypMu+uYmwDudMd8usVjjwg1awyMS0BBrVQLhFMppFZOs5v1IgYY
         MFL5cjAjGxl4ybjz+Jh1XdDmxeFBn33NMNuS1y3C3sogySXuUFXUtQSuz10sHzRFMFuh
         hroKI2+g11GIHgBW3QJUU8FJWZ7INow8zpBHA=
Received: by 10.42.218.138 with SMTP id hq10mr13869191icb.364.1293557002253;
        Tue, 28 Dec 2010 09:23:22 -0800 (PST)
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
        by mx.google.com with ESMTPS id d21sm12334553ibg.15.2010.12.28.09.23.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 09:23:21 -0800 (PST)
Received: by iwn9 with SMTP id 9so9480038iwn.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 09:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=GtvBEPiZqTXGzHdnHcdpKtwUjxsLCyZPr5FlKQIwPIE=;
        b=njC4YTF0EzcgWEqGAKMenCfOLaiwZ8FiafyH7+yKCdUlQVwv8v5pS3gvmwBjALApbm
         AygqHl4X5ZfmEMxJ0VSVhEHOrdOOiGwjUHb3Hn8Hty6ybVzw0a87ImR9aFvkyq2YC/Ho
         Tcy84r4SwXL88jy/LW4My1fvWpWvfYPyNbgWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LaiXPzlQc570s4NNGNEdrooaTQNv6OwwDwsEqbmtQbkcBkA0XSa93z1k3G8J4XDeYN
         Yg+V1C8rzk90/a3jtGk/u8e2vP6qKfnE4mcVro9DkQka5Z/ax85AtiDf+cyaphF+D1Bm
         FbKW0wi+9iMYS0W2KPqnfu+Uo2ozoMXEIqueA=
Received: by 10.231.199.77 with SMTP id er13mr3390206ibb.44.1293557000882;
 Tue, 28 Dec 2010 09:23:20 -0800 (PST)
Received: by 10.231.19.6 with HTTP; Tue, 28 Dec 2010 09:23:00 -0800 (PST)
In-Reply-To: <20FFFEFA-5808-4673-B876-C5F76B52D12E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164276>

Hi Anuj,
i'm facing a similar problem at the moment.
In my company we want to switch from CVS to Git and Ant to
Maven/Hudson. We have a similar environment like you, Development,
Testing and Production, and my plan at the moment is to have a
development, testing and master branch. Every of these branches should
represent the appropriate environment. Then I configure Hudson with 3
jobs, every job to build one of these branches and to deploy to a
separete folder on our server.
If the developers then create a new change in a feature branch, we
would merge that feature branch into branch development for our
internal tests, then later merge that into testing for our QA
department if they say they want to test that change, and if they say
it's ok, merge that change into master to deploy it in production
environment.
This workflow is though not in production use, we evaluate this and
other workflows at the moment, so I don't have any experiences from
daily work.

Cheers,
Manuel
