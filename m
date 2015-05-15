From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 0/2] fix http deadlock on giant ref negotiations
Date: Fri, 15 May 2015 11:11:17 +0200
Message-ID: <1431681077.14042.44.camel@kaarsemaker.net>
References: <20150513210436.GA7407@gmail.com>
	 <20150514004724.GA3059@peff.net> <20150515062901.GA30768@peff.net>
	 <1431675680.14042.39.camel@kaarsemaker.net>
	 <20150515083843.GA16910@peff.net>
	 <1431679490.14042.42.camel@kaarsemaker.net>
	 <20150515085355.GA18890@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 11:11:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtBeW-0004WY-1G
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 11:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbbEOJLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 05:11:24 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32810 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbEOJLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 05:11:20 -0400
Received: by wgin8 with SMTP id n8so105856341wgi.0
        for <git@vger.kernel.org>; Fri, 15 May 2015 02:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=tu18eR1R4dSvkbaeCS3xlLdaXkqZOAAUqoAVhqGD1o8=;
        b=DbN30y0dYQbATb9I16E3NUjljKaBvA9dyXDv350ia1ux/nz1VxFowaz2l82w4+RNd3
         nJjYNFnzisx9FfIXoMPuL9eoc+44FAOyfuM3+tqKM7BSeVPhQCxwHKcAtZq4vbYKUn4O
         kMptZ404cSrqlDPyV9JWrm8LBSvCPg+b9aH/exqzo/Denit/lobW4jHxqVmXF/qJVAHL
         CMp2YAeXt+zLP09+4Vsozh2I/mkORm6viz8ZLzQ4iWviAYz1XbRN7jgReOlhDtgsrJwS
         LiS4o7sqjEi0UiKKvYpZ/OdBylNNfjPu64LAT/v2aS39rYjEb0llPD2ztZn/voP0avt5
         Mqyg==
X-Gm-Message-State: ALoCoQn2rpOHgFqCUHR4y8mrGg3OWUA+XHwdyepjTE/gifciXRtUU9WKpS1hC04IqVXE+6p8DEdv
X-Received: by 10.180.90.72 with SMTP id bu8mr31391836wib.62.1431681079410;
        Fri, 15 May 2015 02:11:19 -0700 (PDT)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id k2sm1951455wif.3.2015.05.15.02.11.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 02:11:18 -0700 (PDT)
In-Reply-To: <20150515085355.GA18890@peff.net>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269138>

On vr, 2015-05-15 at 04:53 -0400, Jeff King wrote:
> I guess 1MB isn't enough for pathological cases.

$ git for-each-ref | wc -l 
59658

I'm not saying it's sensible, but this is a real repo I have to work
with.
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
