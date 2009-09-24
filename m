From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Wed, 23 Sep 2009 23:55:16 -0700 (PDT)
Message-ID: <314006.37617.qm@web27808.mail.ukl.yahoo.com>
References: <20734.77.61.241.211.1253773799.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Thu Sep 24 08:55:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqiEd-0003qG-M8
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 08:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbZIXGzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 02:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbZIXGzO
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 02:55:14 -0400
Received: from web27808.mail.ukl.yahoo.com ([217.146.182.13]:44224 "HELO
	web27808.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752041AbZIXGzN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2009 02:55:13 -0400
Received: (qmail 39422 invoked by uid 60001); 24 Sep 2009 06:55:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1253775316; bh=kCqt7ISSnSXw6lwMM/YN03kWw4FVt5Bx/Wcwcq13ID8=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=KFLuhqmqveh1/VIR7tI1hejFVyMDKTDziejSWkiu5+sgHae2yhBoCYc3bPCMlml3iRgpJvlVbOmz8L2U+mbx84L6JLFzA5aS6FoxITZwBaIrohL/rdyqEZrbywUU6Pj48mZB27gr15plJ8utlzKmliL+RpvA3EgqJGmxo0IzXAs=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=aDaOgJ+eWh8tmgedZGZn7MaW7EtOfCH6dryPiSt1wIA+HnFlB4qJBv3MtfvAwJfcU+ovw+SfnbZ7oUtlNEX9tFkZTONODAfprDToECn6fnGK7q30rIOdhmvLo4kPgcl/1R8YUEtS2uoNRvTypFLvF7tEjhLEj2Lr9nhWDKFEdJI=;
X-YMail-OSG: 7ZmN7soVM1njTYMHFLFxzKLpplOp4RssoiX6kAskbDiS9I4RG7dQB6ZzcBkZcUgGAq1ppApEy8zj6ZZZemyr0f3TA9Yto2o3CJ9JhFT0RZ31mmmJFSUvWw9vrpw7NUpEyGwcr8cadFaLdg4s4KmLhbpk8oy9Cf6f3v50vEIzfZXB63EhEh.p9FpGOtnYoCoDBQPYyRcT_rArpJAPWow_5mtwbcJj.Sj9sG2g5i8ZSt8L9xXefIXfiJYbfmqK0dsj4__M_H5nJ5szThmvZOlLm4jMln6j8gHFYIAV3_A.iGymX5daZjqn2slFLlU-
Received: from [81.16.153.112] by web27808.mail.ukl.yahoo.com via HTTP; Wed, 23 Sep 2009 23:55:16 PDT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.2
In-Reply-To: <20734.77.61.241.211.1253773799.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129025>

Hi Ferry!

I work on a lot of projects and having eclipse (or any other IDEs) project files in the SCM is almost ever causing a problem. In praxis those files are always dirty. There are so many settings which may be different from user to user

* different versions of eclipse create different project settings
* different JVM settings
* changing profiler settings
* using different version of various plugins
etc, etc

And with maven in place we don't need to have them in our SCM anymore. Plus: it works for a lot of IDEs

You can easily create the project files for a few IDEs with maven e.g.:
$> mvn eclipse:eclipse   for creating the eclipse project files
$> mvn idea:idea         for creating the idea project files

Additionally, plugins are available for Eclipse [1], Intellij Idea (native, builtin) and NetBeans (native, builtin).

So most of the time it is enough to simply import the parent pom.xml and you get all things setup properly in your IDE.

Or is there anything missing?

LieGrue,
strub

[1] http://m2eclipse.sonatype.org



--- On Thu, 9/24/09, Ferry Huberts <ferry.huberts@pelagic.nl> wrote:

> From: Ferry Huberts <ferry.huberts@pelagic.nl>
> Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: git@vger.kernel.org, spearce@spearce.org
> Date: Thursday, September 24, 2009, 8:29 AM
> Mark Struberg wrote:
> > All information necessary to build jgit is already
> available in
> > the maven pom.xmls.
> >
> 
> just out of curiosity, why would you remove the eclipse
> files?
> I for one - and I think many others - use Eclipse to work
> on the code...
> 


      
