From: Alexander Nestorov <alexandernst@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 15:48:45 +0200
Message-ID: <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <vpqsj0fr19j.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 15:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowHr-0008Ru-6Z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 15:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730Ab3FRNt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 09:49:27 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:42064 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932679Ab3FRNt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 09:49:26 -0400
Received: by mail-qe0-f51.google.com with SMTP id a11so2449230qen.24
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=wpq0tQWko483VSb4PZsmq3R1R/VaN9BM5zG67XWNFC4=;
        b=NbMPzfv5dZpFMT/HDL1Z5zeVzSXshv2SAil/Zx0r/adrOnSlEa28FKPmCKM4HHadHh
         E3ONxLVFr0q5awBD+TuZovxen0Fod/o//5YFvZlOHfI7VHC0ldwPSgeHmLzFU7S+tH+T
         2xXtBiaCuX/CdRtO5xg0jn2ii/2UZl6Dwp1He9srsiZcTL4skW+FA814zGvcC/e7XziT
         PeFZUYwJzaw7LWuS+GQreF7B5wgRLltqBueNiwPpvpzDA4eeGBCcdtVA4ZZJ5cS2rZpD
         LjLSa8DG+fj9Vz6Gqb7w2pf9QwzSqsYbLYvXuRHG6LC3a7Slo4sGnc06/SxC9PsyZZHE
         tubA==
X-Received: by 10.229.106.230 with SMTP id y38mr8728881qco.21.1371563366217;
 Tue, 18 Jun 2013 06:49:26 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Tue, 18 Jun 2013 06:48:45 -0700 (PDT)
In-Reply-To: <vpqsj0fr19j.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228230>

Git does preserve file permissions, that is, git is aware of the
permissions you can set with chmod.

I'm not trying to ignore the x bit, what I'm trying to do is make
"git reset" checkout only the files that actually changed instead
of checking out all the files with different permissions than the
ones git thinks they should have.

Said with other word: when you run "git reset", git does a "status"
and checkouts all the files that showed up from the "status".
That's exactly what I'm trying to avoid, as "status" is aware of both
content changes and permissions changes.
